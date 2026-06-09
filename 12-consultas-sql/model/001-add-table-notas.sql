-- ************************************************************
-- 001-add-table-notas.sql
--
-- Agrega la tabla `nota`: varias evaluaciones por (alumno, curso),
-- con valor numérico y fecha. Da los datos numéricos/temporales que
-- necesitan los ejemplos de agregados y funciones ventana.
-- ************************************************************

SET search_path TO universidad;

CREATE TABLE nota (
    nota_id SERIAL PRIMARY KEY,
    alumno_id INTEGER NOT NULL REFERENCES alumno (alumno_id),
    curso_id INTEGER NOT NULL REFERENCES curso (curso_id),
    evaluacion TEXT NOT NULL,        -- 'Prueba 1', 'Prueba 2', 'Examen'
    nota DECIMAL(3, 1) NOT NULL CHECK (nota BETWEEN 1.0 AND 7.0),
    fecha DATE NOT NULL
);

CREATE INDEX idx_nota__alumno ON nota (alumno_id);
CREATE INDEX idx_nota__curso ON nota (curso_id);

INSERT INTO schema_migrations (version) VALUES ('001-add-table-notas');
