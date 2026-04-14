#!/usr/bin/env bash
set -euo pipefail

alumnos=(
    foo bar baz zaz
)

for a in "${alumnos[@]}"; do
    printf "CREATE ROLE %s LOGIN PASSWORD '%s';\n" "$a" "$a"
done
echo

for a in "${alumnos[@]}"; do
    printf "CREATE DATABASE %s OWNER %s;\n" "$a" "$a"
done
echo

# DBs a las que los alumnos NO pueden conectarse.
restringidas=(
    australttdev australttprd australttqa invidious synapse
)

for d in "${restringidas[@]}"; do
    printf "REVOKE CONNECT ON DATABASE %s FROM PUBLIC;\n" "$d"
done
