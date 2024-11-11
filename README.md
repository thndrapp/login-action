# Bytebase Login Action

Use this action to login to your Bytebase server in the GitHub CI.

## Usage Example

```yml
on: [pull_request]

jobs:
  bytebase-login:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Login Bytebase
        uses: bytebase/bytebase-login-action@main
        with:
          bytebase-url: "<Your Bytebase server external URL>"
          service-key: ${{ secrets.BYTEBASE_SERVICE_KEY }}
          service-secret: ${{ secrets.BYTEBASE_SERVICE_SECRET }}
```
