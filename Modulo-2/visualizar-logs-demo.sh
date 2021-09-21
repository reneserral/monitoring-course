#!/bin/bash

AUTH_LOG="/var/log/auth.log"
LOG_FILE2="/var/log/syslog"
COMPRESSED_LOG="/var/log/apt/history.0.gz"

# Generando un fichero de log comprimido (es copia de otro ya que con la máquina nueva no tenemos logs
( cd /var/log/apt ; cat history | gzip > history.0.gz )

# Demo de visualización de logs en Linux
# Visualizar un fichero de log (paginar mediante el comando 'more' o 'less')
cat $AUTH_LOG
echo ""
echo "- Visualiza un fichero de log mediante el comando 'cat'"
echo "  cat $AUTH_LOG"
read -p "Presione una tecla para continuar . . ." && clear

# Mostrar las líneas que coinciden con un patrón (siguientes 9 con -A, anteriores con -B, cercanas con -C)
grep "session opened for user" $AUTH_LOG
echo ""
echo "- Búsqueda de un patrón mediante el comando 'grep'"
echo "  grep \"session opened for user\" $AUTH_LOG"
read -p "Presione una tecla para continuar . . ." && clear

# Mostrar las primeras 10 líneas de un fichero
head -n 10 $LOG_FILE2
echo ""
echo "- Muestra las primeras 10 líneas de un fichero mediante el comando 'head'"
echo "  head -n 10 $LOG_FILE2"
read -p "Presione una tecla para continuar . . ." && clear

# Mostrar las últimas 10 líneas de un fichero
tail -n 10 $LOG_FILE2
echo ""
echo "- Muestra las últimas 10 líneas de un fichero mediante el comando 'tail'"
echo "  tail -n 10 $LOG_FILE2"
read -p "Presione una tecla para continuar . . ." && clear

# Ignorar las primeras 10 líneas de un fichero
tail -n +11 $LOG_FILE2
echo ""
echo "- Ignora las primeras 10 líneas de un fichero mediante el comando 'tail'"
echo "  tail -n +11 $LOG_FILE2"
read -p "Presione una tecla para continuar . . ." && clear

# Buscar un patrón (y líneas cercanas) en un fichero comprimido
zcat $COMPRESSED_LOG | grep -C 2 "Commandline:"
echo ""
echo "- Busca un patrón en un fichero comprimido mediante el comando 'zcat'"
echo "  zcat $COMPRESSED_LOG | grep -C 2 \"Commandline:\""
read -p "Presione una tecla para continuar . . ." && clear

# Visualiza un fichero numerando las líneas
cat -n $LOG_FILE2
echo ""
echo "- Visualiza un fichero numerando las líneas"
echo "  cat -n $LOG_FILE2"
read -p "Presione una tecla para continuar . . ."&&clear

