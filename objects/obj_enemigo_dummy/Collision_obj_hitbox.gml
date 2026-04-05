var _ya_golpeado = false;
var _hitbox = other; // "other" es el obj_hitbox en este evento

// Revisar si la ID de este enemigo ya está en la lista de la hitbox
for (var i = 0; i < array_length(_hitbox.enemigos_golpeados); i++) {
    if (_hitbox.enemigos_golpeados[i] == id) {
        _ya_golpeado = true;
        break;
    }
}

// Si no me ha golpeado y la hitbox aún puede golpear más objetivos...
if (!_ya_golpeado && array_length(_hitbox.enemigos_golpeados) < _hitbox.max_objetivos) {
    
    // 1. Añadimos a este enemigo a la lista de la hitbox
    array_push(_hitbox.enemigos_golpeados, id);
    
    // 2. Ejecutar toda tu lógica de reacción (Game Feel, Daño, Hit Stun)
    hp -= _hitbox.dano;
    tiempo_flash = 5;
    tiempo_aturdido = _hitbox.tiempo_aturdido;
    
    // Calcular Knockback con lengthdir
    var _dir = point_direction(_hitbox.x, _hitbox.y, x, y);
    hsp = lengthdir_x(other.fuerza_empuje, other.direccion_golpe);
    vsp = lengthdir_y(other.fuerza_empuje, other.direccion_golpe);
    
    
    audio_play_sound(sound_dano, 1, false, 2.5, 0, random_range(0.9, 1.1));
    show_debug_message("HP: " + string(hp));
}




