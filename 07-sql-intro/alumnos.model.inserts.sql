-- ************************************************************
-- Antares - SQL Client
-- Version 0.7.35-beta.0
-- 
-- https://antares-sql.app/
-- https://github.com/antares-sql/antares
-- 
-- Host: postgres.grye.org (PostgreSQL 17.4)
-- Database: public
-- Generation time: 2025-04-16T15:18:10-04:00
-- ************************************************************


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;



DROP SEQUENCE IF EXISTS "public"."alumno_id_seq" CASCADE;
DROP SEQUENCE IF EXISTS "public"."curso_id_seq" CASCADE;
DROP SEQUENCE IF EXISTS "public"."horario_id_seq" CASCADE;
DROP SEQUENCE IF EXISTS "public"."profesor_id_seq" CASCADE;
DROP SEQUENCE IF EXISTS "public"."sala_id_seq" CASCADE;

DROP TABLE IF EXISTS "public"."alumno" CASCADE;

-- Dump of table alumno
-- ------------------------------------------------------------


CREATE SEQUENCE "public"."alumno_id_seq"
   START WITH 1
   INCREMENT BY 1
   MINVALUE 1
   MAXVALUE 2147483647
   CACHE 1;

CREATE TABLE "public"."alumno"(
   "id" integer DEFAULT nextval('public.alumno_id_seq'::regclass) NOT NULL,
   "nombre" text NOT NULL,
   CONSTRAINT "alumno_pkey" PRIMARY KEY ("id")
);



INSERT INTO "public"."alumno" ("id", "nombre") VALUES (1, 'Juan Pérez');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (2, 'María González');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (3, 'Carlos López');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (4, 'Ana Martínez');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (5, 'Luis Rodríguez');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (6, 'Pedro Sánchez');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (7, 'Laura García');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (8, 'José Fernández');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (9, 'Marta Gómez');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (10, 'Javier Díaz');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (11, 'Sofía Valdivia');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (12, 'Tomás Riquelme');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (13, 'Isidora Fuentes');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (14, 'Benjamín Toro');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (15, 'Josefa Lagos');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (16, 'Lucas Araya');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (17, 'Renata Palma');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (18, 'Martín Navarrete');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (19, 'Sofía Valdivia');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (20, 'Tomás Riquelme');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (21, 'Isidora Fuentes');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (22, 'Benjamín Toro');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (23, 'Josefa Lagos');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (24, 'Lucas Araya');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (25, 'Renata Palma');
INSERT INTO "public"."alumno" ("id", "nombre") VALUES (26, 'Martín Navarrete');




-- Dump of table alumno_curso
-- ------------------------------------------------------------

DROP TABLE IF EXISTS "public"."alumno_curso" CASCADE;

CREATE TABLE "public"."alumno_curso"(
   "alumno" integer NOT NULL,
   "curso" integer NOT NULL,
   CONSTRAINT "alumno_curso_pkey" PRIMARY KEY ("alumno", "curso")
);

CREATE INDEX "idx_alumno_curso" ON "public"."alumno_curso" ("curso");


INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (1, 1);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (1, 2);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (2, 3);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (2, 4);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (3, 5);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (3, 6);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (4, 7);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (4, 8);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (5, 9);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (5, 10);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (6, 1);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (6, 4);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (7, 2);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (7, 6);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (8, 3);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (8, 7);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (9, 5);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (9, 8);
INSERT INTO "public"."alumno_curso" ("alumno", "curso") VALUES (10, 9);




-- Dump of table curso
-- ------------------------------------------------------------

DROP TABLE IF EXISTS "public"."curso" CASCADE;

CREATE SEQUENCE "public"."curso_id_seq"
   START WITH 1
   INCREMENT BY 1
   MINVALUE 1
   MAXVALUE 2147483647
   CACHE 1;

