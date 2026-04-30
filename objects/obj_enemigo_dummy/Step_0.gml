// 1. GRAVEDAD OBLIGATORIA (Ya que hereda de obj_entidad, asumo que tienes la variable gravedad)
vsp += gravedad;
if (vsp > vsp_maxima) {
    vsp = vsp_maxima;
}

if (tiempo_flash > 0) {
    tiempo_flash -= 1;
}

// Opcional: Detectar suelo (útil si quieres que el enemigo solo ataque si está pisando firme)
var _en_el_suelo = choca_con_tile(x, y + 1);


// 2. SISTEMA DE FÍSICAS VS INTELIGENCIA ARTIFICIAL
if (tiempo_aturdido > 0) {
    tiempo_aturdido -= 1;
    
    // Fricción solo en X. ¡Dejamos que la gravedad siga afectando en Y!
    hsp = lerp(hsp, 0, friccion); 

} else {

    if (instance_exists(obj_jugador)) {
        // Distancia absoluta (teorema de Pitágoras) para saber qué tan lejos está
        var _distancia_a_josh = point_distance(x, y, obj_jugador.x, obj_jugador.y);
    
        switch (estado_actual) {
            
            case ENEMY_STATE.IDLE:
                hsp = lerp(hsp, 0, 0.2); // Fricción para quedarse quieto
                
                // Transición: Si Josh entra en su radio de visión
                if (_distancia_a_josh <= radio_vision) {
                    estado_actual = ENEMY_STATE.CHASE;
                }
            break;
            
            case ENEMY_STATE.CHASE:
                // Transición: Volver a IDLE si se aleja mucho
                if (_distancia_a_josh > radio_vision * 1.5) { 
                    estado_actual = ENEMY_STATE.IDLE;
                } 
                // Transición: Atacar si está lo suficientemente cerca
                else if (_distancia_a_josh <= distancia_ataque) { 
                    estado_actual = ENEMY_STATE.ATTACK;
                    image_index = 0; 
                    hitbox_creada = false; 
                }
                else {
                    // COMPORTAMIENTO 2D LATERAL:
                    // sign() devuelve 1 si está a la derecha, -1 si está a la izquierda
                    var _direccion_x = sign(obj_jugador.x - x);
                    
                    // Solo modificamos hsp. ¡Dejamos vsp en paz para la gravedad!
                    hsp = _direccion_x * velocidad_caminar;
                    
                    // Voltear el sprite visualmente
                    if (_direccion_x != 0) {
                        image_xscale = _direccion_x;
                    }
                }
            break;
            case ENEMY_STATE.ATTACK:
                // El enemigo se frena para atacar (solo en X)
                hsp = lerp(hsp, 0, 0.2);
            
                // Crear Hitbox en el frame específico de la animación
                if (image_index >= 1 && !hitbox_creada) {
                    var _hitbox = instance_create_layer(x, y, "Instances", obj_hitbox);
                    
                    _hitbox.creador = id;
                    _hitbox.objetivo_colision = obj_jugador;
                    _hitbox.dano = 10; 
                    _hitbox.max_objetivos = 1;
                    _hitbox.tiempo_aturdido = 15;
                    _hitbox.fuerza_empuje = 7;
                    
                    // El empuje debe ser lateral (0 o 180), no en ángulo hacia el jugador
                    _hitbox.direccion_golpe = (image_xscale == 1) ? 0 : 180;
                    _hitbox.enemigos_golpeados = [];
                    
                    hitbox_creada = true;
                }
                // Terminar el ataque
                if (image_index + image_speed >= image_number) {
                    estado_actual = ENEMY_STATE.IDLE;
                }
            break;
        }
    } else {
        // Si el jugador no existe (murió), el enemigo se queda quieto
        hsp = lerp(hsp, 0, 0.2);
        estado_actual = ENEMY_STATE.IDLE;
    }
}

// 3. APLICAR MOVIMIENTO Y MUERTE
aplicar_movimiento();

if (hp <= 0) {
    instance_destroy();
}