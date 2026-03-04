/// @description Máquina de Estados y Movimiento



switch (estado) {
    
    // ==========================================
    case PLAYER_STATE.IDLE: // ESTADO: INACTIVO
    // ==========================================
        hsp = 0;
        vsp = 0;
        var _dir_cuadrante = round(direccion_mirando / 90) mod 4;
        switch (_dir_cuadrante) {
            case 0: sprite_index = Josh_stop_derecha; break;   // 0 grados
            case 1: sprite_index = Josh_stop_back; break;      // 90 grados 
            case 2: sprite_index = Josh_stop_izquierda; break; // 180 grados
            case 3: sprite_index = Josh_stop_up; break;        // 270 grados
        
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
            hitbox_creada = false;
        }
        else if (global.key_right || global.key_left || global.key_up || global.key_down) {
            estado = PLAYER_STATE.MOVE;
        }
    break;

    // ==========================================
    case PLAYER_STATE.MOVE: // ESTADO: MOVIÉNDOSE
    // ==========================================
        var _dir_x = global.key_right - global.key_left;
        var _dir_y = global.key_down - global.key_up;
        
        // Comprobar si nos estamos moviendo
        if (_dir_x != 0 || _dir_y != 0) {
            var _angulo = point_direction(0, 0, _dir_x, _dir_y);
            direccion_mirando = _angulo;
            // lengthdir descompone la velocidad en X y Y (evita que camine más rápido en diagonal)
            // aqui para cambiar de sprite
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
        // Cambios de estados
        if (global.key_dash) {
                estado = PLAYER_STATE.DASH;
                image_index = 0;
                
            }
        else if (global.key_action) {
            image_index = 0; 
            estado = PLAYER_STATE.ATTACK;
            hitbox_creada = false;
        }
    break;

    // ==========================================
    case PLAYER_STATE.ATTACK: // ESTADO: ATACANDO
    // ==========================================
        
        //Impulso dinámico (Lee el impulso del arma equipada)
        if (image_index < image_number / 2) {
            hsp = lengthdir_x(arma_equipada.attack_speed, direccion_mirando);
            vsp = lengthdir_y(arma_equipada.attack_speed, direccion_mirando);
        } else {
            hsp = 0;
            vsp = 0;
        }
        
        // En un futuro hacerr un array y con var _dir_cuadrante = round(direccion_mirando / 90) mod 4; ver a cual sprite moverte
        sprite_index = arma_equipada.sprite;
        
        // la Hitbox
        if (floor(image_index) == 8 && !hitbox_creada) {
            var _distancia = 16;
            var _xx = x + lengthdir_x(_distancia, direccion_mirando);
            var _yy = y + lengthdir_y(_distancia, direccion_mirando);
            var _hitbox = instance_create_layer(_xx, _yy, "Instances", obj_hitbox);
            
            _hitbox.dano = arma_equipada.dano; //datos del arma
            _hitbox.image_angle = direccion_mirando;
            hitbox_creada = true;
        }
        
        if (image_index >= image_number - 1) {
            estado = PLAYER_STATE.IDLE; 
        }
    break;

    // ==========================================
    case PLAYER_STATE.DASH: // ESTADO: RODANDO
    // ==========================================
         
        //usar if/else según 'direccion_mirando' para las otras direcciones
        sprite_index = Josh_rueda; 
        // Aplicar movimiento forzado a alta velocidad
        hsp = lengthdir_x(velocidad_roll, direccion_mirando);
        vsp = lengthdir_y(velocidad_roll, direccion_mirando);
        
        // 3. Salir del estado cuando la animación termine
        if (image_index >= image_number - 1) {
            estado = PLAYER_STATE.IDLE;
        }
    break;
}

// APLICAR FÍSICA FINAL
aplicar_movimiento();