CREATE TABLE "public"."curso"(
   "id" integer DEFAULT nextval('public.curso_id_seq'::regclass) NOT NULL,
   "nombre" text NOT NULL,
   "profesor" integer NOT NULL,
   CONSTRAINT "curso_pkey" PRIMARY KEY ("id")
);

CREATE INDEX "idx_curso__profesor" ON "public"."curso" ("profesor");


INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (1, 'Matemáticas', 1);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (2, 'Física', 2);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (3, 'Química', 3);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (4, 'Literatura', 4);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (5, 'Historia', 5);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (6, 'Biología', 1);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (7, 'Geografía', 2);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (8, 'Filosofía', 3);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (9, 'Inglés', 4);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (10, 'Programación', 5);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (11, 'Fotografía Digital', 1);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (12, 'Inteligencia Artificial', 2);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (13, 'Diseño UX/UI', 3);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (14, 'Producción Musical', 4);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (15, 'Taller de Escritura', 5);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (16, 'Cómic y Narrativa', 1);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (17, 'Iniciación al Japonés', 2);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (18, 'Introducción a Blockchain', 3);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (19, 'Fotografía Digital', 1);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (20, 'Inteligencia Artificial', 2);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (21, 'Diseño UX/UI', 3);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (22, 'Producción Musical', 4);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (23, 'Taller de Escritura', 5);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (24, 'Cómic y Narrativa', 1);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (25, 'Iniciación al Japonés', 2);
INSERT INTO "public"."curso" ("id", "nombre", "profesor") VALUES (26, 'Introducción a Blockchain', 3);




-- Dump of table horario
-- ------------------------------------------------------------

DROP TABLE IF EXISTS "public"."horario" CASCADE;

CREATE SEQUENCE "public"."horario_id_seq"
   START WITH 1
   INCREMENT BY 1
   MINVALUE 1
   MAXVALUE 2147483647
   CACHE 1;

CREATE TABLE "public"."horario"(
   "id" integer DEFAULT nextval('public.horario_id_seq'::regclass) NOT NULL,
   "dia" text NOT NULL,
   "hora_inicio" time without time zone NOT NULL,
   "hora_fin" time without time zone NOT NULL,
   "sala" integer NOT NULL,
   "curso" integer NOT NULL,
   CONSTRAINT "horario_pkey" PRIMARY KEY ("id")
);

CREATE INDEX "idx_horario__curso" ON "public"."horario" ("curso");
CREATE INDEX "idx_horario__sala" ON "public"."horario" ("sala");


INSERT INTO "public"."horario" ("id", "dia", "hora_inicio", "hora_fin", "sala", "curso") VALUES (1, 'Lunes', '08:00:00', '10:00:00', 1, 1);
INSERT INTO "public"."horario" ("id", "dia", "hora_inicio", "hora_fin", "sala", "curso") VALUES (2, 'Lunes', '10:00:00', '12:00:00', 2, 2);
INSERT INTO "public"."horario" ("id", "dia", "hora_inicio", "hora_fin", "sala", "curso") VALUES (3, 'Martes', '08:00:00', '10:00:00', 3, 3);
INSERT INTO "public"."horario" ("id", "dia", "hora_inicio", "hora_fin", "sala", "curso") VALUES (4, 'Martes', '10:00:00', '12:00:00', 4, 4);
INSERT INTO "public"."horario" ("id", "dia", "hora_inicio", "hora_fin", "sala", "curso") VALUES (5, 'Miércoles', '08:00:00', '10:00:00', 5, 5);
INSERT INTO "public"."horario" ("id", "dia", "hora_inicio", "hora_fin", "sala", "curso") VALUES (6, 'Miércoles', '10:00:00', '12:00:00', 1, 6);
INSERT INTO "public"."horario" ("id", "dia", "hora_inicio", "hora_fin", "sala", "curso") VALUES (7, 'Jueves', '08:00:00', '10:00:00', 2, 7);
INSERT INTO "public"."horario" ("id", "dia", "hora_inicio", "hora_fin", "sala", "curso") VALUES (8, 'Jueves', '10:00:00', '12:00:00', 3, 8);
INSERT INTO "public"."horario" ("id", "dia", "hora_inicio", "hora_fin", "sala", "curso") VALUES (9, 'Viernes', '08:00:00', '10:00:00', 4, 9);
INSERT INTO "public"."horario" ("id", "dia", "hora_inicio", "hora_fin", "sala", "curso") VALUES (10, 'Viernes', '10:00:00', '12:00:00', 5, 10);




