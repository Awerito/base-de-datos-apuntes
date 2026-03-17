---
title: "Transacciones SQL y ORMs"
author: "Diego Muñoz"
date: "11 Mayo 2025"
theme: "metropolis"
aspectratio: 169
colorlinks: true
output: beamer_presentation
---

# ¿Qué es una transacción?

## Unidad de trabajo atómica

* Una transacción es un **bloque de operaciones** que se ejecutan como una sola unidad lógica.
* Cumple con las propiedades **ACID**:

  * **Atomicidad**: Todo o nada.
  * **Consistencia**: Mantiene reglas de integridad.
  * **Aislamiento**: Operaciones independientes.
  * **Durabilidad**: Cambios persistentes.

---

# ¿Por qué usar transacciones?

* Para **evitar errores parciales** o inconsistencias si algo falla.
* Para **proteger los datos** cuando múltiples usuarios acceden al sistema.
* Para **controlar concurrencia** y prevenir conflictos.

---

# Transacciones en SQL (PostgreSQL)

## Comandos principales

```sql
BEGIN;
-- operaciones
COMMIT;
```

```sql
BEGIN;
-- operaciones
ROLLBACK;
```

---

# Ejemplo en SQL: transferencia de fondos

```sql
BEGIN;

UPDATE cuenta SET saldo = saldo - 1000 WHERE id = 1;
UPDATE cuenta SET saldo = saldo + 1000 WHERE id = 2;

COMMIT;
```

---

# ¿Qué pasa si hay un error?

```sql
BEGIN;

UPDATE cuenta SET saldo = saldo - 1000 WHERE id = 1;
-- ERROR: cuenta 2 no existe
UPDATE cuenta SET saldo = saldo + 1000 WHERE id = 999;

ROLLBACK;
```

> El `ROLLBACK` revierte todo, como si nada hubiera pasado.

---

# Transacciones en Python

## ¿Cómo implementarlas?

* Usaremos **SQLAlchemy + Alembic**.
* SQLAlchemy ofrece control total de transacciones.
* Alembic permite versionar el esquema automáticamente.

---

# Instalación de dependencias

```bash
pip install python-dotenv sqlalchemy alembic psycopg2-binary
```

```bash
project/
├── main.py
└── app/
    ├── __init__.py
    ├── models.py
    └── db.py
```

---

# Configuración base

## `> db.py`

```python
import os
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# WARN: No uses credenciales en producción sin variables de entorno
# URI: "driver://user:password@host:port/dbname"
load_dotenv()
DATABASE_URI = os.getenv("DATABASE_URI", "")
engine = create_engine(DATABASE_URI)
SessionLocal = sessionmaker(bind=engine)
Base = declarative_base()
```

---

# Definición de modelo

## `> models.py`

```python
from sqlalchemy import Column, Integer, String
from .db import Base

class Cuenta(Base):
    __tablename__ = "cuenta"
    id = Column(Integer, primary_key=True)
    nombre = Column(String, nullable=False)
    saldo = Column(Integer, nullable=False)
```

---

# Inicializar Alembic

```bash
alembic init alembic
```

```bash
project/
├── alembic.ini
├── main.py
├── app/
│   ├── __init__.py
│   ├── models.py
│   └── db.py
└── alembic/
    └── versions/
```

---

# Inicializar Alembic

* En `env.py`, importa tus modelos:

```python
from dotenv import load_dotenv
import os
from app.db import Base
from app import models
load_dotenv()
config = context.config
config.set_main_option("sqlalchemy.url", os.getenv("DATABASE_URI", ""))
target_metadata = Base.metadata
```

---

# Crear la tabla

```bash
alembic revision --autogenerate -m "create cuenta table"
alembic upgrade head
```

> Alembic generará y aplicará los cambios automáticamente.

---

# Ejemplo de transacción

## `> main.py`

```python
from app.db import SessionLocal
from app.models import Cuenta

def transferir(origen_id, destino_id, monto):
    db = SessionLocal()
    try:
        origen = db.query(Cuenta).filter_by(id=origen_id).one()
        destino = db.query(Cuenta).filter_by(id=destino_id).one()
        if origen.saldo < monto:
            raise ValueError("Fondos insuficientes")
        origen.saldo -= monto
        destino.saldo += monto
        db.commit()
    except Exception as e:
        db.rollback()
        raise
    finally:
        db.close()
```

---

# Manejo automático de errores

* Toda la transacción está protegida con `try/except`.
* Si algo falla, `rollback()`.
* Si todo sale bien, `commit()`.

---

# Aislamiento de transacciones

## ¿Qué es el aislamiento?

* Determina **cómo interactúan las transacciones concurrentes** entre sí.
* Afecta si una transacción puede **ver cambios realizados por otras** antes de que estas terminen.

---

# Niveles de aislamiento en PostgreSQL

### 1. `READ COMMITTED` (por defecto)

* Cada consulta ve solo datos **confirmados hasta ese momento**.

---

# Aislamiento de transacciones

### 2. `REPEATABLE READ`

* Todas las consultas dentro de una transacción **ven el mismo "snapshot"** de los datos.

---

# Aislamiento de transacciones

### 3. `SERIALIZABLE`

* Simula que las transacciones se ejecutan **una tras otra, en orden**.
* Puede provocar más conflictos y rollbacks por seguridad.

---

# ¿Cómo cambiar el nivel de aislamiento?

```python
from sqlalchemy import text

def operacion_avanzada():
    db = SessionLocal()
    try:
        db.execute(text("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE"))
        # operaciones...
        db.commit()
    except:
        db.rollback()
        raise
    finally:
        db.close()
```

> Solo usa niveles estrictos si realmente necesitas esa garantía.

---

# ¿Qué vimos hoy?

* Concepto de transacción y propiedades ACID.
* Ejemplos en SQL con `BEGIN`, `COMMIT`, `ROLLBACK`.
* Implementación segura en Python con SQLAlchemy.
* Migraciones automáticas con Alembic.
* Manejo de errores y aislamiento.

<!-- --- -->
<!---->
<!-- # ¿Y ahora qué? -->
<!---->
<!-- ## Siguientes pasos: -->
<!---->
<!-- * Optimización de transacciones largas. -->
<!-- * Control de concurrencia: bloqueos y deadlocks. -->

---

# ¿Preguntas?

### Juega:

* Implementa una transferencia segura.
* Genera errores intencionales y observa el rollback.
* Juega con el orden de operaciones.
