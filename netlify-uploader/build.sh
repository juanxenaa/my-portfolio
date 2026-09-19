#!/usr/bin/env bash
set -euo pipefail
rm -rf .pkg dist package.zip
mkdir -p .pkg dist
cat ../algonova_parts/part*.txt | tr -d '\r\n' | base64 -d > package.zip
unzip -q package.zip -d .pkg
python3 - <<'PY'
from pathlib import Path
p=Path('.pkg/report-uploader/config.js')
s=p.read_text()
s=s.replace('PASTE_APPS_SCRIPT_WEB_APP_URL_HERE', 'https://script.google.com/macros/s/AKfycbwZNGy2aK0cSEA7JktJZHbR-lv6BdLLLBK8_JRyCus7m7L7o1XkzjDar-qPOcc8i4XZ/exec')
s=s.replace('parentDashboardUrl: ""', 'parentDashboardUrl: "https://algonova-parent-dashboard.netlify.app"')
p.write_text(s)
PY
cp -R .pkg/report-uploader/. dist/
