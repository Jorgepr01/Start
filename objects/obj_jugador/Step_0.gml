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
            var _snd_dash = audio_play_sound(sound_dash, 1, false);
            // Opcional: Le variamos el pitch para que cada voltereta suene ligeramente distinta
            audio_sound_pitch(_snd_dash, random_range(0.9, 1.1));
        }
        // Si presiono acción, ataco
        // --- CAMBIO DE ARMA ---
        else if (global.key_cambiar_arma) {
            indice_arma = (indice_arma + 1) mod array_length(inventario_armas);
            arma_equipada = inventario_armas[indice_arma];
            show_debug_message("Arma actual: " + arma_equipada.name);
        }
        // --- ATAQUES ---
        else if (global.key_ataque_ligero) {
            estado = PLAYER_STATE.ATTACK;
            image_index = 0;
            hitbox_creada = false;
            tipo_ataque = "ligero";
        } 
        else if (global.key_ataque_pesado) {
            estado = PLAYER_STATE.ATTACK;
            image_index = 0;
            hitbox_creada = false;
            tipo_ataque = "pesado";
        }
        else if (global.key_action) {
            image_index = 0; 
            estado = PLAYER_STATE.ATTACK;
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
                var _snd_dash = audio_play_sound(sound_dash, 1, false);
                // Opcional: Le variamos el pitch para que cada voltereta suene ligeramente distinta
                audio_sound_pitch(_snd_dash, random_range(0.9, 1.1));
                    
            }
        // --- CAMBIO DE ARMA ---
        else if (global.key_cambiar_arma) {
            indice_arma = (indice_arma + 1) mod array_length(inventario_armas);
            arma_equipada = inventario_armas[indice_arma];
            show_debug_message("Arma actual: " + arma_equipada.name);
        }
        // --- ATAQUES ---
        else if (global.key_ataque_ligero) {
            estado = PLAYER_STATE.ATTACK;
            image_index = 0;
            hitbox_creada = false;
            tipo_ataque = "ligero";
        } 
        else if (global.key_ataque_pesado) {
            estado = PLAYER_STATE.ATTACK;
            image_index = 0;
            hitbox_creada = false;
            tipo_ataque = "pesado";
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
        
        // 1. Cargar datos según el botón presionado
        var _datos;
        if (tipo_ataque == "ligero") { _datos = arma_equipada.ataque_ligero; } 
        else { _datos = arma_equipada.ataque_pesado; }
        
        // 2. Aplicar Sprite e Impulso
        sprite_index = _datos.sprite;

        if (image_index < image_number / 2) {
            hsp = lengthdir_x(_datos.attack_speed, direccion_mirando);
            vsp = lengthdir_y(_datos.attack_speed, direccion_mirando);
        } else {
            hsp = 0; vsp = 0;
        }

        // 3. Crear Hitbox Dinámica
        if (floor(image_index) == _datos.frame_hit && !hitbox_creada) {
            //var _sonido = audio_play_sound(sound_attack, 1, false); encuentra uno mejor
            // Le cambiamos el tono (pitch) al azar entre un 80% y un 120% de su velocidad original
            //audio_sound_pitch(_sonido, random_range(0.8, 1));
            var _xx = x + lengthdir_x(16, direccion_mirando);
            var _yy = y + lengthdir_y(16, direccion_mirando);
            var _hitbox = instance_create_layer(_xx, _yy, "Instances", obj_hitbox);
            
            _hitbox.dano = _datos.dano;
            _hitbox.image_angle = direccion_mirando;
            
            _hitbox.fuerza_empuje = _datos.empuje;
            _hitbox.direccion_golpe = direccion_mirando;
            
            hitbox_creada = true;
        }

        // 4. Salir
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