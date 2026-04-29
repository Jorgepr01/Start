/// @description Actualizar Profundidad (Y-Sorting)
vsp += gravedad;
if (vsp > vsp_maxima) {
    vsp = vsp_maxima;
}

// La profundidad es igual a la posición vertical invertida.
// Mientras más abajo estés en la pantalla (mayor Y), menor será tu depth, 
// por lo que GameMaker te dibujará por encima de los demás.
depth = -y;