---
title: "Reglas de Normalización en el Modelo Relacional"
author: "Diego Muñoz"
date: "3 Abril 2025"
theme: "metropolis"
aspectratio: 169
colorlinks: true
output: beamer_presentation
---

# Reglas de Normalización en el Modelo Relacional

## ¿Por qué normalizar?
- La **normalización** mejora la **estructura lógica** de una base de datos.
- Elimina **redundancias**, evita **anomalías** (de inserción, actualización y borrado).
- Mejora la **consistencia** y facilita el **mantenimiento**.

---

# ¿Qué es la normalización?

\begin{table}[h!]
\centering
\begin{tabular}{|c|l|l|l|c|l|c|l|l|}
\hline
\textbf{ID} & \textbf{Nombre} & \textbf{Contacto} & \textbf{Curso} & \textbf{Dur. C} & \textbf{Tema} & \textbf{Dur. T} & \textbf{Instructor} & \textbf{Cont. I} \\
\hline
1 & Pepe & 78657858 & Progra & 6 & SQL & 1.5 & Raúl & 875675675 \\
1 & Pepe & 78657858 & Progra & 6 & Python & 3 & Cristian & 875675676 \\
1 & Pepe & 78657858 & Progra & 6 & Excel & 1.5 & Joel & 875675677 \\
1 & Pepe & 78657858 & Progra & 6 & Power BI & 1.5 & Diego & 875675678 \\
2 & Juan & 88657859 & Progra & 6 & SQL & 1.5 & Raúl & 875675675 \\
2 & Juan & 88657859 & Progra & 6 & Python & 3 & Cristian & 875675676 \\
2 & Juan & 88657859 & Progra & 6 & Excel & 1.5 & Joel & 875675677 \\
2 & Juan & 88657859 & Progra & 6 & Power BI & 1.5 & Diego & 875675678 \\
\hline
\end{tabular}
\caption{Detalles del curso por estudiante y tema}
\end{table}

---

# ¿Qué es la normalización?

Relación estudiantes:

\begin{table}[h!]
\centering
\begin{tabular}{|c|l|l|l|l|l|}
\hline
\textbf{ID}  & \textbf{Nombre} & \textbf{Contacto} \\
\hline
1 & Pepe & 78657858 \\
2 & Juan & 88657859 \\
\hline
\end{tabular}
\caption{Detalles del curso por estudiante}
\end{table}

---

# ¿Qué es la normalización?

Relación cursos:
\begin{table}[h!]
\centering
\begin{tabular}{|c|l|l|l|l|}
\hline
\textbf{ID} & \textbf{Curso} & \textbf{Dur. C} \\
\hline
1 & Progra & 6 \\
\hline
\end{tabular}
\caption{Detalles del curso}
\end{table}

---

# ¿Qué es la normalización?

Relación temas:

\begin{table}[h!]
\centering
\begin{tabular}{|c|l|l|l|}
\hline
\textbf{ID} & \textbf{Tema} & \textbf{Dur. T} & \textbf{Instructor} \\
\hline
1 & SQL & 1.5 & Raúl \\
1 & Python & 3 & Cristian \\
1 & Excel & 1.5 & Joel \\
1 & Power BI & 1.5 & Diego \\
\hline
\end{tabular}
\caption{Detalles del curso por tema}
\end{table}

---

# ¿Qué es la normalización?

Relación instructores:

\begin{table}[h!]
\centering
\begin{tabular}{|c|l|l|}
\hline
\textbf{ID} & \textbf{Instructor} & \textbf{Cont. I} \\
\hline
1 & Raúl & 875675675 \\
1 & Cristian & 875675676 \\
1 & Joel & 875675677 \\
1 & Diego & 875675678 \\
\hline
\end{tabular}
\caption{Detalles del curso por instructor}
\end{table}

---

# Normalización

La normalización se lleva a cabo mediante una serie de pasos denominados formas
normales. Cada forma normal de tiene unos requisitos específicos:

1. Primera forma normal (1FN)
1. Segunda forma normal (2FN)
1. Tercera forma normal (3FN)
1. Forma normal Boyce-Codd (BCFN)
1. Cuarta forma normal (4FN)
1. Quinta forma normal (5FN)

---

# Primera Forma Normal (1FN)

## Reglas:
- Cada **atributo** contiene **valores atómicos**.
- No se permiten **repeticiones** ni listas de valores en una sola celda.

---

# Primera Forma Normal (1FN)

### Ejemplo: **No Normalizado**

\begin{table}[h!]
\centering
\caption{Ejemplo no normalizado (violación 1FN)}
\begin{tabular}{|c|l|l|}
\hline
\textbf{ID} & \textbf{Nombre} & \textbf{Cursos} \\
\hline
1 & Pepe & SQL, Python, Excel \\
\hline
\end{tabular}
\end{table}

### Convertido a 1FN:

\begin{table}[h!]
\centering
\caption{Convertido a 1FN}
\begin{tabular}{|c|l|l|}
\hline
\textbf{ID} & \textbf{Nombre} & \textbf{Curso} \\
\hline
1 & Pepe & SQL \\
1 & Pepe & Python \\
1 & Pepe & Excel \\
\hline
\end{tabular}
\end{table}

---

# Segunda Forma Normal (2FN)

## Reglas:
- Cumple con 1FN.
- Todos los **atributos no clave** dependen de **toda la clave primaria** (no solo de una parte).

---

# Segunda Forma Normal (2FN)

### Ejemplo: Violando 2FN

