---
title: "Introducción a FastAPI"
author: "Diego Muñoz"
date: "04 Junio 2025"
theme: "metropolis"
aspectratio: 169
colorlinks: true
output: beamer_presentation
---

# Objetivo

* Comprender los fundamentos de FastAPI
* Crear una API REST básica
* Validar datos con Pydantic
* Probar endpoints desde documentación automática
* Manejar errores y usar rutas con parámetros

---

# ¿Qué es FastAPI?

* Framework moderno para construir APIs con Python
* Basado en Starlette (ASGI) y Pydantic
* Genera documentación interactiva (Swagger/ReDoc)
* Validación automática a partir de tipos de Python
* Muy rápido (comparable a NodeJS, Go)

---

# Instalación

```bash
pip install uvicorn "fastapi[standard]"
````

* `fastapi`: el framework principal
* `uvicorn`: servidor ASGI recomendado

---

# Primer ejemplo

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def hola_mundo():
    return {"mensaje": "Hola FastAPI"}
```

* Ejecutar con:

```bash
fastapi dev main.py
```

---

# Documentación automática

* Visita `http://localhost:8000/docs` para Swagger
* Visita `http://localhost:8000/redoc` para ReDoc

---

# Rutas con parámetros

```python
@app.get("/items/{item_id}")
def obtener_items(item_id: int, q: str = None):
    return {"item_id": item_id, "q": q}
```

* FastAPI convierte y valida automáticamente los tipos
* `q` es un parámetro de consulta opcional

---

# Validación con Pydantic

```python
from pydantic import BaseModel

class Item(BaseModel):
    nombre: str
    precio: float
    descripcion: str | None = None
```

* Se usa en el cuerpo de una solicitud `POST`, `PUT`, etc.

---

# Crear un ítem (POST)

```python
@app.post("/items/")
def agregar_item(item: Item):
    return {"agregado": item}
```

* FastAPI valida el JSON entrante contra el modelo `Item`

---

# Obtener un ítem por ID

```python
@app.get("/items/{item_id}")
def buscar_item_por_id(item_id: int):
    return {"item_id": item_id}
```

* Los parámetros de ruta se tipan directamente

---

# Actualizar ítem (PUT)

```python
@app.put("/items/{item_id}")
def actualizar_item(item_id: int, item: Item):
    return {"item_id": item_id, "actualizado": item}
```

* Puedes combinar parámetros de ruta y cuerpo de petición

---

# Eliminar ítem (DELETE)

```python
@app.delete("/items/{item_id}")
def borrar_item(item_id: int):
    return {"borrado": item_id}
```

---

# Manejo de errores

```python
from fastapi import HTTPException

@app.get("/items/{item_id}")
def buscar_item_por_id(item_id: int):
    if item_id != 42:
        raise HTTPException(status_code=404, detail="No se encontró el ítem")
    return {"item_id": item_id}
```

---

# Ejemplo práctico: ToDo API

* `GET /tareas`: obtener tareas
* `POST /tareas`: agregar tarea
* `GET /tareas/{id}`: ver una tarea
* `PUT /tareas/{id}`: actualizar
* `DELETE /tareas/{id}`: eliminar

---

# Modelo de tarea

```python
class Tareas(BaseModel):
    titulo: str
    terminada: bool = False
```

* Usamos una lista como almacenamiento temporal

---

# Almacenamiento en memoria

```python
tareas = []

@app.post("/tareas/")
def agregar_tareas(tareas: Tareas):
    tareas.append(tareas)
    return {"id": len(tareas) - 1, "tareas": tareas}
```

---

# Obtener todas las tareas

```python
@app.get("/tareas/")
def buscar_tareas():
    return tareas
```

---

# Documentación de la API (Docstring)

```python
@app.get("/tareas/{id}")
def ver_tarea(id: int):
    """ Obtiene una tarea por su ID. """
    if id < 0 or id >= len(tareas):
        raise HTTPException(status_code=404, detail="Tarea no encontrada")
    return tareas[id]
```

* Visita `http://localhost:8000/docs` para ver la documentación Swagger

---

# Buenas prácticas

* Usa tipos nativos de Python para validación automática
* Documenta tu API con los modelos de entrada y salida
* Maneja errores con `HTTPException`
* Usa `fastapi dev` para actualizar automáticamente el servidor al guardar
cambios

---

# Siguientes pasos

* Conectar con una base de datos (SQLAlchemy)
* Implementar un CRUD completo

---

# Tarea práctica (2h):

* Construir una API para gestionar biblioteca (sin ORM):

  * Crear, listar, editar, eliminar (CRUD)
  * Usar modelos Pydantic para validación
  * Manejar errores correctamente
  * Probar con documentación Swagger
