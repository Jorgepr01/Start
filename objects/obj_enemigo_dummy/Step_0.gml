// --- HIT STOP (Freeze Frames) ---
if (hit_stop_timer > 0) {
    hit_stop_timer--;
    if (hit_stop_timer == 0) {
        image_speed = velocidad_animacion_guardada;
    } else {
        if (image_speed != 0) {
            velocidad_animacion_guardada = image_speed;
            image_speed = 0;
        }
        exit; // Evita que se ejecute el resto del código
    }
}

// 1. GRAVEDAD OBLIGATORIA
var _en_el_suelo = choca_con_tile(x, y + 1);

if (!_en_el_suelo) {
    vsp += gravedad;
    if (vsp > vsp_maxima) {
        vsp = vsp_maxima;
    }
} else {
    if (vsp > 0) vsp = 0;
}

if (tiempo_flash > 0) {
    tiempo_flash -= 1;
}

// 2. SISTEMA DE FÍSICAS VS INTELIGENCIA ARTIFICIAL
if (tiempo_aturdido > 0) {
    estado_actual = ENEMY_STATE.DAZED;
}

if (instance_exists(obj_jugador)) {
    // Distancia absoluta (teorema de Pitágoras) para saber qué tan lejos está
    var _distancia_a_josh = point_distance(x, y, obj_jugador.x, obj_jugador.y);

    switch (estado_actual) {
        
        case ENEMY_STATE.DAZED:
            tiempo_aturdido -= 1;
            hsp = lerp(hsp, 0, friccion); 
            
            if (tiempo_aturdido <= 0) {
                estado_actual = ENEMY_STATE.IDLE;
            }
        break;

        case ENEMY_STATE.IDLE:
                hsp = lerp(hsp, 0, 0.2); // Fricción para quedarse quieto
                sprite_index=Josh
                // Transición: Si Josh entra en su radio de visión
                if (_distancia_a_josh <= radio_vision) {
                    estado_actual = ENEMY_STATE.CHASE;
                }
            break;
            
            case ENEMY_STATE.CHASE:
                // Transición: Volver a IDLE si se aleja mucho
                if (_distancia_a_josh > radio_vision * 1.5) { 
                    estado_actual = ENEMY_STATE.IDLE;
                    sprite_index=Josh
                } 
                // Transición: Atacar si está lo suficientemente cerca
                else if (_distancia_a_josh <= distancia_ataque) { 
                    estado_actual = ENEMY_STATE.ATTACK;
                    image_index = 0; 
                    hitbox_creada = false; 
                    
                }
                else {
                    sprite_index=Josh_step_derecha
                    var _direccion_x = sign(obj_jugador.x - x);
                    hsp = _direccion_x * velocidad_caminar;
                    if (_direccion_x != 0) {
                        image_xscale = _direccion_x;
                    }
                }
            break;
            case ENEMY_STATE.ATTACK:
                hsp = lerp(hsp, 0, 0.2);
                sprite_index=Josh_attack
                
                // Crear Hitbox en el frame específico de la animación
                if (image_index >= 8 && !hitbox_creada) {
                    var _hitbox = instance_create_layer(x, y, "Instances", obj_hitbox);
                    
                    _hitbox.creador = id;
                    _hitbox.objetivo_colision = obj_jugador;
                    _hitbox.dano = 10; 
                    _hitbox.max_objetivos = 1;
                    _hitbox.tiempo_aturdido = 15;
                    _hitbox.fuerza_empuje = 7;
                    _hitbox.shake_magnitude = 3;
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


// 3. APLICAR MOVIMIENTO Y MUERTE
aplicar_movimiento();

if (hp <= 0) {
    instance_destroy();
}