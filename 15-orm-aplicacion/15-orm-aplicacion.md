---
title: "Construcción de API REST con FastAPI + SQLAlchemy"
author: "Diego Muñoz"
date: "9 Junio 2025"
theme: "metropolis"
aspectratio: 169
colorlinks: true
output: beamer_presentation
---

# Objetivo

* Aprender a conectar la lógica CRUD de SQLAlchemy con endpoints HTTP en FastAPI.
* Entender cómo organizar el código en capas (`crud`, `routers`, `models`, etc.).
* Implementar una API funcional y mantenible.

---

# Estructura del proyecto

```text
.
├── main.py
├── app/
│   ├── db.py
│   ├── models.py
│   ├── crud/
│   │   └── autor.py
│   └── routers/
│       └── autor.py
└── migrations/
    └── versions/...
````

---

# Modelo base: `Autor`

```python
# Importa la clase Base de SQLAlchemy de nuestro módulo db.py
from sqlalchemy import Column, Integer, String
from .db import Base

class Autor(Base):
  __tablename__ = "autor"
  id = Column(Integer, primary_key=True, index=True)
  nombre = Column(String, nullable=False)
```

* Representa una tabla en la base de datos.
* Se usará en las funciones CRUD y en los endpoints.

---

# Lógica de negocio: `crud/autor.py`

```python
from sqlalchemy.orm import Session
from ..models import Autor

def create_autor(session: Session, nombre: str):
    autor = Autor(nombre=nombre)
    session.add(autor)
    session.commit()
    return autor
```

* Inserta un nuevo autor.
* Usa la sesión para interactuar con la base de datos.
* Devuelve el objeto creado.

---

# Otras operaciones CRUD

```python
def get_autores(session: Session):
    return session.query(Autor).all()
```

```python
def update_autor(session: Session, autor_id: int, nombre: str):
    autor = session.get(Autor, autor_id)
    if autor:
        autor.nombre = nombre
        session.commit()
    return autor
```

* Cada función representa una operación: leer, modificar o borrar.

---

# Conexión con FastAPI: `router`

```python
from fastapi import APIRouter, HTTPException, Depends

from ..db import get_db
from ..cruds.autor import get_autores

@router.get("/")
def get_autores_endpoint(session=Depends(get_db)):
    autores = get_autores(session)
    return [{"id": autor.id, "nombre": autor.nombre} for autor in autores]
```

* Capa de presentación: maneja solicitudes HTTP.
* Llama al CRUD correspondiente.
* Retorna respuestas en formato JSON.

---

# Endpoint `GET /{autor_id}`

```python
from ..cruds.autor import get_autor

@router.get("/{autor_id}")
def get_autor_endpoint(autor_id: int, session=Depends(get_db)):
    autor = get_autor(session, autor_id)
    if not autor:
        raise HTTPException(status_code=404, detail="Autor not found")
    return {"id": autor.id, "nombre": autor.nombre}
```

* Manejo de errores: si no existe el autor, retorna 404.

---

# Crear un autor: `POST /`

```python
from ..cruds.autor import create_autor

@router.post("/")
def create_autor_endpoint(nombre: str, session=Depends(get_db)):
    autor = create_autor(session, nombre)
    return {"id": autor.id, "nombre": autor.nombre}
```

* Recibe datos por parámetro.
* Devuelve el autor recién creado.

---

# Actualizar un autor: `PUT /{autor_id}`

```python
from ..cruds.autor import update_autor

@router.put("/{autor_id}")
def update_autor_endpoint(autor_id: int, nombre: str, session=Depends(get_db)):
    autor = update_autor(session, autor_id, nombre)
    if not autor:
        raise HTTPException(status_code=404, detail="Autor not found")
    return {"id": autor.id, "nombre": autor.nombre}
```

* Reutiliza la lógica del CRUD.
* Devuelve el autor actualizado.

---

# Eliminar un autor: `DELETE /{autor_id}`

```python
from ..cruds.autor import delete_autor

@router.delete("/{autor_id}")
def delete_autor_endpoint(autor_id: int, session=Depends(get_db)):
    autor = delete_autor(session, autor_id)
    if not autor:
        raise HTTPException(status_code=404, detail="Autor not found")
    return {"detail": "Autor deleted successfully"}
```

---

# Resumen

* SQLAlchemy maneja la lógica y el acceso a datos.
* FastAPI define los endpoints y maneja el ciclo HTTP.
* Separar las capas facilita el mantenimiento.
* Cada endpoint delega su trabajo a una función del módulo `crud`.

---

# ¿Preguntas?

### Tarea práctica

* Crear un nuevo modelo `Libro`
* Implementar sus funciones CRUD
* Crear los endpoints correspondientes
* Prueba con tablas con relaciones (por ejemplo, `Autor` y `Libro`)
