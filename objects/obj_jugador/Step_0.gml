/// @description Máquina de Estados y Movimiento
// 1. FÍSICA BASE Y ENTORNO
var _en_el_suelo = choca_con_tile(x, y + 1);

// Aplicar gravedad siempre que no estemos en un estado que la ignore (como el Dash)
if (estado != PLAYER_STATE.DASH) {
    vsp += gravedad;
    if (vsp > vsp_maxima) vsp = vsp_maxima; // Límite de velocidad de caída
}

// Control de altura de salto (Game Feel: Si sueltas el botón, caes más rápido)
if (!global.key_salto_mantenido && vsp < 0) {
    vsp *= 0.4; 
}

// 2. CONTROL DE DAÑO Y ATURDIMIENTO
// show_debug_message("vida:" + string(hp));
if (tiempo_aturdido > 0) {
    tiempo_aturdido--;
    hsp = lerp(hsp, 0, 0.1);
    vsp = lerp(vsp, 0, 0.1); // Opcional: podrías dejar que la gravedad actúe aquí también
    aplicar_movimiento();
    exit; // ¡VITAL! Evita que el resto del código se ejecute
}

// ==========================================
// 3. MÁQUINA DE ESTADOS
// ==========================================
switch (estado) {
    
    // ------------------------------------------
    case PLAYER_STATE.IDLE: // ESTADO: INACTIVO
    // ------------------------------------------
        hsp = lerp(hsp, 0, 0.2); // Fricción en el suelo para frenar suavemente
        sprite_index = Josh_stop_derecha; // Usamos un solo sprite base, image_xscale lo voltea
        
        // -- TRANSICIONES --
        if (!_en_el_suelo) {
            estado = PLAYER_STATE.AIR; // Si me caigo de una cornisa
        }
        else if (global.key_salto_presionado) {
            vsp = -fuerza_salto;
            estado = PLAYER_STATE.AIR;
        }
        else if (global.key_right || global.key_left) {
            estado = PLAYER_STATE.MOVE;
        }
        else if (global.key_dash) {
            estado = PLAYER_STATE.DASH;
            image_index = 0; 
            global.buffer_dash = 0; 
            var _snd_dash = audio_play_sound(sound_dash, 1, false);
            audio_sound_pitch(_snd_dash, random_range(0.9, 1.1));
        }
        else if (global.key_cambiar_arma) {
            indice_arma = (indice_arma + 1) mod array_length(inventario_armas);
            arma_equipada = inventario_armas[indice_arma];
        }
        else if (global.key_ataque_ligero || global.key_ataque_pesado || global.key_action) {
            estado = PLAYER_STATE.ATTACK;
            image_index = 0;
            hitbox_creada = false;
            tipo_ataque = global.key_ataque_ligero ? "ligero" : "pesado";
        }
    break;

    // ------------------------------------------
    case PLAYER_STATE.MOVE: // ESTADO: MOVIÉNDOSE
    // ------------------------------------------
        var _dir_x = global.key_right - global.key_left;
        
        if (_dir_x != 0) {
            hsp = _dir_x * velocidad_base;
            image_xscale = _dir_x; // Voltea el sprite visualmente
            direccion_mirando = (image_xscale == 1) ? 0 : 180; // 0 derecha, 180 izquierda
            sprite_index = Josh_step_derecha; // Sprite base de correr
        } else {
            estado = PLAYER_STATE.IDLE;
        }
        
        // -- TRANSICIONES --
        if (!_en_el_suelo) {
            estado = PLAYER_STATE.AIR;
        }
        else if (global.key_salto_presionado) {
            vsp = -fuerza_salto;
            estado = PLAYER_STATE.AIR;
        }
        else if (global.key_dash) {
            estado = PLAYER_STATE.DASH;
            image_index = 0;
            global.buffer_dash = 0;
            var _snd_dash = audio_play_sound(sound_dash, 1, false);
            audio_sound_pitch(_snd_dash, random_range(0.9, 1.1));
        }
        else if (global.key_ataque_ligero || global.key_ataque_pesado || global.key_action) {
            estado = PLAYER_STATE.ATTACK;
            image_index = 0;
            hitbox_creada = false;
            tipo_ataque = global.key_ataque_ligero ? "ligero" : "pesado";
        }
    break;

    // ------------------------------------------
    case PLAYER_STATE.AIR: // ESTADO: EN EL AIRE (NUEVO)
    // ------------------------------------------
        var _dir_x = global.key_right - global.key_left;
        
        // Movilidad aérea (Air Control)
        if (_dir_x != 0) {
            hsp = _dir_x * velocidad_base;
            image_xscale = _dir_x; 
            direccion_mirando = (image_xscale == 1) ? 0 : 180;
        } else {
            hsp = lerp(hsp, 0, 0.05); // Menos fricción en el aire
        }
        // Animación dinámica de salto
        if (vsp < 0) {
            // sprite_index = Josh_jump_up; // Descomenta cuando tengas el sprite
        } else {
            // sprite_index = Josh_jump_fall; // Descomenta cuando tengas el sprite
        }
        // -- TRANSICIONES --
        if (_en_el_suelo) {
            if (_dir_x != 0) estado = PLAYER_STATE.MOVE;
            else estado = PLAYER_STATE.IDLE;
        }
        else if (global.key_dash) { // Dash aéreo
            estado = PLAYER_STATE.DASH;
            image_index = 0;
            global.buffer_dash = 0;
            var _snd_dash = audio_play_sound(sound_dash, 1, false);
            audio_sound_pitch(_snd_dash, random_range(0.9, 1.1));
        }
        else if (global.key_ataque_ligero || global.key_ataque_pesado || global.key_action) {
            estado = PLAYER_STATE.AIR_ATTACK;
            image_index = 0;
            hitbox_creada = false;
            // Puedes usar el mismo tipo de ataque o crear uno específico en tu inventario
            tipo_ataque = global.key_ataque_ligero ? "ligero" : "pesado"; 
        }
    break;

    // ------------------------------------------
    case PLAYER_STATE.ATTACK: // ESTADO: ATACANDO
    // ------------------------------------------
        var _datos = (tipo_ataque == "ligero") ? arma_equipada.ataque_ligero : arma_equipada.ataque_pesado;
        sprite_index = _datos.sprite;
        // Impulso hacia adelante usando 2D (no lengthdir)
        if (image_index < image_number / 2) {
            var _direccion_impulso = (direccion_mirando == 0) ? 1 : -1; 
            hsp = _datos.attack_speed * _direccion_impulso;
        } else {
            hsp = lerp(hsp, 0, 0.2); // Frena suavemente al terminar el tajo
        }

        // Crear Hitbox Dinámica
        if (image_index >= _datos.frame_hit && !hitbox_creada) {
            var _xx = x + ((direccion_mirando == 0) ? 10 : -10); // Desplaza la hitbox un poco hacia adelante
            var _hitbox = instance_create_layer(_xx, y, "Instances", obj_hitbox);
            _hitbox.creador = id;
            _hitbox.dano = _datos.dano;
            _hitbox.image_angle = direccion_mirando;
            _hitbox.objetivo_colision = obj_enemigo_dummy;
            _hitbox.fuerza_empuje = _datos.empuje;
            _hitbox.direccion_golpe = direccion_mirando;
            _hitbox.max_objetivos = _datos.max_objetivos;
            _hitbox.tiempo_aturdido = _datos.tiempo_aturdido;
            _hitbox.enemigos_golpeados = [];
            hitbox_creada = true;
        }

        // Salir del ataque
        if (image_index >= image_number - 1) {
            if (global.key_dash) {
                estado = PLAYER_STATE.DASH;
                image_index = 0;
                global.buffer_dash = 0;
            } else if (global.key_ataque_ligero) {
                image_index = 0; hitbox_creada = false; tipo_ataque = "ligero";
            } else if (global.key_ataque_pesado) {
                image_index = 0; hitbox_creada = false; tipo_ataque = "pesado";
            } else {
                estado = _en_el_suelo ? PLAYER_STATE.IDLE : PLAYER_STATE.AIR;
            }
        }
    break;

    // ------------------------------------------
    case PLAYER_STATE.DASH: // ESTADO: RODANDO / DASH
    // ------------------------------------------
        sprite_index = Josh_rueda; 
        // Forzamos el movimiento estrictamente horizontal, bloqueando la gravedad
        vsp = 0; 
        var _dir_dash = (direccion_mirando == 0) ? 1 : -1;
        hsp = velocidad_roll * _dir_dash;
        // Salir del Dash
        if (image_index >= image_number - 1) {
            if (global.key_ataque_ligero) {
                estado = PLAYER_STATE.ATTACK; image_index = 0; hitbox_creada = false; tipo_ataque = "ligero";
            } else if (global.key_ataque_pesado) {
                estado = PLAYER_STATE.ATTACK; image_index = 0; hitbox_creada = false; tipo_ataque = "pesado";
            } else if (global.key_dash) {
                estado = PLAYER_STATE.DASH; image_index = 0; global.buffer_dash = 0;
            } else {
                estado = _en_el_suelo ? PLAYER_STATE.IDLE : PLAYER_STATE.AIR;
            }
        }
    break;

    // ------------------------------------------
    case PLAYER_STATE.AIR_ATTACK: // ESTADO: ATACANDO EN EL AIRE
    // ------------------------------------------
        var _datos = (tipo_ataque == "ligero") ? arma_equipada.ataque_ligero : arma_equipada.ataque_pesado;
        // IDEAL: Usar un sprite diferente para el ataque aéreo
        sprite_index = _datos.sprite; // O un sprite específico como Josh_ataque_aire
        // 1. GAME FEEL: "Hang Time" (Suspensión en el aire)
        // Como la gravedad se suma al inicio del Step, aquí la contrarrestamos.
        if (image_index < _datos.frame_hit) {
            vsp = 0; // Congelamos la caída mientras prepara el corte
        } else {
            // Permitimos que empiece a caer suavemente de nuevo
            vsp = min(vsp, 2); 
        }
        // Conservamos un poco de inercia horizontal (sin frenarlo en seco como en la tierra)
        hsp = lerp(hsp, 0, 0.05); 
        // 2. Crear Hitbox (Exactamente igual que en tierra)
        if (image_index >= _datos.frame_hit && !hitbox_creada) {
            var _xx = x + ((direccion_mirando == 0) ? 10 : -10);
            var _hitbox = instance_create_layer(_xx, y, "Instances", obj_hitbox);
            
            _hitbox.creador = id;
            _hitbox.dano = _datos.dano;
            _hitbox.image_angle = direccion_mirando;
            _hitbox.objetivo_colision = obj_enemigo_dummy;
            _hitbox.fuerza_empuje = _datos.empuje;
            _hitbox.direccion_golpe = direccion_mirando;
            _hitbox.max_objetivos = _datos.max_objetivos;
            _hitbox.tiempo_aturdido = _datos.tiempo_aturdido;
            _hitbox.enemigos_golpeados = [];
            hitbox_creada = true;
        }

        // 3. Salir del ataque aéreo
        if (image_index >= image_number - 1) {
            estado = PLAYER_STATE.AIR;
        }
        

        if (_en_el_suelo) {
            // Se cancela el ataque aéreo y vuelve a estado normal (o puedes mandarlo a un estado de recuperación)
            estado = PLAYER_STATE.IDLE;
        }
    break;
}

// ==========================================
// 4. APLICAR FÍSICA FINAL
// ==========================================
aplicar_movimiento();