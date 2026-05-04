---
title: "Álgebra y Cálculo Relacional"
author: "Diego Muñoz"
date: "6 Mayo 2026"
theme: "metropolis"
aspectratio: 169
colorlinks: true
output: beamer_presentation
---

# Álgebra y Cálculo Relacional

## Objetivos de la Clase

- Entender la base **teórica** del modelo relacional.
- Conocer los operadores del **álgebra relacional**.
- Conocer las dos variantes del **cálculo relacional** (tuplas y dominios).
- Relacionar álgebra y cálculo con **SQL**.

---

# Motivación

## Base teórica del SQL que ya conocemos

- Ya escribimos consultas en SQL: `SELECT`, `FROM`, `WHERE`,
  `JOIN`, `UNION`.
- Detrás de esa sintaxis hay dos lenguajes formales: el **álgebra
  relacional** y el **cálculo relacional**.
- El álgebra describe **operaciones** sobre relaciones; el cálculo
  describe **propiedades** de las tuplas resultado.
- Conocerlos permite razonar sobre equivalencias entre consultas,
  entender los planes de ejecución y justificar optimizaciones.

---

# Esquema de ejemplo

## Tablas que usaremos (mismo modelo de la clase 07)

```
Alumno(id, nombre)
Profesor(id, nombre)
Curso(id, nombre, profesor)
AlumnoCurso(alumno, curso)
```

- `Curso.profesor` → `Profesor.id`
- `AlumnoCurso.alumno` → `Alumno.id`
- `AlumnoCurso.curso`  → `Curso.id`

---

# Álgebra Relacional

## Idea general

- Lenguaje **procedural**: describe **paso a paso** cómo obtener el resultado.
- Trabaja con relaciones (conjuntos de tuplas) y devuelve relaciones.
- **Operadores básicos**: $\sigma, \pi, \cup, -, \times, \rho$.
- **Operadores derivados**: $\cap, \bowtie, \div$.

---

# Selección $\sigma$

## Definición

- Filtra tuplas según una condición.
- Notación: $\sigma_{condicion}(R)$.

---

# Selección $\sigma$

### Ejemplo: cursos del profesor 1

$$\sigma_{profesor = 1}(Curso)$$

### Equivalente SQL

```sql
SELECT * FROM Curso WHERE profesor = 1;
```

---

# Proyección $\pi$

## Definición

- Selecciona columnas (atributos) de una relación.
- Notación: $\pi_{atributos}(R)$.
- Como es teoría de conjuntos, **elimina duplicados**.

---

# Proyección $\pi$

### Ejemplo: nombres de los alumnos

$$\pi_{nombre}(Alumno)$$

### Equivalente SQL

```sql
SELECT DISTINCT nombre FROM Alumno;
```

> SQL no elimina duplicados por defecto.

---

# Operaciones de Conjuntos

## Unión, intersección, diferencia

- $R \cup S$, $R \cap S$, $R - S$.
- Requieren que $R$ y $S$ sean **compatibles**: mismos atributos y dominios.

---

# Operaciones de Conjuntos

### Ejemplo (unión): alumnos inscritos en el curso 1 *o* en el curso 2

$$\pi_{alumno}(\sigma_{curso = 1}(AlumnoCurso)) \cup \pi_{alumno}(\sigma_{curso = 2}(AlumnoCurso))$$

### Equivalente SQL

```sql
SELECT alumno FROM AlumnoCurso WHERE curso = 1
UNION
SELECT alumno FROM AlumnoCurso WHERE curso = 2;
```

---

# Operaciones de Conjuntos

### Ejemplo (intersección): alumnos inscritos en el curso 1 *y* en el curso 2

$$\pi_{alumno}(\sigma_{curso = 1}(AlumnoCurso)) \cap \pi_{alumno}(\sigma_{curso = 2}(AlumnoCurso))$$

### Equivalente SQL

```sql
SELECT alumno FROM AlumnoCurso WHERE curso = 1
INTERSECT
SELECT alumno FROM AlumnoCurso WHERE curso = 2;
```

---

# Operaciones de Conjuntos

