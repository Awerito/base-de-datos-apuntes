# Bases de Datos – Apuntes

Repositorio con los apuntes y materiales de las clases del curso. Cada carpeta
contiene el archivo principal de la sesión en formato Markdown y su versión en
PDF generada con Pandoc.

## Estructura de carpetas

- `00-extras/`: Materiales complementarios (syllabus, referencias).
- `01-introduccion-bd/` a `14-orm-aplicacion/`: Apuntes principales de cada clase
numerada. Dentro de cada carpeta encontrarás un archivo `NN-nombre.md` y su PDF
correspondiente.

## Cómo generar todos los PDFs

1. Instala las dependencias necesarias:
   - [Pandoc](https://pandoc.org/) (variable `PANDOC_COMMAND`, por defecto
   `pandoc`).
   - Un motor LaTeX con soporte para XeLaTeX (por ejemplo, TeX Live) utilizado
   por Pandoc (`PDF_ENGINE`, por defecto `xelatex`).

1. Corre el siguiente comando ejemplo
```bash
pandoc -t beamer --pdf-engine=xelatex archivo.md -o <archivo>.pdf
```

Puedes sobreescribir el comando de Pandoc y el motor de PDF mediante las
variables de entorno `PANDOC_COMMAND` y `PDF_ENGINE` al ejecutar el script.
