SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'foo' AND pid <> pg_backend_pid();

DROP DATABASE IF EXISTS foo;
DROP ROLE IF EXISTS foo;

CREATE ROLE foo LOGIN PASSWORD 'foo';
CREATE DATABASE foo OWNER foo;
