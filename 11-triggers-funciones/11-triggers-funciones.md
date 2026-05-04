---
title: "Triggers y funciones en SQL (PostgreSQL)"
author: "Diego Muñoz"
date: "25 Mayo 2025"
theme: "metropolis"
aspectratio: 169
colorlinks: true
output: beamer_presentation
---

# ¿Qué es una función en SQL?

## Bloque reutilizable de código

* Una **función** es un procedimiento que encapsula lógica en el servidor de
base de datos.
* Puede recibir parámetros y retornar un valor o resultado.
* Se utiliza para cálculos, transformaciones, validaciones, etc.

---

# Ejemplo: auditoría de cambios de precio

```sql
CREATE TABLE producto (
    id SERIAL PRIMARY KEY,
    nombre TEXT,
    precio NUMERIC
);

CREATE TABLE historial_precio (
    id SERIAL PRIMARY KEY,
    producto_id INTEGER,
    precio_anterior NUMERIC,
    precio_nuevo NUMERIC,
    fecha TIMESTAMP DEFAULT now()
);
```

---

# Estructura de una función en SQL

```sql
CREATE FUNCTION nombre_funcion(parametro1 tipo, parametro2 tipo)
RETURNS tipo_retorno AS $$
BEGIN
    -- lógica
    RETURN resultado;
END;
$$ LANGUAGE plpgsql;  -- lenguaje de la función
````

---

# Funciones con parámetros y retorno

```sql
CREATE FUNCTION aplicar_descuento(precio NUMERIC, porcentaje NUMERIC)
RETURNS NUMERIC AS $$
BEGIN
    RETURN precio * (1 - porcentaje / 100);
END;
$$ LANGUAGE plpgsql;
```

* Se pueden usar directamente en consultas:

```sql
SELECT aplicar_descuento(precio, 15) FROM producto;
```

---

# Reglas y restricciones personalizadas

* Puedes usar triggers para validar condiciones más complejas que `CHECK`.
* Ejemplo: impedir reducir el stock por debajo de cero.

```sql
IF NEW.stock < 0 THEN
    RAISE EXCEPTION 'No puede haber stock negativo';
END IF;
```

---

# Trigger para evitar cambios por usuarios no autorizados

```sql
IF current_user <> 'admin' THEN
    RAISE EXCEPTION 'Solo el administrador puede modificar este campo';
END IF;
```

* Ideal para auditoría o protección de datos críticos.

---

# ¿Qué es un trigger?

## Un disparador automático

* Un **trigger** se ejecuta automáticamente cuando ocurre un evento: `INSERT`,
`UPDATE`, o `DELETE`.
* Se asocia a una tabla específica.
* Ejecuta una función que define la lógica a realizar.

---

# ¿Por qué usar funciones y triggers?

* Para encapsular **reglas del negocio** directamente en la base de datos.
* Para implementar **auditorías**, validaciones o transformaciones automáticas.
* Para mantener **consistencia** incluso cuando acceden múltiples aplicaciones
a la BD.

---

# Eventos que pueden activar un trigger

* `BEFORE INSERT`, `BEFORE UPDATE`, `BEFORE DELETE`
* `AFTER INSERT`, `AFTER UPDATE`, `AFTER DELETE`

### ¿Por fila o por operación?
* `FOR EACH ROW`: se ejecuta una vez por cada fila afectada.
* `FOR EACH STATEMENT`: se ejecuta una vez por sentencia (poco común).

---

# Estructura de una función para trigger

```sql
CREATE FUNCTION nombre_trigger()
RETURNS TRIGGER AS $$
BEGIN
    -- lógica
    RETURN NEW; -- o OLD
END;
$$ LANGUAGE plpgsql;
````

---

# Objetos disponibles dentro de un trigger

* `NEW`: fila nueva (después de un `INSERT` o `UPDATE`).
* `OLD`: fila antigua (antes de un `DELETE` o `UPDATE`).
* `TG_OP`: operación que activó el trigger (`INSERT`, `UPDATE`, `DELETE`).
* `TG_TABLE_NAME`: nombre de la tabla que activó el trigger.
* `TG_TABLE_SCHEMA`: esquema de la tabla que activó el trigger.
* Y otros más.

---

# Estructura de un trigger

```sql
CREATE TRIGGER nombre_trigger
AFTER UPDATE ON tabla
FOR EACH ROW
EXECUTE FUNCTION nombre_funcion();
```

---

# Función para registrar cambios

```sql
CREATE FUNCTION registrar_cambio_precio()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.precio <> OLD.precio THEN
        INSERT INTO historial_precio (
          producto_id, precio_anterior, precio_nuevo
        )
        VALUES (OLD.id, OLD.precio, NEW.precio);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

---

# Trigger asociado

```sql
CREATE TRIGGER trigger_precio_update
AFTER UPDATE ON producto
FOR EACH ROW
EXECUTE FUNCTION registrar_cambio_precio();
```

---

# Resultado

* Cada vez que se actualiza el precio de un producto, se registra
automáticamente en `historial_precio`.

```sql
UPDATE producto SET precio = 2500 WHERE id = 3;
```

---

# ¿Cómo usar esto con Alembic?

* En migraciones Alembic puedes ejecutar SQL crudo:

```python
op.execute(\"""
CREATE FUNCTION ...
\""")
op.execute(\"""
CREATE TRIGGER ...
\""")
```

* Las funciones y triggers **no se declaran en el ORM**.

---

# Buenas prácticas

* Usar `AFTER` si se necesita trabajar con datos ya modificados.
* Siempre verificar si hay cambio antes de insertar auditoría.
* Evitar lógica compleja que duplique la del backend.
* Mantener las funciones versionadas y revisadas como cualquier código.

---

# Resumen

* Las funciones permiten encapsular lógica reutilizable en SQL.
* Los triggers ejecutan funciones automáticamente al cambiar datos.
* Se usan para auditorías, validaciones, transformaciones y protección.
* Se pueden aplicar mediante migraciones con SQL crudo en Alembic.

---

# ¿Preguntas?

### Juega:

* Crea una tabla con auditoría de cambios.
* Escribe una función con validación personalizada.
* Usa `RAISE EXCEPTION` para impedir ciertos cambios.
* Crea una migración Alembic que instale tu trigger.
