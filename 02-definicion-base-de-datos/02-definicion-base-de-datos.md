---
title: "Introducción a Bases de Datos y Modelos de Datos"
author: "Diego Muñoz"
date: "1 Febrero 2025"
theme: "metropolis"
aspectratio: 169
colorlinks: true
---

# Introducción

## ¿Por qué usamos bases de datos?
- Permiten almacenar y gestionar información de manera eficiente.
- Evitan la redundancia y garantizan la integridad de los datos.
- Son la base para aplicaciones modernas y sistemas de información.

---

# Definición de Base de Datos

## ¿Qué es una base de datos?
- Una colección organizada de datos.
- Permite el acceso, manipulación y consulta eficiente.
- Puede estar centralizada o distribuida.

## Características principales
- **Persistencia:** Los datos permanecen en el tiempo.
- **Integridad:** Asegura la consistencia y validez de los datos.
- **Seguridad:** Control de acceso y restricciones.
- **Facilidad de consulta:** Uso de lenguajes como SQL para recuperar información.

---

# Tipos de Bases de Datos

## Relacionales (SQL)
- Organizadas en **tablas** con filas y columnas.
- Basadas en el **modelo relacional**.
- Usan **claves primarias y foráneas**.
- Ejemplos: MySQL, PostgreSQL, SQL Server.

## No Relacionales (NoSQL)
- No usan tablas estructuradas.
- Se dividen en:
  - **Documentos** (MongoDB)
  - **Clave-Valor** (Redis)
  - **Columnares** (Cassandra)
  - **Grafos** (Neo4j)

---

# Tipos de Bases de Datos

## Bases de Datos en Memoria
- Almacenadas en **RAM** para acceso ultrarrápido.
- Ejemplo: Redis, Memcached.

## Bases de Datos Distribuidas
- Replicadas en múltiples nodos para **alta disponibilidad**.
- Ejemplo: Google Spanner, Apache Cassandra.

---

# Modelos de Datos

## ¿Qué es un Modelo de Datos?
- Una representación estructurada de cómo se organizan y almacenan los datos.

## Modelos principales
### Modelo Relacional
- Datos organizados en **tablas**.
- Relaciones a través de **claves primarias y foráneas**.
- Ejemplo: PostgreSQL.

### Modelo Documento
- Almacena datos como **documentos JSON o BSON**.
- Ejemplo: MongoDB.

---

# Modelos de Datos

### Modelo Clave-Valor
- Datos almacenados en **pares clave-valor**.
- Ejemplo: Redis.

### Modelo Grafos
- Representa datos con **nodos y relaciones**.
- Ejemplo: Neo4j.

---

# Diseño de Bases de Datos

## Normalización
- Proceso para reducir la **redundancia** y mejorar la **integridad**.
- Divide las tablas en formas normales (1NF, 2NF, 3NF, BCNF).

## Desnormalización
- Se usa para **optimizar rendimiento**, duplicando algunos datos.
- Ejemplo: En sistemas de reportes o análisis de datos.

## Claves en Bases de Datos
- **Clave Primaria:** Identifica de manera única cada registro.
- **Clave Foránea:** Relaciona dos tablas.

---

# Introducción a SQL

## Creación de una Tabla
```sql
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100) UNIQUE,
    edad INT
);
```

## Consultas Básicas
```sql
SELECT * FROM usuarios;
INSERT INTO usuarios (nombre, correo, edad) \ 
  VALUES ('Juan', 'juan@email.com', 30);
UPDATE usuarios SET edad = 31 WHERE id = 1;
DELETE FROM usuarios WHERE id = 1;
```

---

# Resumen y Próximos Pasos

## Lo aprendido hoy:
[x] ¿Qué es una base de datos y para qué se usa?  
[x] Tipos de bases de datos y sus características.  
[x] Modelos de datos y cuándo usarlos.  
[x] Introducción a SQL.  

## Próxima clase: **Modelo Entidad-Relación (E-R)**
- Representación gráfica de bases de datos.
- Identificación de entidades y relaciones.
- Creación de diagramas E-R.

---

# Preguntas y Discusión
¿Dudas? ¡Hablemos!
