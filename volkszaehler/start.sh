#!/usr/bin/env bashio
# ==============================================================================
# Home Assistant Community Add-on: volkszaehler-middleware
# starts volkszaehler-middleware
# ==============================================================================

/init.sh

exec /vz/vendor/bin/ppm start -c /vz/etc/middleware.json --static-directory /vz/htdocs --cgi-path=php