### Ejemplo (diferencia): alumnos inscritos en el curso 1 *pero no* en el curso 2

$$\pi_{alumno}(\sigma_{curso = 1}(AlumnoCurso)) - \pi_{alumno}(\sigma_{curso = 2}(AlumnoCurso))$$

### Equivalente SQL (con `EXCEPT`)

```sql
SELECT alumno FROM AlumnoCurso WHERE curso = 1
EXCEPT
SELECT alumno FROM AlumnoCurso WHERE curso = 2;
```

---

# Operaciones de Conjuntos

### Diferencia con `LEFT JOIN` (anti-join)

```sql
SELECT a1.alumno
FROM AlumnoCurso a1
LEFT JOIN AlumnoCurso a2
  ON a2.alumno = a1.alumno AND a2.curso = 2
WHERE a1.curso = 1
  AND a2.alumno IS NULL;
```

> El patrón `LEFT JOIN ... WHERE ... IS NULL` es la forma habitual
> de expresar la diferencia cuando el motor no soporta `EXCEPT` o
> cuando se necesita combinar con otras condiciones. `RIGHT JOIN`
> sirve para el caso simétrico.

---

# Producto Cartesiano $\times$

## Definición

- $R \times S$ combina **cada tupla de $R$ con cada tupla de $S$**.
- Por sí solo casi nunca entrega un resultado útil: mezcla filas que no
  tienen relación lógica.
- Cuando le aplicamos una selección $\sigma$ que filtra las combinaciones
  válidas obtenemos un **join**: $R \bowtie_{\theta} S = \sigma_{\theta}(R \times S)$.

---

# Producto Cartesiano $\times$

### Ejemplo: todos los pares posibles alumno-curso

$$Alumno \times Curso$$

### Equivalente SQL

```sql
SELECT * FROM Alumno CROSS JOIN Curso;
```

> Devuelve |Alumno| - |Curso| filas: cada alumno emparejado con cada curso

---

# Producto Cartesiano $\times$

### Diferencia con un JOIN

Un JOIN toma ese producto cartesiano y lo filtra con una condición (ON),
dejando solo las filas que cumplen la relación

```sql
SELECT * FROM Alumno
JOIN alumno_curso ON alumno_curso.alumno = Alumno.id
JOIN Curso ON alumno_curso.curso = Curso.id;
```

- `CROSS JOIN`: todas las combinaciones.
- `JOIN ... ON ...`: las que cumplen la condición

---

# Renombrado $\rho$

## Definición

- $\rho_{S}(R)$ renombra la relación a $S$.
- $\rho_{S(a,b,c)}(R)$ renombra también los atributos.
- Útil al hacer un producto consigo misma o para resolver colisiones de
  nombres antes de un join.

---

# Renombrado $\rho$

### Ejemplo: pares de cursos distintos del mismo profesor

$$\sigma_{C1.profesor = C2.profesor \,\land\, C1.id < C2.id}(\rho_{C1}(Curso) \times \rho_{C2}(Curso))$$

### Equivalente SQL

```sql
SELECT C1.id, C2.id
FROM Curso AS C1, Curso AS C2
WHERE C1.profesor = C2.profesor
  AND C1.id < C2.id;
```

---

# Join Natural $\bowtie$

## Definición

- Combina tuplas de $R$ y $S$ que coinciden en los **atributos comunes**.
- Notación: $R \bowtie S$.
- Ojo: si los atributos comunes no son los que queremos comparar, hay que
  **renombrar** primero o usar un $\theta$-join.

---

# Join Natural $\bowtie$

### Ejemplo: alumnos junto con los cursos en que están inscritos

Renombramos para que el atributo común sea `alumno`:

$$\rho_{A(alumno, nombre)}(Alumno) \bowtie AlumnoCurso$$

### Equivalente SQL

```sql
SELECT *
FROM Alumno a
JOIN AlumnoCurso ac ON ac.alumno = a.id;
```

---

# $\theta$-join

## Definición

- Join con una condición arbitraria $\theta$.
- $R \bowtie_{\theta} S = \sigma_{\theta}(R \times S)$.

