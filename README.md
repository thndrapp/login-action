# Bytebase Login Action

Use this action to log in to your Bytebase server in the GitHub CI.

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
      - uses: actions/checkout@v3
      - name: Login Bytebase
        id: bytebase-login
        uses: bytebase/login-action@main
        with:
          bytebase-url: ${{ secrets.BYTEBASE_URL }}
          service-key: ${{ secrets.BYTEBASE_SERVICE_KEY }}
          service-secret: ${{ secrets.BYTEBASE_SERVICE_SECRET }}
      - name: Output
        run: |
          echo "[DONOT DO THIS IN PROD] the token is: ${{ steps.bytebase-login.outputs.token }}"
```
