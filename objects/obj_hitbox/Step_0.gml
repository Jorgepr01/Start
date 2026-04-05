// 1. Creamos una lista temporal para guardar a todos los enemigos que estamos tocando
var _lista_enemigos = ds_list_create();

// El 'true' al final es la magia: ordena a los enemigos del más cercano al más lejano
var _cantidad_tocando = instance_place_list(x, y, obj_enemigo_dummy, _lista_enemigos, true);

// 2. Iteramos sobre los enemigos que tocamos
for (var i = 0; i < _cantidad_tocando; i++) {
    
    // Si ya llegamos al límite de objetivos del arma, rompemos el ciclo
    if (array_length(enemigos_golpeados) >= max_objetivos) break;
    
    var _enemigo_actual = _lista_enemigos[| i];
    
    // 3. Revisamos si ya lo habíamos golpeado antes (por si el hitbox vive varios frames)
    var _ya_golpeado = false;
    for (var j = 0; j < array_length(enemigos_golpeados); j++) {
        if (enemigos_golpeados[j] == _enemigo_actual.id) {
            _ya_golpeado = true;
            break;
        }
    }
    
    // 4. Si es un objetivo válido y nuevo, le aplicamos la lógica
    if (!_ya_golpeado) {
        
        array_push(enemigos_golpeados, _enemigo_actual.id);
        
        // El bloque 'with' nos teletransporta al código del enemigo
        // Aquí la palabra "other" funciona perfecto apuntando a la hitbox
        with (_enemigo_actual) {
            
            // --- TU LÓGICA DE REACCIÓN EXACTA ---
            hp -= other.dano;
            tiempo_flash = 5;
            tiempo_aturdido = other.aturdimiento;
            
            hsp = lengthdir_x(other.fuerza_empuje, other.direccion_golpe);
            vsp = lengthdir_y(other.fuerza_empuje, other.direccion_golpe);
            
            var _sonido = audio_play_sound(sound_dano, 1, false);
            audio_sound_pitch(_sonido, random_range(0.8, 1.2));
            show_debug_message("HP: " + string(hp));
        }
    }
}

// 5. ¡SÚPER IMPORTANTE! Destruir la lista para evitar memory leaks (fugas de memoria)
ds_list_destroy(_lista_enemigos);