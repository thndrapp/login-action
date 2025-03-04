# Bytebase Login Action

Use this action to log in to your Bytebase server in the GitHub CI.

## Inputs

| Name           | Description                                                 | Required | Default |
|----------------|-------------------------------------------------------------|----------|---------|
| `bytebase-url` | The Bytebase instance URL, should be the Bytebase external URL | true     |         |
| `api-version`  | Bytebase API version                                         | false    | `v1`    |
| `service-key`  | The Bytebase service account key                              | true     |         |
| `service-secret`| The Bytebase service account secret                           | true     |         |

## Outputs

| Name      | Description                                          |
|-----------|------------------------------------------------------|
| `token`   | The API token obtained from bytebase/login action    |
| `api_url` | The Bytebase API URL with version                    |

## Usage Example

```yml
on:
  push:
    branches:
      - main
  workflow_dispatch:
  pull_request:

jobs:
  bytebase-ci:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Login Bytebase
        id: bytebase-login
        uses: bytebase/login-action@v1
        with:
          bytebase-url: ${{ secrets.BYTEBASE_URL }}
          service-key: ${{ secrets.BYTEBASE_SERVICE_KEY }}
          service-secret: ${{ secrets.BYTEBASE_SERVICE_SECRET }}
      - name: List projects
        run: |
          curl "${{ steps.bytebase-login.outputs.api_url }}/projects" \
            -H 'Authorization: Bearer ${{ steps.bytebase-login.outputs.token }}' \
            -H 'Content-Type: application/json; charset=utf-8'
```
