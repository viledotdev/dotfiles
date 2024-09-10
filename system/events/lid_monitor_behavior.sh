
#!/bin/bash

# Obtener el estado de la tapa
LID_STATUS=$(awk '{print $2}' /proc/acpi/button/lid/LID/state)
echo $LID_STATUS
# Nombres de las salidas de pantalla (ajusta si es necesario)
LAPTOP_DISPLAY="eDP1"
EXTERNAL_DISPLAY=$(xrandr | grep " connected" | grep -v "$LAPTOP_DISPLAY" | awk '{ print $1 }')

echo $EXTERNAL_DISPLAY

if [ "$LID_STATUS" = "closed" ]; then
    # Desactiva la pantalla del portátil si la tapa está cerrada
    xrandr --output $LAPTOP_DISPLAY --off --output $EXTERNAL_DISPLAY --primary --auto
elif [ "$LID_STATUS" = "open" ]; then
    # Activa la pantalla del portátil como secundaria cuando la tapa está abierta
    xrandr --output $EXTERNAL_DISPLAY --primary --auto --output $LAPTOP_DISPLAY --auto --below $EXTERNAL_DISPLAY
fi
