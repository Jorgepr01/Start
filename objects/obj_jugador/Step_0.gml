/// @description Máquina de Estados y Movimiento

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

// 1. FÍSICA BASE Y ENTORNO
var _en_el_suelo = choca_con_entorno(x, y + 1);

if (_en_el_suelo) saltos_realizados = 0;

if (hp <= 0 && estado != PLAYER_STATE.DEAD) {
    estado = PLAYER_STATE.DEAD;
    sprite_index = spr_Kenji; // Cambia a tu sprite de derrota
    image_index = 0;            // Reinicia la animación desde el principio
    hsp = 0;                    // Frenar en seco (o puedes dejar que ruede un poco)
}


// Aplicar gravedad siempre que no estemos en un estado que la ignore (como el Dash)
if (estado != PLAYER_STATE.DASH) {
    if (!_en_el_suelo) {
        vsp += gravedad;
        if (vsp > vsp_maxima) vsp = vsp_maxima; // Límite de velocidad de caída
    } else {
        // Evitar que la gravedad se acumule mientras estamos parados en el suelo
        if (vsp > 0) vsp = 0; 
    }
}

// Control de altura de salto (Game Feel: Si sueltas el botón, caes más rápido)
if (!global.key_salto_mantenido && vsp < 0) {
    vsp *= 0.5; 
}

// 2. CONTROL DE DAÑO Y ATURDIMIENTO
invencible = false; // Por defecto no somos invencibles
// show_debug_message("vida:" + string(hp));
if (tiempo_aturdido > 0) {
    tiempo_aturdido--;
    hsp = lerp(hsp, 0, 0.1);
    vsp = lerp(vsp, 0, 0.1); // Opcional: podrías dejar que la gravedad actúe aquí también
    aplicar_movimiento();
    exit; // ¡VITAL! Evita que el resto del código se ejecute
}

// --- JUMP BUFFERING ---
if (global.key_salto_presionado) {
    jump_buffer = jump_buffer_max;
}
if (jump_buffer > 0) {
    jump_buffer--;
}

if (coyote_time > 0) {
    coyote_time--;
}

if (dash_cooldown > 0) {
    dash_cooldown--;
}

// --- GESTIÓN DE COMBOS ---
if (combo_timer > 0) {
    combo_timer--;
    if (combo_timer <= 0) {
        combo_step = 0; // Se agota el tiempo, el combo se reinicia
    }
}

