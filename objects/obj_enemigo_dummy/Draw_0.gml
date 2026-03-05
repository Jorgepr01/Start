/// @description Dibujar el enemigo y el Hit Flash

if (tiempo_flash > 0) {
    // 1. Encendemos la "niebla" blanca en la GPU
    gpu_set_fog(true, c_gray, 0, 1);
    // 2. Dibujamos al enemigo (ahora saldrá totalmente blanco)
    draw_self();
    // 3. APAGAMOS la niebla inmediatamente para no pintar el resto del juego
    gpu_set_fog(false, c_gray, 0, 1);
} else {
    // Si el temporizador es 0, dibujamos al enemigo normal con sus colores
    draw_self();
}