\begin{table}[h!]
\centering
\caption{Violación de 2FN}
\begin{tabular}{|c|c|l|l|}
\hline
\textbf{EstudianteID} & \textbf{CursoID} & \textbf{EstudianteNombre} & \textbf{CursoNombre} \\
\hline
1 & 101 & Pepe & Progra \\
\hline
\end{tabular}
\end{table}

---

# Segunda Forma Normal (2FN)

### Convertido a 2FN:

\begin{table}[h!]
\centering
\caption{Estudiante Convertido a 2FN}
\begin{tabular}{|c|l|}
\hline
\textbf{EstudianteID} & \textbf{EstudianteNombre} \\
\hline
1 & Pepe \\
\hline
\end{tabular}
\end{table}

\begin{table}[h!]
\centering
\caption{Curso Convertido a 2FN}
\begin{tabular}{|c|l|}
\hline
\textbf{CursoID} & \textbf{CursoNombre} \\
\hline
101 & Progra \\
\hline
\end{tabular}
\end{table}

---

# Segunda Forma Normal (2FN)

### Convertido a 2FN (continuación):

\begin{table}[h!]
\centering
\caption{Inscripciones}
\begin{tabular}{|c|c|}
\hline
\textbf{EstudianteID} & \textbf{CursoID} \\
\hline
1 & 101 \\
\hline
\end{tabular}
\end{table}

---

# Tercera Forma Normal (3FN)

## Reglas:
- Cumple con 2FN.
- No hay **dependencias transitivas** (atributos no clave no dependen de otros no clave).

---

# Tercera Forma Normal (3FN)

### Ejemplo: Violando 3FN

\begin{table}[h!]
\centering
\caption{Violación de 3FN}
\begin{tabular}{|c|l|l|l|}
\hline
\textbf{CursoID} & \textbf{CursoNombre} & \textbf{Departamento} & \textbf{JefeDepto} \\
\hline
101 & Progra & TI & Carla \\
\hline
\end{tabular}
\end{table}

Violación: `JefeDepto` depende de `Departamento`, no directamente de la clave.

---

# Tercera Forma Normal (3FN)

### Convertido a 3FN:

\begin{table}[h!]
\centering
\caption{Cursos (3FN)}
\begin{tabular}{|c|l|l|}
\hline
\textbf{CursoID} & \textbf{CursoNombre} & \textbf{Departamento} \\
\hline
101 & Progra & TI \\
\hline
\end{tabular}
\end{table}

\begin{table}[h!]
\centering
\caption{Departamentos}
\begin{tabular}{|l|l|}
\hline
\textbf{Departamento} & \textbf{JefeDepto} \\
\hline
TI & Carla \\
\hline
\end{tabular}
\end{table}

---

# Boyce-Codd Normal Form (BCFN)

## Reglas:
- Cumple con 3FN.
- Para **toda dependencia funcional** `X → Y`, **X debe ser clave candidata**.

---

# Boyce-Codd Normal Form (BCFN)

### Ejemplo: Cumple 3FN pero no BCFN

\begin{table}[h!]
\centering
\begin{tabular}{|c|c|c|}
\hline
\textbf{Profesor} & \textbf{Curso} & \textbf{Aula} \\
\hline
Ana & BD & 101A \\
Juan & BD & 101A \\
Ana & SQL & 102B \\
Juan & SQL & 102B \\
\hline
\end{tabular}
\caption{Tabla original (violación de BCNF)}
\end{table}

- Dependencias:
  - `Profesor, Curso → Aula`
  - `Aula → Profesor` (Aula determina profesor, pero Aula no es clave candidata)

---

# Boyce-Codd Normal Form (BCFN)

### Convertido a BCFN:

\begin{table}[h!]
\centering
\begin{tabular}{|c|c|}
\hline
\textbf{Aula} & \textbf{Profesor} \\
\hline
101A & Ana \\
102B & Ana \\
101A & Juan \\
102B & Juan \\
\hline
\end{tabular}
\caption{Tabla de Aulas (después de la normalización a BCNF)}
\end{table}

\begin{table}[h!]
\centering
\begin{tabular}{|c|c|}
\hline
\textbf{Profesor} & \textbf{Curso} \\
\hline
Ana & BD \\
Juan & BD \\
Ana & SQL \\
Juan & SQL \\
\hline
\end{tabular}
\caption{Tabla de Cursos (después de la normalización a BCNF)}
\end{table}

---

# Cuarta Forma Normal (4FN)

## Reglas:
- Cumple con BCFN.
- No existen **dependencias multivaluadas no triviales**.

---

# Quinta Forma Normal (5FN)

## Reglas:
- Cumple con 4FN.
- No hay **dependencias de unión no triviales**.

---

# Resumen y Próximos Pasos

## Hoy aprendimos:
[x] Qué es la normalización y por qué es importante  
[x] Cómo aplicar 1FN, 2FN y 3FN con ejemplos visuales  
[x] Qué son BCFN, 4FN y 5FN (visión general)

---

# Resumen (Extendido)

## Formas Normales:
- **1FN**: valores atómicos.
- **2FN**: sin dependencias parciales (atributos no clave dependen de toda la clave).
- **3FN**: sin dependencias transitivas (atributos no clave dependen de otros no clave).
- **BCFN**: solo claves candidatas determinan atributos (sin dependencias funcionales no triviales).
- **4FN**: sin dependencias multivaluadas.
- **5FN**: sin dependencias de unión.

---

# Preguntas y Discusión
¿Tienes dudas? ¡Hablemos!
