# Setup

## Dependencias (Arch Linux / CachyOS)

```bash
sudo pacman -S pandoc texlive-basic texlive-fontsrecommended texlive-latexextra texlive-langspanish texlive-binextra texlive-xetex
```

## Compilar un PDF

```bash
pandoc -t beamer --pdf-engine=xelatex archivo.md -o archivo.pdf
```
