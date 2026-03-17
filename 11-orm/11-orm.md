---
title: "Desarrollo con SQLAlchemy: del modelo a la lógica"
author: "Diego Muñoz"
date: "28 Mayo 2025"
theme: "metropolis"
aspectratio: 169
colorlinks: true
output: beamer_presentation
---

# Objetivo

* Aprender a construir la lógica completa con SQLAlchemy:
  - Modelado
  - Relaciones
  - Restricciones y validaciones
  - Funciones SQL y triggers (si es necesario)
  - Transacciones

---

# Crear modelos base

```python
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship

Base = declarative_base()

class Categoria(Base):
  __tablename__ = "categoria"
  id = Column(Integer, primary_key=True)
  nombre = Column(String, nullable=False, unique=True)
```

---

# Relación Uno a Uno (`one-to-one`)

* Se define con `relationship(..., uselist=False)` para indicar que es un único objeto relacionado.
* La tabla secundaria tiene una clave foránea con `unique=True` para garantizar la unicidad.
* Ejemplo clave foránea en tabla secundaria:
  `usuario_id = Column(Integer, ForeignKey('usuarios.id'), unique=True)`

---

# Relaciones uno a uno

```python
class Usuario(Base):
    __tablename__ = 'usuarios'
    id = Column(Integer, primary_key=True, autoincrement=True)
    perfil = relationship('Perfil', uselist=False, back_populates='usuario')

class Perfil(Base):
    __tablename__ = 'perfiles'
    id = Column(Integer, primary_key=True, autoincrement=True)
    usuario_id = Column(
        Integer, ForeignKey('usuarios.id'), nullable=False, unique=True
    )
    usuario = relationship('Usuario', back_populates='perfil')
```

---

# Relación Uno a Muchos (`one-to-many`)

* Se define con `relationship()` normal (sin `uselist=False`) en la clase "uno".
* La tabla "muchos" tiene una columna con `ForeignKey` apuntando a la tabla "uno".
* En el lado "muchos" se usa `ForeignKey`, y en el lado "uno" se define la relación que devuelve una lista.

---

# Relaciones uno a muchos

```python
class Jugador(Base):
  __tablename__ = "jugador"
  id = Column(Integer, primary_key=True)
  categoria_id = Column(Integer, ForeignKey("categoria.id"))
  categoria = relationship("Categoria", backref="jugadores")

class Categoria(Base):
  __tablename__ = "categoria"
  id = Column(Integer, primary_key=True)
  jugadores = relationship("Jugador", backref="categoria")
```

---

# Relación Muchos a Muchos (`many-to-many`)

* Se crea una tabla de asociación explícita (`Table`) con dos claves foráneas que apuntan a ambas tablas.
* En ambas clases se define `relationship(..., secondary=tabla_asociacion)` para indicar la relación.
* Las colecciones en ambos lados son listas (por defecto `uselist=True`).

---

# Relaciones muchos a muchos

```python
torneo_jugador = Table("inscripcion", Base.metadata,
  Column("jugador_id", ForeignKey("jugador.id"), primary_key=True),
  Column("torneo_id", ForeignKey("torneo.id"), primary_key=True)
)

class Torneo(Base):
  __tablename__ = "torneo"
  id = Column(Integer, primary_key=True)
  nombre = Column(String)
  jugadores = relationship("Jugador", secondary=torneo_jugador, backref="torneos")
```

---

# Relaciones muchos a muchos

```python
class Jugador(Base):
  __tablename__ = "jugador"
  id = Column(Integer, primary_key=True)
  nombre = Column(String, nullable=False)
  torneos = relationship("Torneo", secondary=torneo_jugador, backref="jugadores")

```

---

# Validación con restricciones SQL

```python
from sqlalchemy import CheckConstraint
```

* El texto dentro de `CheckConstraint` es una expresión en lenguaje SQL, la misma
que entiende el motor de la base de datos (PostgreSQL, MySQL, etc.).
* `CheckConstraint` es una restricción de integridad que se define en SQL, no
en Python.

---

# Validación con restricciones SQL

