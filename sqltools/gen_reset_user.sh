#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "uso: $0 <username>" >&2
    exit 1
fi

a="$1"

cat <<EOF
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = '$a' AND pid <> pg_backend_pid();

DROP DATABASE IF EXISTS $a;
DROP ROLE IF EXISTS $a;

CREATE ROLE $a LOGIN PASSWORD '$a';
CREATE DATABASE $a OWNER $a;
EOF
