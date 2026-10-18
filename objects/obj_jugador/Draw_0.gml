/// @description Dibujar al jugador y el Hit Flash

if (tiempo_flash > 0) {
    // Mismo efecto que obj_enemigo_dummy: niebla para pintar el sprite de un solo color
    gpu_set_fog(true, c_white, 0, 1);
    draw_self();
    gpu_set_fog(false, c_white, 0, 1);
} else {
    draw_self();
}