```python
class Partido(Base):
  __tablename__ = "partido"
  id = Column(Integer, primary_key=True)
  puntos_j1 = Column(Integer)
  puntos_j2 = Column(Integer)
  __table_args__ = (
    CheckConstraint("puntos_j1 BETWEEN 0 AND 11"),
    CheckConstraint("puntos_j2 BETWEEN 0 AND 11"),
  )
```

---

# Validación en Python

```python
from sqlalchemy.orm import validates
```
* `@validates("column")` es un decorador de SQLAlchemy que intercepta
asignaciones a la columna email.
* Es útil para validaciones más específicas o complejas que no se pueden
expresar fácilmente en SQL.

---

# Validación en Python

```python
class Jugador(Base):
  __tablename__ = "jugador"
  id = Column(Integer, primary_key=True)
  email = Column(String, unique=True)

  @validates("email")
  def validar_email(self, _, val):
    assert "@" in val
    return val
```

---

# Validación en función SQL

```sql
CREATE FUNCTION valid_email(text) RETURNS boolean AS $$
BEGIN
  RETURN position('@' in $1) > 0;
END;
$$ LANGUAGE plpgsql;
```

```sql
ALTER TABLE jugador ADD CHECK (valid_email(email));
```

---

# Relaciones recursivas

```python
class Jugador(Base):
  __tablename__ = "jugador"
  id = Column(Integer, primary_key=True)
  entrenador_id = Column(Integer, ForeignKey("jugador.id"))
  entrenador = relationship("Jugador", remote_side=[id])
```

---

# Consultas básicas

```python
with Session(engine) as s:
  j = s.query(Jugador).filter_by(nombre="Ana").first()
  print(j.categoria.nombre)
```

---

# Consultas con joins

```python
with Session(engine) as s:
  q = s.query(Partido).join(Partido.jugador1).filter(Jugador.nombre=="Ana")
  for p in q: print(p.puntos_j1, p.puntos_j2)
```

---

# Insert con relaciones

```python
with Session(engine) as s:
  c = Categoria(nombre="Sub 15")
  j = Jugador(nombre="Ana", categoria=c)
  s.add(j); s.commit()
```

---

# Insert de muchos

```python
with Session(engine) as s:
  jugadores = [Jugador(nombre=n) for n in ["Luis", "Juan"]]
  s.add_all(jugadores); s.commit()
```

---

# Transacciones (bloque try)

```python
with Session(engine) as s:
  try:
    s.add(Jugador(nombre="Luis"))
    s.commit()
  except:
    s.rollback()
```

---

# Transacción fallida

```python
try:
  with Session(engine) as s:
    s.add(Jugador(nombre=None))  # NULL no permitido
    s.commit()
except Exception as e:
  print("Error:", e)
```

---

# Función de utilidad

```python
def crear_partido(s, j1, j2, p1, p2):
  s.add(Partido(jugador1=j1, jugador2=j2, puntos_j1=p1, puntos_j2=p2))
```

```python
with Session(engine) as s:
  crear_partido(s, j1, j2, 11, 8)
  s.commit()
```

---

# Datos de ejemplo

```python
Base.metadata.create_all(engine)

with Session(engine) as s:
  cat = Categoria(nombre="Libre")
  j1 = Jugador(nombre="Ana", categoria=cat)
  j2 = Jugador(nombre="Pedro", categoria=cat)
  p = Partido(jugador1=j1, jugador2=j2, puntos_j1=11, puntos_j2=9)
  s.add_all([j1, j2, p]); s.commit()
```

---

# Buenas prácticas

* Agrega `nullable=False` donde puedas
* Usa `CheckConstraint` para reglas simples
* Prefiere `@validates` para validación básica
* Usa funciones SQL para validaciones complejas compartidas
* Siempre maneja excepciones y usa `rollback`

---

# Resumen

* SQLAlchemy permite modelar, relacionar, validar y operar sobre datos
* Puedes combinar lógica en Python y SQL
* Todo lo que haces en SQL se puede reflejar con SQLAlchemy
* Las transacciones te dan control total sobre los cambios

---

# ¿Preguntas?

### Tarea práctica (2h):

* Modela `Jugador`, `Torneo`, `Partido` y `Resultado`
* Agrega restricciones y validaciones
* Inserta datos con transacciones
* Crea funciones SQL opcionales para validaciones
