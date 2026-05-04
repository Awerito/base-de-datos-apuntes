---
title: "Migraciones en SQL (PostgreSQL)"
author: "Diego Muñoz"
date: "7 Mayo 2025"
theme: "metropolis"
aspectratio: 169
colorlinks: true
output: beamer_presentation
---

# ¿Qué es una migración?

## Registro de cambios estructurales

* Una migración es un conjunto de instrucciones SQL que modifica el **esquema** de una base de datos.
* Se usa para **crear, alterar o eliminar** estructuras como tablas, columnas, restricciones.
* Permite aplicar cambios de forma **controlada, secuencial y reversible**.

---

# ¿Por qué usar migraciones?

* Para mantener el esquema **versionado** igual que el código fuente.
* Para asegurar que todos los entornos tengan el mismo diseño de base de datos.
* Para aplicar cambios **de manera segura y trazable**.

---

# Cambios típicos en migraciones

* Crear o eliminar tablas:
```sql
CREATE TABLE producto (...);
DROP TABLE producto;
````

* Agregar o quitar columnas:

```sql
ALTER TABLE producto ADD COLUMN precio DECIMAL;
ALTER TABLE producto DROP COLUMN precio;
```

* Modificar tipos o restricciones:

```sql
ALTER TABLE producto ALTER COLUMN nombre TYPE VARCHAR(100);
ALTER TABLE producto ADD CONSTRAINT nombre_unico UNIQUE(nombre);
```

---

# Organización de migraciones

* Archivos SQL numerados secuencialmente:

  * `001_create_producto.sql`
  * `002_add_precio_to_producto.sql`
  * `003_create_index_nombre.sql`

* Cada archivo contiene **una sola modificación estructural** y puede tener comentarios descriptivos.

---

# Ejemplo 1: crear una tabla

```sql
-- 001_create_producto.sql
CREATE TABLE producto (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL
);
```

---

# Ejemplo 2: agregar una columna

```sql
-- 002_add_precio_to_producto.sql
ALTER TABLE producto ADD COLUMN precio DECIMAL(10,2);
```

---

# Ejemplo 3: agregar índice

```sql
-- 003_create_index_nombre.sql
CREATE INDEX idx_producto_nombre ON producto(nombre);
```

---

# Control manual de migraciones

## Tabla de control:

```sql
CREATE TABLE schema_migrations (
    version TEXT PRIMARY KEY,
    applied_at TIMESTAMP DEFAULT now()
);
```

* Guarda el nombre (o número) de cada migración aplicada.

---

# Aplicar migraciones manualmente

1. Ejecutar el archivo SQL (por ejemplo con `psql` o DBeaver).
2. Registrar la migración aplicada:

```sql
INSERT INTO schema_migrations (version) VALUES ('001_create_producto');
```

---

# Ver migraciones aplicadas

```sql
SELECT * FROM schema_migrations ORDER BY applied_at;
```

---

# Revertir migraciones (rollback manual)

* Crea archivos de reversión opcionales, por ejemplo:

```sql
-- 002_rollback_add_precio.sql
ALTER TABLE producto DROP COLUMN precio;
```

* El reverso no siempre es trivial (¡cuidado con perder datos!).

---

# Buenas prácticas

* No edites migraciones ya aplicadas.
* Usa nombres claros y consistentes: `003_add_stock_column.sql`.
* Aplica y registra cada migración **de una en una**.
* Haz backup antes de aplicar migraciones en producción.

---

# Resumen

* Una migración es un conjunto de instrucciones SQL para modificar el esquema de una base de datos.
* En SQL se aplican directa y manualmente.
* Las migraciones son secuenciales.
* Dependen de un control manual (tabla de control).
* Existen herramientas para automatizar migraciones.

---

# ¿Preguntas?

### Juega:

* Crea una carpeta con migraciones (`001`, `002`, ...).
* Aplica migraciones en orden y registra cada una.
* Prueba revertir una columna y ver el efecto.
