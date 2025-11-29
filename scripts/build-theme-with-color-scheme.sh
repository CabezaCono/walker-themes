#!/bin/bash

COLOR_SCHEME=$1
THEME=$2

WALKERDIR="$HOME/.config/walker"
SRC_DIR="$WALKERDIR/themes/$THEME"
DEST_DIR="$WALKERDIR/themes/current"

mkdir -p "$DEST_DIR"

rm -rf "$DEST_DIR"/*

cp -R "$SRC_DIR/"* "$DEST_DIR/"

# Eliminamos la primera línea del style.css original
# Esto genera un archivo temporal "base.css"
tail -n +2 "$SRC_DIR/style.css" > "$DEST_DIR/base.css"

# Construimos style.css final colocando colores primero
cat "$WALKERDIR/colors/$COLOR_SCHEME.css" "$DEST_DIR/base.css" > "$DEST_DIR/style.css"

rm "$DEST_DIR/base.css"

echo "Tema '$THEME' generado en $DEST_DIR/style.css con esquema '$COLOR_SCHEME'"