-- Dump of table profesor
-- ------------------------------------------------------------

DROP TABLE IF EXISTS "public"."profesor" CASCADE;

CREATE SEQUENCE "public"."profesor_id_seq"
   START WITH 1
   INCREMENT BY 1
   MINVALUE 1
   MAXVALUE 2147483647
   CACHE 1;

CREATE TABLE "public"."profesor"(
   "id" integer DEFAULT nextval('public.profesor_id_seq'::regclass) NOT NULL,
   "nombre" text NOT NULL,
   CONSTRAINT "profesor_pkey" PRIMARY KEY ("id")
);



INSERT INTO "public"."profesor" ("id", "nombre") VALUES (1, 'Prof. Juan Hernández');
INSERT INTO "public"."profesor" ("id", "nombre") VALUES (2, 'Prof. Elena Ruiz');
INSERT INTO "public"."profesor" ("id", "nombre") VALUES (3, 'Prof. Andrés Jiménez');
INSERT INTO "public"."profesor" ("id", "nombre") VALUES (4, 'Prof. Carmen Vargas');
INSERT INTO "public"."profesor" ("id", "nombre") VALUES (5, 'Prof. Sergio Pérez');




-- Dump of table sala
-- ------------------------------------------------------------

DROP TABLE IF EXISTS "public"."sala" CASCADE;

CREATE SEQUENCE "public"."sala_id_seq"
   START WITH 1
   INCREMENT BY 1
   MINVALUE 1
   MAXVALUE 2147483647
   CACHE 1;

CREATE TABLE "public"."sala"(
   "id" integer DEFAULT nextval('public.sala_id_seq'::regclass) NOT NULL,
   "nombre" text NOT NULL,
   "capacidad" integer NOT NULL,
   CONSTRAINT "sala_pkey" PRIMARY KEY ("id")
);



INSERT INTO "public"."sala" ("id", "nombre", "capacidad") VALUES (1, 'Sala A', 30);
INSERT INTO "public"."sala" ("id", "nombre", "capacidad") VALUES (2, 'Sala B', 25);
INSERT INTO "public"."sala" ("id", "nombre", "capacidad") VALUES (3, 'Sala C', 20);
INSERT INTO "public"."sala" ("id", "nombre", "capacidad") VALUES (4, 'Sala D', 35);
INSERT INTO "public"."sala" ("id", "nombre", "capacidad") VALUES (5, 'Sala E', 40);





ALTER TABLE ONLY "public"."alumno_curso"
   ADD CONSTRAINT "fk_alumno_curso__alumno" FOREIGN KEY ("alumno") REFERENCES "public"."alumno" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE ONLY "public"."alumno_curso"
   ADD CONSTRAINT "fk_alumno_curso__curso" FOREIGN KEY ("curso") REFERENCES "public"."curso" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE ONLY "public"."curso"
   ADD CONSTRAINT "fk_curso__profesor" FOREIGN KEY ("profesor") REFERENCES "public"."profesor" ("id") ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE ONLY "public"."horario"
   ADD CONSTRAINT "fk_horario__curso" FOREIGN KEY ("curso") REFERENCES "public"."curso" ("id") ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE ONLY "public"."horario"
   ADD CONSTRAINT "fk_horario__sala" FOREIGN KEY ("sala") REFERENCES "public"."sala" ("id") ON UPDATE NO ACTION ON DELETE CASCADE;


-- Dump of functions
-- ------------------------------------------------------------






-- Dump completed on 2025-04-16T15:18:12-04:00
