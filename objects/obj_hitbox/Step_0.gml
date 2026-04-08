var _lista_enemigos = ds_list_create();

// Ponemos 'false' porque nosotros haremos el ordenamiento
var _cantidad_tocando = instance_place_list(x, y, obj_enemigo_dummy, _lista_enemigos, false);

if (_cantidad_tocando > 0) {
    // 1. Pasar los datos de la lista a un Arreglo (Array) para manipularlos mejor
    var _enemigos_candidatos = [];
    for (var i = 0; i < _cantidad_tocando; i++) {
        array_push(_enemigos_candidatos, _lista_enemigos[| i]);
    }
    
    // 2. MAGIA: Ordenar el arreglo por distancia al CREADOR (el Jugador)
    var _origen_x = creador.x;
    var _origen_y = creador.y;
    
    array_sort(_enemigos_candidatos, function(_inst_a, _inst_b) {
        
        // Usamos _origen_x y _origen_y para evitar cualquier error de lectura
        var _dist_a = point_distance(_origen_x, _origen_y, _inst_a.x, _inst_a.y);
        var _dist_b = point_distance(_origen_x, _origen_y, _inst_b.x, _inst_b.y);
        
        return _dist_a - _dist_b; // Ordena de menor a mayor distancia
    });
    
    // 3. Procesar los golpes usando el arreglo ya ordenado
    for (var i = 0; i < array_length(_enemigos_candidatos); i++) {
        if (array_length(enemigos_golpeados) >= max_objetivos) break;
        
        var _enemigo_actual = _enemigos_candidatos[i];
        
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
}

ds_list_destroy(_lista_enemigos);