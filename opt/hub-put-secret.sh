#!/usr/bin/env sh
set -eu

main() {
  local repoName="$1" secretKey="$2" secretVal="$3"
  local pubkey="$(hub api -X GET /repos/$repoName/actions/secrets/public-key)"
  local keyId="$(echo "$pubkey" | jq -r .key_id 2>/dev/null)"
  local key="$(echo "$pubkey" | jq -r .key 2>/dev/null)"
  if [[ -z "$keyId" ]] || [[ -z "$key" ]]; then
    exit 1
  fi
  local encVal="$(node /opt/encrypt.js "$key" "$secretVal")"
  hub api -X PUT "/repos/${repoName}/actions/secrets/${secretKey}" -f "key_id=$keyId" -f "encrypted_value=$encVal"
}

main "$@"