### Ejemplo: cada curso con su profesor

$$Curso \bowtie_{Curso.profesor = Profesor.id} Profesor$$

### Equivalente SQL

```sql
SELECT *
FROM Curso c
JOIN Profesor p ON p.id = c.profesor;
```

---

# División $\div$

## Definición

- $R \div S$: tuplas de $R$ que están relacionadas con **todas** las tuplas de $S$.
- Útil para preguntas tipo "alumnos inscritos en **todos** los cursos del
  profesor X".
- En SQL se traduce con `NOT EXISTS` anidados o `HAVING COUNT(*)`.

---

# División $\div$

### Ejemplo: alumnos inscritos en *todos* los cursos del profesor 1

Sea $R = AlumnoCurso$ y $S = \rho_{S(curso)}(\pi_{id}(\sigma_{profesor = 1}(Curso)))$:

$$R \div S$$

---

# División $\div$

### Equivalente SQL (con doble `NOT EXISTS`)

```sql
SELECT DISTINCT ac.alumno
FROM AlumnoCurso ac
WHERE NOT EXISTS (
  SELECT 1 FROM Curso c
  WHERE c.profesor = 1
    AND NOT EXISTS (
      SELECT 1 FROM AlumnoCurso ac2
      WHERE ac2.alumno = ac.alumno
        AND ac2.curso  = c.id
    )
);
```

---

# Cálculo Relacional

## Idea general

- Lenguaje **declarativo**: describe **qué** se quiere, no cómo obtenerlo.
- Dos variantes:
  - **Cálculo de tuplas**: variables que recorren tuplas.
  - **Cálculo de dominios**: variables que recorren valores de atributos.

---

# Cálculo de Tuplas

## Forma general

$$\{ t \mid P(t) \}$$

> "El conjunto de tuplas $t$ tales que se cumple la propiedad $P(t)$."

---

# Cálculo de Tuplas

### Ejemplo: cursos del profesor 1

$$\{ t \mid t \in Curso \land t.profesor = 1 \}$$

### Equivalente SQL

```sql
SELECT * FROM Curso WHERE profesor = 1;
```

---

# Cálculo de Dominios

## Forma general

$$\{ \langle x_1, ..., x_n \rangle \mid P(x_1, ..., x_n) \}$$

- Las variables recorren **valores** de cada atributo.

---

# Cálculo de Dominios

### Ejemplo: nombres de cursos del profesor 1

$$\{ \langle n \rangle \mid \exists i, p \, ( \langle i, n, p \rangle \in Curso \land p = 1 ) \}$$

### Equivalente SQL

```sql
SELECT DISTINCT nombre FROM Curso WHERE profesor = 1;
```

---

# Equivalencia y Completitud Relacional

## ¿Son equivalentes?

- Álgebra relacional, cálculo de tuplas y cálculo de dominios tienen el
  **mismo poder expresivo** (con restricciones de seguridad sobre el cálculo).
- Un lenguaje es **relacionalmente completo** si puede expresar todo lo que
  expresa el álgebra relacional.
- SQL es relacionalmente completo (y agrega agregaciones, ordenamiento, etc.).

---

# Mapeo Álgebra → SQL

| Álgebra | SQL |
|---|---|
| $\sigma_{cond}(R)$ | `WHERE cond` |
| $\pi_{attrs}(R)$ | `SELECT DISTINCT attrs` |
| $R \cup S$ | `UNION` |
| $R \cap S$ | `INTERSECT` |
| $R - S$ | `EXCEPT` / `LEFT JOIN ... IS NULL` |
| $R \times S$ | `CROSS JOIN` |
| $R \bowtie S$ | `NATURAL JOIN` / `JOIN ... ON` |
| $\rho_{S}(R)$ | `AS S` |

---

# Resumen

- Álgebra relacional: operadores básicos y derivados.
- Cálculo relacional: tuplas y dominios.
- Equivalencia entre ambos y con SQL.
- Mapeo directo álgebra → SQL.

---

# Preguntas y Discusión  

¿Tienes dudas? ¡Hablemos!
