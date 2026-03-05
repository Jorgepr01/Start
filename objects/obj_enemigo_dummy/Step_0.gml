if (tiempo_flash > 0) {
    tiempo_flash -= 1;
}

hsp = lerp(hsp, 0, friccion);
vsp = lerp(vsp, 0, friccion);

aplicar_movimiento();

if (hp <= 0) {
    instance_destroy();
}