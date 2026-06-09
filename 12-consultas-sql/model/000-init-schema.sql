-- ************************************************************
-- 000-init-schema.sql
--
-- Migración inicial de la clase 12 (Consultas SQL).
-- Crea la tabla de control de migraciones y el modelo base
-- completo.
--
-- Modelo: registro de cursos de universidad.
-- Convención: la PK de cada tabla es <tabla>_id y las FK reusan
-- ese mismo nombre, para poder unir con JOIN ... USING (...).
-- ************************************************************

-- Crea el schema del curso y trabaja dentro de él.
CREATE SCHEMA IF NOT EXISTS universidad;
SET search_path TO universidad;

-- Tabla de control de versiones del esquema
CREATE TABLE schema_migrations (
    version TEXT PRIMARY KEY,
    applied_at TIMESTAMP DEFAULT now()
);

CREATE TABLE alumno (alumno_id SERIAL PRIMARY KEY, nombre TEXT NOT NULL);

CREATE TABLE profesor (profesor_id SERIAL PRIMARY KEY, nombre TEXT NOT NULL);

CREATE TABLE curso (
    curso_id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    profesor_id INTEGER NOT NULL
);

CREATE INDEX idx_curso__profesor ON curso (profesor_id);

ALTER TABLE curso
ADD CONSTRAINT fk_curso__profesor FOREIGN KEY (
    profesor_id
) REFERENCES profesor (profesor_id) ON DELETE CASCADE;

CREATE TABLE alumno_curso (
    alumno_id INTEGER NOT NULL,
    curso_id INTEGER NOT NULL,
    PRIMARY KEY (alumno_id, curso_id)
);

CREATE INDEX idx_alumno_curso ON alumno_curso (curso_id);

ALTER TABLE alumno_curso
ADD CONSTRAINT fk_alumno_curso__alumno FOREIGN KEY (
    alumno_id
) REFERENCES alumno (alumno_id);

ALTER TABLE alumno_curso
ADD CONSTRAINT fk_alumno_curso__curso FOREIGN KEY (
    curso_id
) REFERENCES curso (curso_id);

CREATE TABLE sala (
    sala_id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    capacidad INTEGER NOT NULL
);

CREATE TABLE horario (
    horario_id SERIAL PRIMARY KEY,
    dia TEXT NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    sala_id INTEGER NOT NULL,
    curso_id INTEGER NOT NULL
);

CREATE INDEX idx_horario__curso ON horario (curso_id);

CREATE INDEX idx_horario__sala ON horario (sala_id);

ALTER TABLE horario ADD CONSTRAINT fk_horario__curso FOREIGN KEY (
    curso_id
) REFERENCES curso (curso_id) ON DELETE CASCADE;
ALTER TABLE horario ADD CONSTRAINT fk_horario__sala FOREIGN KEY (
    sala_id
) REFERENCES sala (sala_id) ON DELETE CASCADE;

-- Registro de versión si es que la migración corre exitosamente
INSERT INTO schema_migrations (version) VALUES ('000-init-schema');
