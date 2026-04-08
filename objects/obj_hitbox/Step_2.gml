// 1. Crear la lista y detectar colisiones ORDENADAS por distancia al origen de la hitbox
var _lista_enemigos = ds_list_create();
var _cantidad_tocando = instance_place_list(x, y, obj_enemigo_dummy, _lista_enemigos, true); // true = ORDENAR POR DISTANCIA

if (_cantidad_tocando > 0) {
    
    // --- LÓGICA DE CICLO DE OBJETIVOS (SPREAD) ---
    var _objetivos_finales = [];
    var _objetivos_aturdidos = [];
    
    for (var i = 0; i < _cantidad_tocando; i++) {
        var _inst = _lista_enemigos[| i];
        if (_inst.tiempo_aturdido > 0) {
            array_push(_objetivos_aturdidos, _inst);
        } else {
            array_push(_objetivos_finales, _inst);
        }
    }
    
    for (var i = 0; i < array_length(_objetivos_aturdidos); i++) {
        array_push(_objetivos_finales, _objetivos_aturdidos[i]);
    }

    // 2. Procesar los golpes
    for (var i = 0; i < array_length(_objetivos_finales); i++) {
        
        if (array_length(enemigos_golpeados) >= max_objetivos) break;
        
        var _enemigo_actual = _objetivos_finales[i];
        
        var _ya_golpeado = false;
        for (var j = 0; j < array_length(enemigos_golpeados); j++) {
            if (enemigos_golpeados[j] == _enemigo_actual.id) {
                _ya_golpeado = true;
                break;
            }
        }
        
        if (!_ya_golpeado) {
            array_push(enemigos_golpeados, _enemigo_actual.id);
            
            with (_enemigo_actual) {
                hp -= other.dano;
                tiempo_flash = 5;
                tiempo_aturdido = other.tiempo_aturdido;
                
                hsp = lengthdir_x(other.fuerza_empuje, other.direccion_golpe);
                vsp = lengthdir_y(other.fuerza_empuje, other.direccion_golpe);
                
                var _sonido = audio_play_sound(sound_dano, 1, false);
                if (_sonido != -1) audio_sound_pitch(_sonido, random_range(0.8, 1.2));
                show_debug_message("Golpeado: " + string(id) + " (Sano: " + string(tiempo_aturdido == other.tiempo_aturdido) + ")");
            }
        }
    }
}

ds_list_destroy(_lista_enemigos);

// 3. AUTO-DESTRUCCIÓN (Al final de todo)
instance_destroy();
