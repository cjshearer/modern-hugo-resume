#!/bin/bash
DOMAIN=${HOSTNAME}.$(tailscale status --json | jq -j '.MagicDNSSuffix')
if ! openssl x509 -checkend 0 -noout -in "${DOMAIN}".crt;
then
  sudo tailscale cert "${DOMAIN}"
fi
pnpm run dev \
  --baseURL "https://${DOMAIN}" \
  --bind "${HOSTNAME}" \
  --tlsCertFile "${DOMAIN}".crt \
  --tlsKeyFile "${DOMAIN}".key \
  "$@"
