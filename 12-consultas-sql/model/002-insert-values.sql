-- ************************************************************
-- 002-insert-values.sql
--
-- Carga los datos de todo el modelo: tablas base + nota.
-- El orden respeta las llaves foráneas (primero las tablas
-- referenciadas, luego las que apuntan a ellas).
--
-- Solo datos (DML).
-- ************************************************************

SET search_path TO universidad;

-- profesor
INSERT INTO profesor (profesor_id, nombre) VALUES
(1, 'Prof. Juan Hernández'),
(2, 'Prof. Elena Ruiz'),
(3, 'Prof. Andrés Jiménez'),
(4, 'Prof. Carmen Vargas'),
(5, 'Prof. Sergio Pérez');

-- alumno
INSERT INTO alumno (alumno_id, nombre) VALUES
(1, 'Juan Pérez'),
(2, 'María González'),
(3, 'Carlos López'),
(4, 'Ana Martínez'),
(5, 'Luis Rodríguez'),
(6, 'Pedro Sánchez'),
(7, 'Laura García'),
(8, 'José Fernández'),
(9, 'Marta Gómez'),
(10, 'Javier Díaz'),
(11, 'Sofía Valdivia'),
(12, 'Tomás Riquelme'),
(13, 'Isidora Fuentes'),
(14, 'Benjamín Toro'),
(15, 'Josefa Lagos'),
(16, 'Lucas Araya'),
(17, 'Renata Palma'),
(18, 'Martín Navarrete'),
(19, 'Sofía Valdivia'),
(20, 'Tomás Riquelme'),
(21, 'Isidora Fuentes'),
(22, 'Benjamín Toro'),
(23, 'Josefa Lagos'),
(24, 'Lucas Araya'),
(25, 'Renata Palma'),
(26, 'Martín Navarrete');

-- sala
INSERT INTO sala (sala_id, nombre, capacidad) VALUES
(1, 'Sala A', 30),
(2, 'Sala B', 25),
(3, 'Sala C', 20),
(4, 'Sala D', 35),
(5, 'Sala E', 40);

-- curso
INSERT INTO curso (curso_id, nombre, profesor_id) VALUES
(1, 'Matemáticas', 1),
(2, 'Física', 2),
(3, 'Química', 3),
(4, 'Literatura', 4),
(5, 'Historia', 5),
(6, 'Biología', 1),
(7, 'Geografía', 2),
(8, 'Filosofía', 3),
(9, 'Inglés', 4),
(10, 'Programación', 5),
(11, 'Fotografía Digital', 1),
(12, 'Inteligencia Artificial', 2),
(13, 'Diseño UX/UI', 3),
(14, 'Producción Musical', 4),
(15, 'Taller de Escritura', 5),
(16, 'Cómic y Narrativa', 1),
(17, 'Iniciación al Japonés', 2),
(18, 'Introducción a Blockchain', 3),
(19, 'Fotografía Digital', 1),
(20, 'Inteligencia Artificial', 2),
(21, 'Diseño UX/UI', 3),
(22, 'Producción Musical', 4),
(23, 'Taller de Escritura', 5),
(24, 'Cómic y Narrativa', 1),
(25, 'Iniciación al Japonés', 2),
(26, 'Introducción a Blockchain', 3);

-- alumno_curso
INSERT INTO alumno_curso (alumno_id, curso_id) VALUES
(1, 1), (1, 2),
(2, 3), (2, 4),
(3, 5), (3, 6),
(4, 7), (4, 8),
(5, 9), (5, 10),
(6, 1), (6, 4),
(7, 2), (7, 6),
(8, 3), (8, 7),
(9, 5), (9, 8),
(10, 9);

-- horario
INSERT INTO horario (horario_id, dia, hora_inicio, hora_fin, sala_id, curso_id) VALUES
(1, 'Lunes', '08:00:00', '10:00:00', 1, 1),
(2, 'Lunes', '10:00:00', '12:00:00', 2, 2),
(3, 'Martes', '08:00:00', '10:00:00', 3, 3),
(4, 'Martes', '10:00:00', '12:00:00', 4, 4),
(5, 'Miércoles', '08:00:00', '10:00:00', 5, 5),
(6, 'Miércoles', '10:00:00', '12:00:00', 1, 6),
(7, 'Jueves', '08:00:00', '10:00:00', 2, 7),
(8, 'Jueves', '10:00:00', '12:00:00', 3, 8),
(9, 'Viernes', '08:00:00', '10:00:00', 4, 9),
(10, 'Viernes', '10:00:00', '12:00:00', 5, 10);

