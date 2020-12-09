#!/usr/bin/env bash

set -e

DATA_DIR=${DATA_DIR:-/tmp}
CONFIG_FILE=${CONFIG_FILE:-$DATA_DIR/config.toml}
RUNNER_EXECUTOR=${RUNNER_EXECUTOR:-shell}

if [[ -n "${DEBUG}" ]]; then
    echo "** Running in DEBUG mode **"
    id
    echo "DATA_DIR = ${DATA_DIR}"
    echo "CONFIG_FILE = ${CONFIG_FILE}"
    echo "RUNNER_EXECUTOR = ${RUNNER_EXECUTOR}"
    options="--debug"
    set -x
fi

touch "${CONFIG_FILE}"

# register the runner
if [[ -n "${CI_SERVER_URL}" && -n "${REGISTRATION_TOKEN}" ]]; then
    gitlab-runner ${options} register --non-interactive --config="${CONFIG_FILE}" --executor="${RUNNER_EXECUTOR}"
fi

# custom certificate authority path
CA_CERTIFICATES_PATH=${CA_CERTIFICATES_PATH:-$DATA_DIR/certs/ca.crt}
LOCAL_CA_PATH="/usr/local/share/ca-certificates/ca.crt"

update_ca() {
  echo "Updating CA certificates..."
  cp "${CA_CERTIFICATES_PATH}" "${LOCAL_CA_PATH}"
  update-ca-certificates --fresh >/dev/null
}

if [ -f "${CA_CERTIFICATES_PATH}" ]; then
  # update the ca if the custom ca is different than the current
  cmp --silent "${CA_CERTIFICATES_PATH}" "${LOCAL_CA_PATH}" || update_ca
fi

# launch gitlab-runner
exec gitlab-runner ${options} run --config="${CONFIG_FILE}" --working-directory="${DATA_DIR}"
