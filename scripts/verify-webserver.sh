#!/usr/bin/env bash
set -euo pipefail

# Nginx web server verification - read-only checks only.
# Safe to run at any time; makes no configuration changes.

SITE_NAME="mysite"
DOMAIN="mysite.local"

echo "[1/5] Checking Nginx service status..."
systemctl is-active --quiet nginx && echo "  nginx: active" || echo "  nginx: NOT active"
systemctl is-enabled --quiet nginx && echo "  nginx: enabled on boot" || echo "  nginx: NOT enabled"

echo "[2/5] Validating configuration syntax..."
nginx -t

echo "[3/5] Checking listening ports..."
ss -tulpn | grep nginx || echo "  no nginx sockets found"

echo "[4/5] Checking UFW rules for web traffic..."
ufw status | grep -i nginx || echo "  no Nginx UFW rule found"

echo "[5/5] Testing local HTTP response..."
curl -s -o /dev/null -w "  HTTP status: %{http_code}\n" "http://localhost" || true

echo "Verification complete. Review any lines above marked NOT active/enabled or missing."