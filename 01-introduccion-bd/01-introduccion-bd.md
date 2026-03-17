---
title: "Introducción a Bases de Datos"
author: "Diego Muñoz"
date: "1 Febrero 2025"
theme: "metropolis"
aspectratio: 169
colorlinks: true
---

# Introducción a Bases de Datos

## Objetivos de la Clase  
- Comprender la diferencia entre datos e información.  
- Entender qué es una base de datos y por qué es útil.  
- Diferenciar bases de datos relacionales y no relacionales.  
- Introducir brevemente SQL.  
- Prepararnos para el Modelo Entidad-Relación (E-R).  

---

# Fundamentos de Bases de Datos

## ¿Qué son los Datos?  
Los datos son hechos o valores sin procesar, sin contexto ni significado.  

**Ejemplo:**  
- "Juan"  
- "25"  
- "Rojo"  

---

# Fundamentos de Bases de Datos

## ¿Qué es la Información?  
La información es el resultado de organizar y dar significado a los datos.  

**Ejemplo:**  
*"Juan tiene 25 años y su color favorito es el rojo."*  

---

# Fundamentos de Bases de Datos

## Diferencia entre Datos e Información  
- **Datos:** Son valores individuales sin contexto.  
  - Ejemplo: *"42", "Madrid", "Rojo"*.  
- **Información:** Es el resultado de procesar y organizar los datos.  
  - Ejemplo: *"El usuario tiene 42 años, vive en Madrid y su color favorito es el rojo."*  

---

# ¿Qué es una Base de Datos?

## Definición  
Una **base de datos** es un sistema que almacena y organiza datos de manera estructurada para facilitar su acceso y manipulación.  

---

# ¿Qué es una Base de Datos?

## Ejemplo Práctico  
Una lista de contactos en papel vs. una lista de contactos en una aplicación:  

- **Papel:** Difícil de buscar y actualizar.  
- **Aplicación:** Rápida búsqueda, modificación y almacenamiento.  

---

# Tipos de Bases de Datos

## Bases de Datos Relacionales vs No Relacionales  
- **Bases de Datos Relacionales (SQL):** Organizan la información en tablas con relaciones entre ellas.  
- **Bases de Datos No Relacionales (NoSQL):** Almacenan información en documentos, grafos, pares clave-valor, etc.  

---

# Introducción a SQL

## ¿Qué es SQL?  
**SQL (Structured Query Language)** es el lenguaje estándar para interactuar con bases de datos relacionales.  

---

# Introducción a SQL

## Ejemplo de una Consulta SQL  

```sql
SELECT * FROM usuarios;
```

Esta consulta selecciona **todos** los registros de la tabla *usuarios*.  

---

# Aplicación en la Vida Real

## ¿Dónde se usan Bases de Datos?  
- Redes sociales (almacenamiento de perfiles y publicaciones).  
- Comercio electrónico (gestión de productos, pedidos y clientes).  
- Videojuegos (almacenamiento de partidas y datos de usuarios).  
- Bancos (transacciones y cuentas de clientes).  

---

# ¿Por qué necesitamos modelar datos?

Antes de construir una base de datos, es fundamental diseñarla correctamente.  

- Evita redundancia y errores en la información.  
- Permite una mejor organización y escalabilidad.  
- Facilita el mantenimiento y comprensión de los datos.  

Aquí es donde entra el **Modelo Entidad-Relación (E-R)**.  

---

# ¿Qué es un Modelo de Datos?

Existen diferentes formas de representar y estructurar los datos:  

- **Modelo Jerárquico** → Organiza los datos en forma de árbol.  
- **Modelo de Redes** → Relaciona datos de manera más flexible.  
- **Modelo Relacional** → Basado en tablas y relaciones (el que nos interesa).  

El **Modelo Relacional** es la base de las bases de datos SQL y se diseña utilizando **Modelo Entidad-Relación**.  

---

# Conclusiones y Próximos Pasos

- Diferenciamos **Datos vs. Información**.  
- Comprendimos qué es una **Base de Datos** y sus tipos.  
- Introdujimos brevemente **SQL**.  
- Vimos la importancia de **modelar datos antes de construir una base de datos**.  

**Próxima clase: Modelo Entidad-Relación (E-R)**  

---

# Preguntas y Discusión  
¿Tienes dudas? ¡Hablemos!  
