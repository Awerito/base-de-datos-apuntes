-- Script para reiniciar un usuario y su base de datos en PostgreSQL
DO $$ 
DECLARE 
    alumno TEXT := 'nombre_del_alumno';
BEGIN
    -- 1. Terminar conexiones activas a la DB del alumno
    EXECUTE format('SELECT pg_terminate_backend(pg_stat_activity.pid) 
                    FROM pg_stat_activity 
                    WHERE pg_stat_activity.datname = %L 
                    AND pid <> pg_backend_pid();', alumno);

    -- 2. Eliminar la base de datos si existe
    EXECUTE format('DROP DATABASE IF EXISTS %I;', alumno);

    -- 3. Eliminar el usuario si existe
    EXECUTE format('DROP ROLE IF EXISTS %I;', alumno);

    -- 4. Crear el usuario nuevamente con una nueva contraseña
    EXECUTE format('CREATE ROLE %I WITH LOGIN PASSWORD ''%s'';', alumno, 'nueva_contraseña_segura');

    -- 5. Crear la base de datos con el mismo nombre del usuario
    EXECUTE format('CREATE DATABASE %I OWNER %I;', alumno, alumno);

    -- 6. Asignar permisos nuevamente
    EXECUTE format('GRANT ALL PRIVILEGES ON DATABASE %I TO postgres;', alumno);
    EXECUTE format('REVOKE ALL ON DATABASE %I FROM PUBLIC;', alumno);
    EXECUTE format('GRANT CONNECT, TEMPORARY ON DATABASE %I TO %I;', alumno, alumno);
    EXECUTE format('GRANT ALL PRIVILEGES ON SCHEMA public TO %I;', alumno);
END $$;