-- nota (parejas alumno-curso consistentes con alumno_curso)
INSERT INTO nota (alumno_id, curso_id, evaluacion, nota, fecha) VALUES
-- alumno 1
(1, 1, 'Prueba 1', 5.5, '2025-04-10'),
(1, 1, 'Prueba 2', 6.0, '2025-05-15'),
(1, 1, 'Examen', 6.4, '2025-06-20'),
(1, 2, 'Prueba 1', 4.0, '2025-04-11'),
(1, 2, 'Prueba 2', 3.5, '2025-05-16'),
(1, 2, 'Examen', 4.8, '2025-06-21'),
-- alumno 2
(2, 3, 'Prueba 1', 6.8, '2025-04-10'),
(2, 3, 'Prueba 2', 7.0, '2025-05-15'),
(2, 3, 'Examen', 6.5, '2025-06-20'),
(2, 4, 'Prueba 1', 5.0, '2025-04-12'),
(2, 4, 'Prueba 2', 5.5, '2025-05-17'),
(2, 4, 'Examen', 6.0, '2025-06-22'),
-- alumno 3
(3, 5, 'Prueba 1', 3.0, '2025-04-10'),
(3, 5, 'Prueba 2', 4.2, '2025-05-15'),
(3, 5, 'Examen', 4.0, '2025-06-20'),
(3, 6, 'Prueba 1', 5.8, '2025-04-13'),
(3, 6, 'Prueba 2', 6.1, '2025-05-18'),
(3, 6, 'Examen', 6.6, '2025-06-23'),
-- alumno 4
(4, 7, 'Prueba 1', 4.5, '2025-04-10'),
(4, 7, 'Prueba 2', 4.0, '2025-05-15'),
(4, 7, 'Examen', 5.2, '2025-06-20'),
(4, 8, 'Prueba 1', 6.0, '2025-04-14'),
(4, 8, 'Prueba 2', 6.3, '2025-05-19'),
(4, 8, 'Examen', 5.9, '2025-06-24'),
-- alumno 5
(5, 9, 'Prueba 1', 7.0, '2025-04-10'),
(5, 9, 'Prueba 2', 6.7, '2025-05-15'),
(5, 9, 'Examen', 7.0, '2025-06-20'),
(5, 10, 'Prueba 1', 5.3, '2025-04-15'),
(5, 10, 'Prueba 2', 5.0, '2025-05-20'),
(5, 10, 'Examen', 5.7, '2025-06-25'),
-- alumno 6
(6, 1, 'Prueba 1', 4.8, '2025-04-10'),
(6, 1, 'Prueba 2', 5.2, '2025-05-15'),
(6, 1, 'Examen', 5.0, '2025-06-20'),
(6, 4, 'Prueba 1', 3.8, '2025-04-12'),
(6, 4, 'Prueba 2', 4.5, '2025-05-17'),
(6, 4, 'Examen', 4.2, '2025-06-22'),
-- alumno 7
(7, 2, 'Prueba 1', 6.2, '2025-04-11'),
(7, 2, 'Prueba 2', 5.9, '2025-05-16'),
(7, 2, 'Examen', 6.5, '2025-06-21'),
(7, 6, 'Prueba 1', 5.5, '2025-04-13'),
(7, 6, 'Prueba 2', 6.0, '2025-05-18'),
(7, 6, 'Examen', 5.8, '2025-06-23'),
-- alumno 8
(8, 3, 'Prueba 1', 4.0, '2025-04-10'),
(8, 3, 'Prueba 2', 3.5, '2025-05-15'),
(8, 3, 'Examen', 4.4, '2025-06-20'),
(8, 7, 'Prueba 1', 5.0, '2025-04-10'),
(8, 7, 'Prueba 2', 5.6, '2025-05-15'),
(8, 7, 'Examen', 6.0, '2025-06-20'),
-- alumno 9
(9, 5, 'Prueba 1', 6.5, '2025-04-10'),
(9, 5, 'Prueba 2', 6.8, '2025-05-15'),
(9, 5, 'Examen', 7.0, '2025-06-20'),
(9, 8, 'Prueba 1', 4.2, '2025-04-14'),
(9, 8, 'Prueba 2', 4.0, '2025-05-19'),
(9, 8, 'Examen', 4.7, '2025-06-24'),
-- alumno 10
(10, 9, 'Prueba 1', 5.9, '2025-04-10'),
(10, 9, 'Prueba 2', 6.2, '2025-05-15'),
(10, 9, 'Examen', 5.5, '2025-06-20');

INSERT INTO schema_migrations (version) VALUES ('002-insert-values');
