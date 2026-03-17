DO $$ 
DECLARE 
    alumno TEXT;
    alumnos TEXT[] := ARRAY[
        'denissem', 'benjaminu', 'maxc', 'samueld', 'rigobertoa', 'angelor',
        'bastians', 'tomass', 'cristoferl', 'alonsod', 'joaquing', 'miguelr',
        'matiasr', 'agustino', 'andresh', 'benjaminm', 'sebastianc', 'hectorm',
        'benjamino', 'cristofern', 'angelv', 'feliped', 'joaquingg', 'benjamint', 'cristofernn'
    ];
BEGIN
    FOREACH alumno IN ARRAY alumnos LOOP
        EXECUTE format('CREATE ROLE %I WITH LOGIN PASSWORD %L;', alumno, 'contraseña_segura');
    END LOOP;
END $$;

CREATE DATABASE agustino OWNER agustino;
CREATE DATABASE alonsod OWNER alonsod;
CREATE DATABASE andresh OWNER andresh;
CREATE DATABASE angelor OWNER angelor;
CREATE DATABASE angelv OWNER angelv;
CREATE DATABASE bastians OWNER bastians;
CREATE DATABASE benjaminm OWNER benjaminm;
CREATE DATABASE benjamino OWNER benjamino;
CREATE DATABASE benjamint OWNER benjamint;
CREATE DATABASE benjaminu OWNER benjaminu;
CREATE DATABASE cristoferl OWNER cristoferl;
CREATE DATABASE cristofern OWNER cristofern;
CREATE DATABASE cristofernn OWNER cristofernn;
CREATE DATABASE denissem OWNER denissem;
CREATE DATABASE feliped OWNER feliped;
CREATE DATABASE hectorm OWNER hectorm;
CREATE DATABASE joaquing OWNER joaquing;
CREATE DATABASE joaquingg OWNER joaquingg;
CREATE DATABASE matiasr OWNER matiasr;
CREATE DATABASE maxc OWNER maxc;
CREATE DATABASE miguelr OWNER miguelr;
CREATE DATABASE rigobertoa OWNER rigobertoa;
CREATE DATABASE samueld OWNER samueld;
CREATE DATABASE sebastianc OWNER sebastianc;
CREATE DATABASE tomass OWNER tomass;

DO $$ 
DECLARE 
    alumno TEXT;
    alumnos TEXT[] := ARRAY[
        'denissem', 'benjaminu', 'maxc', 'samueld', 'rigobertoa', 'angelor',
        'bastians', 'tomass', 'cristoferl', 'alonsod', 'joaquing', 'miguelr',
        'matiasr', 'agustino', 'andresh', 'benjaminm', 'sebastianc', 'hectorm',
        'benjamino', 'cristofern', 'angelv', 'feliped', 'joaquingg', 'benjamint', 'cristofernn'
    ];
BEGIN
    FOREACH alumno IN ARRAY alumnos LOOP
        -- Permitir que el usuario "postgres" tenga control total sobre la DB del alumno
        EXECUTE format('GRANT ALL PRIVILEGES ON DATABASE %I TO postgres;', alumno);

        -- Revocar permisos de conexión para PUBLIC
        EXECUTE format('REVOKE CONNECT ON DATABASE %I FROM PUBLIC;', alumno);

        -- Permitir que el alumno pueda conectarse y trabajar en su DB
        EXECUTE format('GRANT CONNECT, TEMPORARY ON DATABASE %I TO %I;', alumno, alumno);
        EXECUTE format('GRANT USAGE ON SCHEMA public TO %I;', alumno);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO %I;', alumno);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO %I;', alumno);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO %I;', alumno);
    END LOOP;
END $$;

