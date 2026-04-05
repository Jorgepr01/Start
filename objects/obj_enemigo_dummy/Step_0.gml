if (tiempo_flash > 0) {
    tiempo_flash -= 1;
}
// Calculamos la magnitud del vector de velocidad actual (Teorema de Pitágoras)
var _velocidad_actual = point_distance(0, 0, hsp, vsp);

// 2. SISTEMA DE FÍSICAS VS INTELIGENCIA ARTIFICIAL
if (tiempo_aturdido > 0) {
    // Si estamos aturdidos, reducimos el tiempo
    tiempo_aturdido -= 1;
    
    // Apagamos la IA temporalmente y aplicamos fricción al knockback
    hsp = lerp(hsp, 0, friccion); // 
    vsp = lerp(vsp, 0, friccion); // 

} else {

    if (instance_exists(obj_jugador)) {
        // Calculamos la magnitud del vector (distancia) hacia Josh
        var _distancia_a_josh = point_distance(x, y, obj_jugador.x, obj_jugador.y);
    
        switch (estado_actual) {
            case ENEMY_STATE.IDLE:
                // Transición: Si Josh entra en su radio de visión, ¡empieza la cacería!
                if (_distancia_a_josh <= radio_vision) {
                    estado_actual = ENEMY_STATE.CHASE;
                }
            break;
            
            case ENEMY_STATE.CHASE:
                // Transición: Si Josh se aleja demasiado, se rinde y vuelve a IDLE
                if (_distancia_a_josh > radio_vision * 1.5) { 
                    estado_actual = ENEMY_STATE.IDLE;
                } 
                else {
                    // Comportamiento: Calcular el vector de movimiento hacia Josh
                    var _direccion_a_josh = point_direction(x, y, obj_jugador.x, obj_jugador.y);
                    
                    // Sobrescribimos hsp y vsp con la velocidad de persecución
                    hsp = lengthdir_x(velocidad_caminar, _direccion_a_josh);
                    vsp = lengthdir_y(velocidad_caminar, _direccion_a_josh);
                    
                    // (Opcional) Voltear el sprite para que mire hacia donde camina
                    if (hsp != 0) image_xscale = sign(hsp);
                }
            break;
        }
    }
}



aplicar_movimiento();

if (hp <= 0) {
    instance_destroy();
}