switch (estado) {
    
    // ------------------------------------------
    case PLAYER_STATE.IDLE: // ESTADO: INACTIVO
    // ------------------------------------------
        hsp = lerp(hsp, 0, 0.2); // Fricción en el suelo para frenar suavemente
        sprite_index = spr_Kenji; // Usamos un solo sprite base, image_xscale lo voltea
        
        // -- TRANSICIONES --
        if (!_en_el_suelo) {
            estado = PLAYER_STATE.AIR; // Si me caigo de una cornisa
            coyote_time = coyote_time_max;
        }
        else if (jump_buffer > 0) {
            vsp = -fuerza_salto;
            estado = PLAYER_STATE.AIR;
            saltos_realizados = 1;
            jump_buffer = 0;
        }
        else if (global.key_right || global.key_left) {
            estado = PLAYER_STATE.MOVE;
        }
        else if (global.key_dash && dash_cooldown <= 0) {
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
        else {
            intentar_ataque();
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
            sprite_index = spr_Kenji_walk_1; // Sprite base de correr
        } else {
            estado = PLAYER_STATE.IDLE;
        }
        
        // -- TRANSICIONES --
        if (!_en_el_suelo) {
            estado = PLAYER_STATE.AIR;
            coyote_time = coyote_time_max;
        }
        else if (jump_buffer > 0) {
            vsp = -fuerza_salto;
            estado = PLAYER_STATE.AIR;
            saltos_realizados = 1;
            jump_buffer = 0;
        }
        else if (global.key_dash && dash_cooldown <= 0) {
            estado = PLAYER_STATE.DASH;
            image_index = 0;
            global.buffer_dash = 0;
            var _snd_dash = audio_play_sound(sound_dash, 1, false);
            audio_sound_pitch(_snd_dash, random_range(0.9, 1.1));
        }
        else {
            intentar_ataque();
        }
        
    break;

    // ------------------------------------------
    case PLAYER_STATE.AIR: // ESTADO: EN EL AIRE (NUEVO)
    // ------------------------------------------
        var _dir_x = global.key_right - global.key_left;
        
        sprite_index = spr_Kenji;
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
        if (_en_el_suelo && vsp >= 0) {
            if (_dir_x != 0) estado = PLAYER_STATE.MOVE;
            else estado = PLAYER_STATE.IDLE;
        }
        else if (global.key_salto_presionado && (saltos_realizados < max_saltos || coyote_time > 0)) {
            if (coyote_time > 0 && saltos_realizados == 0) {
                vsp = -fuerza_salto;
                saltos_realizados = 1;
                coyote_time = 0;
            } else {
                vsp = (saltos_realizados == 0) ? -fuerza_salto : -fuerza_segundo_salto;
                saltos_realizados++;
                coyote_time = 0;
            }
            jump_buffer = 0;
        }
        else if (global.key_dash && dash_cooldown <= 0) { // Dash aéreo
            estado = PLAYER_STATE.DASH;
            image_index = 0;
            global.buffer_dash = 0;
            var _snd_dash = audio_play_sound(sound_dash, 1, false);
            audio_sound_pitch(_snd_dash, random_range(0.9, 1.1));
        }
        else {
            intentar_ataque();
        }
    break;

    // ------------------------------------------
    case PLAYER_STATE.ATTACK: // ESTADO: ATACANDO
    // ------------------------------------------
        // 1. Obtener los datos del golpe actual según el paso del combo
        var _array_ataques = (tipo_ataque == "ligero") ? arma_equipada.ataques_ligeros : arma_equipada.ataques_pesados;
        
        // Proteccion por si cambiamos de arma y el combo_step es mayor al nuevo array
        if (combo_step >= array_length(_array_ataques)) combo_step = 0;
        
        var _datos = _array_ataques[combo_step];
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
            crear_hitbox_ataque(_datos);
        }

        // Salir del ataque o encadenar el siguiente golpe del combo
        if (image_index >= image_number - 1) {
            if (global.key_dash && dash_cooldown <= 0) {
                estado = PLAYER_STATE.DASH;
                image_index = 0;
                global.buffer_dash = 0;
                combo_step = 0; // Dash rompe el combo
            } else {
                // El combo se pausa, pero damos una ventana de tiempo para continuarlo
                // Si el temporizador es muy bajo, regresamos a IDLE casi de inmediato
                combo_step++;
                if (combo_step >= array_length(_array_ataques)) combo_step = 0;
                
                combo_timer = combo_timer_max;
                
                // Si no hay input de ataque, volvemos a idle/air para que el jugador
                // tenga que ser preciso con el timing del siguiente golpe.
                estado = _en_el_suelo ? PLAYER_STATE.IDLE : PLAYER_STATE.AIR;
            }
        }
    break;

    // ------------------------------------------
    case PLAYER_STATE.DASH: // ESTADO: RODANDO / DASH
    // ------------------------------------------
        invencible = true;
        // Forzamos el movimiento estrictamente horizontal, bloqueando la gravedad
        
        var _dir_dash = (direccion_mirando == 0) ? 1 : -1;
    
        sprite_index = Josh_rueda; 
        image_xscale = _dir_dash;
        hsp = velocidad_roll * _dir_dash;
        // Salir del Dash
        if (image_index >= image_number - 1) {
            dash_cooldown = dash_cooldown_max; // Aplicar cooldown al terminar
            
            if (intentar_ataque()) {
                // Si atacamos, ya se cambió de estado en intentar_ataque()
            } else {
                estado = _en_el_suelo ? PLAYER_STATE.IDLE : PLAYER_STATE.AIR;
                image_index = 0;
            }
        }
    break;

    // ------------------------------------------
    case PLAYER_STATE.AIR_ATTACK: // ESTADO: ATACANDO EN EL AIRE
    // ------------------------------------------
        // 1. Obtener los datos del golpe actual
        var _array_ataques = (tipo_ataque == "ligero") ? arma_equipada.ataques_ligeros : arma_equipada.ataques_pesados;
        
        if (combo_step >= array_length(_array_ataques)) combo_step = 0;
        
        var _datos = _array_ataques[combo_step];
        sprite_index = _datos.sprite;
        
        // 2. GAME FEEL: "Hang Time" (Suspensión en el aire)
        if (image_index < _datos.frame_hit) {
            vsp = 0; // Congelamos la caída mientras prepara el corte
        } else {
            vsp = min(vsp, 2); 
        }
        hsp = lerp(hsp, 0, 0.05); 
        
        // 3. Crear Hitbox (Usando función helper)
        if (image_index >= _datos.frame_hit && !hitbox_creada) {
            crear_hitbox_ataque(_datos);
        }

        // 4. Salir del ataque aéreo o encadenar combo
        if (image_index >= image_number - 1) {
            combo_step++;
            if (combo_step >= array_length(_array_ataques)) combo_step = 0;
            
            combo_timer = combo_timer_max;
            estado = PLAYER_STATE.AIR;
        }

        // Si tocamos el suelo durante el ataque aéreo
        if (_en_el_suelo) {
            var _dir_x = global.key_right - global.key_left;
            estado = (_dir_x != 0) ? PLAYER_STATE.MOVE : PLAYER_STATE.IDLE;
            image_index = 0; 
            
            // No reiniciamos el combo al aterrizar. 
            // Si ya se creó la hitbox, avanzamos al siguiente paso.
            if (hitbox_creada) {
                combo_step++;
                if (combo_step >= array_length(_array_ataques)) combo_step = 0;
            }
            
            combo_timer = combo_timer_max; // Damos margen para seguir el combo en tierra
        }
    break;
    case PLAYER_STATE.DEAD: // ESTADO: MUERTO
        
        if (_en_el_suelo) {
            hsp = lerp(hsp, 0, 0.1); 
        }

        // Comprobar si la animación de muerte ya llegó a su último frame
        if (image_index + (sprite_get_speed(sprite_index) / game_get_speed(gamespeed_fps)) >= image_number) {
            image_speed = 0; 
            image_index = image_number - 1;
            
            // Activar una alarma para el Game Over
            if (alarm[0] == -1) {
                alarm[0] = game_get_speed(gamespeed_fps) * 2; // Espera 2 segundos antes de reiniciar
            }
        }
    break;
}
show_debug_message(estado)
// 4. APLICAR FÍSICA FINAL
aplicar_movimiento();
