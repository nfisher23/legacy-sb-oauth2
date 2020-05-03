#!/bin/bash

BASIC_HEADER=$(echo -n "android-client:android-secret" | base64)
PASSWORD="noop" # hardcoded in app user details service
RES=$(curl -XPOST -v localhost:8080/oauth/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "Authorization: Basic YW5kcm9pZC1jbGllbnQ6YW5kcm9pZC1zZWNyZXQ=" \
  --data "grant_type=password&username=myuser&password=$PASSWORD&client_id=android-client&client_secret=android-secret")

echo $RES

TOKEN=$(echo $RES | jq -r ".access_token")

echo $TOKEN

curl -XGET "http://localhost:8080/actuator/health" -H "Authorization: Bearer $TOKEN"