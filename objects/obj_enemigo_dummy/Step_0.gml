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
                }else if (_distancia_a_josh <= distancia_ataque) { // <--- TRANSICIÓN AL ATAQUE
                estado_actual = ENEMY_STATE.ATTACK;
                image_index = 0; // Reiniciamos la animación
                hitbox_creada = false; // Quitamos el candado
                // sprite_index = spr_enemigo_ataque; // (Descomenta esto si ya tienes sprite)
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
            case ENEMY_STATE.ATTACK:
            hsp = lerp(hsp, 0, 0.2);
            vsp = lerp(vsp, 0, 0.2);
            
            // 2. Crear la hitbox en el "Frame de Impacto"
            // Digamos que tu enemigo da el golpe visualmente en el frame 3 de su animación
            if (image_index >= 1 && !hitbox_creada) {
                var _hitbox = instance_create_layer(x, y, "Instances", obj_hitbox);
                _hitbox.creador = id;
                _hitbox.objetivo_colision = obj_jugador; // ¡Apunta al jugador!
                
                // Parámetros del golpe enemigo
                _hitbox.dano = 10; 
                _hitbox.max_objetivos = 1;
                _hitbox.tiempo_aturdido = 15; // Tiempo que el jugador queda paralizado
                _hitbox.fuerza_empuje = 7;
                _hitbox.direccion_golpe = point_direction(x, y, obj_jugador.x, obj_jugador.y);
                _hitbox.enemigos_golpeados = [];
                
                hitbox_creada = true; // Ponemos el candado
            }
            
            // 3. Terminar el ataque
            if (image_index + image_speed >= image_number) {
                estado_actual = ENEMY_STATE.IDLE;
                // sprite_index = spr_enemigo_idle; // (Volver a sprite normal)
            }
            break;
        }
    }
}



aplicar_movimiento();

if (hp <= 0) {
    instance_destroy();
}