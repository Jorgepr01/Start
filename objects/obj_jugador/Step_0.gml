/// @description Máquina de Estados y Movimiento



switch (estado) {
    
    // ==========================================
    case PLAYER_STATE.IDLE: // ESTADO: INACTIVO
    // ==========================================
        hsp = 0;
        vsp = 0;
        var _dir_cuadrante = round(direccion_mirando / 90) mod 4;
        switch (_dir_cuadrante) {
            case 0: sprite_index = Josh_stop_derecha; break;   // 0 grados (Derecha)
            case 1: sprite_index = Josh_stop_back; break;      // 90 grados (Arriba) 
            case 2: sprite_index = Josh_stop_izquierda; break; // 180 grados (Izquierda)
            case 3: sprite_index = Josh_stop_up; break;        // 270 grados (Abajo)
        }
        
        // Si presiono cualquier tecla de dirección, paso a moverme
        
        if (global.key_dash) {
            estado = PLAYER_STATE.DASH;
            image_index = 0; 
        }
        // Si presiono acción, ataco
        else if (global.key_action) {
            estado = PLAYER_STATE.ATTACK;
            image_index = 0;
        }
        else if (global.key_right || global.key_left || global.key_up || global.key_down) {
            estado = PLAYER_STATE.MOVE;
        }
    break;

    // ==========================================
    case PLAYER_STATE.MOVE: // ESTADO: MOVIÉNDOSE
    // ==========================================
        // 1. Obtener la dirección basada en los inputs (devuelve 1, -1 o 0)
        var _dir_x = global.key_right - global.key_left;
        var _dir_y = global.key_down - global.key_up;
        
        // 2. Comprobar si nos estamos moviendo
        if (_dir_x != 0 || _dir_y != 0) {
            // point_direction calcula el ángulo exacto (ideal para soporte de gamepads luego)
            var _angulo = point_direction(0, 0, _dir_x, _dir_y);
            direccion_mirando = _angulo;
            // lengthdir descompone la velocidad en X y Y (evita que camine más rápido en diagonal)
            // es para cambiar de sprite
            if (_dir_x > 0) { sprite_index = Josh_step_derecha; }
            else if (_dir_x < 0) { sprite_index = Josh_step_izquierda; }
            else if (_dir_y > 0) { sprite_index = Josh_step_up; } 
            else if (_dir_y < 0) { sprite_index = Josh_step_back; }
            
            // Movimiento
            hsp = lengthdir_x(velocidad_base, _angulo);
            vsp = lengthdir_y(velocidad_base, _angulo);
            
        } else {
            // Si solté las teclas, vuelvo a inactivo
            estado = PLAYER_STATE.IDLE;
        }
        
        if (global.key_dash) {
                estado = PLAYER_STATE.DASH;
                image_index = 0; // animación desde el frame 1
            }
        // Si presiono acción mientras camino, ataco
        else if (global.key_action) {
            image_index = 0; 
            estado = PLAYER_STATE.ATTACK;
        }
    break;

    // ==========================================
    case PLAYER_STATE.ATTACK: // ESTADO: ATACANDO
    // ==========================================w
        // Al atacar, nos quedamos quietos
        hsp = 0;
        vsp = 0;
        //if (sprite_index == Josh_stop_derecha || sprite_index == Josh_step_derecha) {
        //    sprite_index = Josh_ataque_derecha; // (Asumiendo que tienes este sprite)
        //} Asi hay que hacerlo
        sprite_index = Josh_attack;
        
        if (image_index >= image_number - 1) {
            estado = PLAYER_STATE.IDLE; // Si ya dio el espadazo, vuelve a inactivo
        }
        
        // (Aquí luego pondrás el código para crear la hitbox de la espada y cambiar el sprite)
        
        // Truco temporal: Para no quedarnos congelados en este estado para siempre,
        // regresamos a IDLE automáticamente. Luego lo cambiaremos para que espere al fin de la animación.

    break;

    // ==========================================
    case PLAYER_STATE.DASH: // ESTADO: RODANDO
    // ==========================================
        
        // 1. Asignar el sprite correcto según el ángulo
        // (Por ahora asumo que solo tienes el sprite de rodar hacia abajo, 
        // luego puedes usar if/else según 'direccion_mirando' para las otras direcciones)
        
        sprite_index = Josh_rueda; 
        // 2. Aplicar movimiento forzado a alta velocidad
        hsp = lengthdir_x(velocidad_roll, direccion_mirando);
        vsp = lengthdir_y(velocidad_roll, direccion_mirando);
        
        // 3. Salir del estado cuando la animación termine
        // image_number es el total de frames, image_index es el frame actual
        if (image_index >= image_number - 1) {
            estado = PLAYER_STATE.IDLE;
        }
    break;
}

// ==========================================
// APLICAR FÍSICA FINAL
// ==========================================
// Después de calcular en qué estado estamos y a qué velocidad queremos ir, 
// llamamos a la función del padre para chocar con las paredes y movernos.
aplicar_movimiento();