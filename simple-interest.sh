#!/usr/bin/env bash
# Calcula interés simple: I = P * R * T / 100
# Uso: ./simple-interest.sh <principal> <rate%> <time>
set -euo pipefail

if [[ "${#}" -ne 3 ]]; then
  echo "Uso: $0 <principal> <tasa%> <tiempo>"
  echo "Ej:  $0 1000 5 2"
  exit 1
fi

P="$1"
R="$2"
T="$3"

# Validación numérica simple
re='^[0-9]+([.][0-9]+)?$'
for v in "$P" "$R" "$T"; do
  if ! [[ $v =~ $re ]]; then
    echo "Error: todos los parámetros deben ser numéricos." >&2
    exit 1
  fi
done

I=$(awk -v p="$P" -v r="$R" -v t="$T" 'BEGIN { printf "%.2f", (p*r*t)/100 }')
A=$(awk -v p="$P" -v i="$I" 'BEGIN { printf "%.2f", p+i }')

echo "Principal : $P"
echo "Tasa (%)  : $R"
echo "Tiempo    : $T"
echo "Interés   : $I"
echo "Total     : $A"
