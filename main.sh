#!/bin/bash
# ===========================================================================
# File: main.sh
# Description: usage: ./main.sh --url=[url] --version=[version] --service-key=[service key] --service-secret=[service secret]
# ===========================================================================

# Get parameters
for i in "$@"
do
case $i in
    --url=*)
    URL="${i#*=}"
    shift
    ;;
    --version=*)
    VERSION="${i#*=}"
    shift
    ;;
    --service-key=*)
    SERVICE_KEY="${i#*=}"
    shift
    ;;
    --service-secret=*)
    SERVICE_SECRET="${i#*=}"
    shift
    ;;
    *) # unknown option
    ;;
esac
done

API_URL="$URL/$VERSION/auth/login"
ACTION_VERSION=`cat $GITHUB_ACTION_PATH/VERSION`
REPOSITORY=`echo $GITHUB_REPOSITORY | tr '[:upper:]' '[:lower:]'`
ACTOR=`echo $GITHUB_ACTOR | tr '[:upper:]' '[:lower:]'`

request_body=$(jq -n \
    --arg email "$SERVICE_KEY" \
    --arg password "$SERVICE_SECRET" \
    '$ARGS.named')
response=$(curl -s -w "\n%{http_code}" -X POST $API_URL \
  -H "X-Platform: GitHub" \
  -H "X-Repository: $REPOSITORY" \
  -H "X-Actor: $ACTOR" \
  -H "X-Version: $ACTION_VERSION" \
  -H "X-Source: action" \
  -H "Content-Type: application/json" \
  -d "$request_body")

http_code=$(tail -n1 <<< "$response")
body=$(sed '$ d' <<< "$response")
echo "::debug::response code: $http_code, response body: $body"

if [ $http_code != 200 ]; then
    echo ":error::Failed to login with response code $http_code and body $body"
    exit 1
fi

token=`echo $body | jq -r ".token"`
echo "token=$token" >> $GITHUB_OUTPUT