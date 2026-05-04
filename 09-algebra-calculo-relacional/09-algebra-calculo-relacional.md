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

## Tablas que usaremos

```
Jugador(id, nombre, categoria_id)
Categoria(id, nombre)
Partido(id, jugador1_id, jugador2_id, puntos_j1, puntos_j2)
```

- `Jugador.categoria_id` → `Categoria.id`
- `Partido.jugador1_id`, `Partido.jugador2_id` → `Jugador.id`

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

### Ejemplo: jugadores de la categoría 1

$$\sigma_{categoria\_id = 1}(Jugador)$$

### Equivalente SQL

```sql
SELECT * FROM Jugador WHERE categoria_id = 1;
```

---

# Proyección $\pi$

## Definición

- Selecciona columnas (atributos) de una relación.
- Notación: $\pi_{atributos}(R)$.
- Como es teoría de conjuntos, **elimina duplicados**.

---

# Proyección $\pi$

### Ejemplo: nombres de los jugadores

$$\pi_{nombre}(Jugador)$$

### Equivalente SQL

```sql
SELECT DISTINCT nombre FROM Jugador;
```

> SQL no elimina duplicados por defecto — usa `DISTINCT`.

---

# Operaciones de Conjuntos

## Unión, intersección, diferencia

- $R \cup S$, $R \cap S$, $R - S$.
- Requieren que $R$ y $S$ sean **compatibles**: mismos atributos y dominios.

---

# Operaciones de Conjuntos

### Ejemplo: jugadores en categoría 1 o 2

$$\sigma_{categoria\_id = 1}(Jugador) \cup \sigma_{categoria\_id = 2}(Jugador)$$

### Equivalente SQL

```sql
SELECT * FROM Jugador WHERE categoria_id = 1
UNION
SELECT * FROM Jugador WHERE categoria_id = 2;
```

---

# Producto Cartesiano $\times$

## Definición

- $R \times S$ combina **cada tupla de $R$ con cada tupla de $S$**.
- Casi nunca se usa solo: el producto suele combinarse con una selección
  para filtrar combinaciones válidas → eso es el **join**.

---

# Renombrado $\rho$

## Definición

- $\rho_{S}(R)$ renombra la relación a $S$.
- $\rho_{S(a,b,c)}(R)$ renombra también los atributos.
- Útil al hacer un producto consigo misma (ej. comparar partidos).

---

# Join Natural $\bowtie$

## Definición

- Combina tuplas de $R$ y $S$ que coinciden en los **atributos comunes**.
- Notación: $R \bowtie S$.

---

# Join Natural $\bowtie$

### Ejemplo: jugadores con su categoría

$$Jugador \bowtie Categoria$$

### Equivalente SQL

```sql
SELECT * FROM Jugador NATURAL JOIN Categoria;
```

---

# $\theta$-join

## Definición

- Join con una condición arbitraria $\theta$.
- $R \bowtie_{\theta} S = \sigma_{\theta}(R \times S)$.

### Ejemplo: pares de jugadores con id menor

$$Jugador \bowtie_{Jugador.id < J2.id} \rho_{J2}(Jugador)$$

---

# División $\div$

## Definición

- $R \div S$: tuplas de $R$ que están relacionadas con **todas** las tuplas de $S$.
- Útil para preguntas tipo "jugadores que jugaron con **todos** los rivales del torneo".
- En SQL se traduce con `NOT EXISTS` anidados o `HAVING COUNT(*)`.

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

### Ejemplo: jugadores de la categoría 1

$$\{ t \mid t \in Jugador \land t.categoria\_id = 1 \}$$

### Equivalente SQL

```sql
SELECT * FROM Jugador WHERE categoria_id = 1;
```

---

# Cálculo de Dominios

## Forma general

$$\{ \langle x_1, ..., x_n \rangle \mid P(x_1, ..., x_n) \}$$

- Las variables recorren **valores** de cada atributo.

---

# Cálculo de Dominios

### Ejemplo: nombres en categoría 1

$$\{ \langle n \rangle \mid \exists i, c \, ( \langle i, n, c \rangle \in Jugador \land c = 1 ) \}$$

### Equivalente SQL

```sql
SELECT DISTINCT nombre FROM Jugador WHERE categoria_id = 1;
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
| $R - S$ | `EXCEPT` |
| $R \times S$ | `CROSS JOIN` |
| $R \bowtie S$ | `NATURAL JOIN` / `JOIN ... ON` |
| $\rho_{S}(R)$ | `AS S` |

---

# Ejercicios

## Para practicar

Sobre el esquema `Jugador`, `Categoria`, `Partido`, expresa en álgebra y luego
en SQL:

1. Nombres de jugadores de la categoría "Sub 15".
2. Pares (jugador, categoría) — sólo nombres.
3. Jugadores que han ganado al menos un partido como `jugador1`.
4. (Difícil) Jugadores que han enfrentado a **todos** los jugadores de su categoría.

---

# ¿Qué vimos hoy?

- Álgebra relacional: operadores básicos y derivados.
- Cálculo relacional: tuplas y dominios.
- Equivalencia entre ambos y con SQL.
- Mapeo directo álgebra → SQL.

---

# ¿Preguntas?

### Juega:

- Escribe en álgebra una consulta que ya sepas en SQL.
- Traduce un join complejo a $\sigma$ + $\times$.
- Inventa una consulta donde necesites división.
