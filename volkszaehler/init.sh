#!/usr/bin/env bashio
# ==============================================================================
# Home Assistant Community Add-on: volkszaehler-middleware
# Configures volkszaehler-middleware
# ==============================================================================

bashio::log.info "Start"

declare host
declare password
declare port
declare username
declare database

host=$(bashio::services "mysql" "host")
password=$(bashio::services "mysql" "password")
port=$(bashio::services "mysql" "port")
username=$(bashio::services "mysql" "username")

bashio::log.info "Got configs"

database=$(\
    mysql \
        -u "${username}" -p"${password}" \
        -h "${host}" -P "${port}" \
        --skip-column-names \
        -e "SHOW DATABASES LIKE 'volkszaehler';"
)


if ! bashio::var.has_value "${database}"; then
    bashio::log.info "Creating database and user for volkszaehler"
    mysql \
        -u "${username}" -p"${password}" \
        -h "${host}" -P "${port}" \
            < /sql/init.sql
fi

bashio::log.info "Updating config"
sed -i s/localhost/"${host}"/ /vz/etc/config.yaml
sed -i s/vz_admin/"${username}"/ /vz/etc/config.yaml
sed -i s/admin_demo/"${password}"/ /vz/etc/config.yaml

bashio::log.info "running doctrine"
pushd /vz || return
./bin/doctrine orm:schema-tool:update --force || ./bin/doctrine orm:schema-tool:create
