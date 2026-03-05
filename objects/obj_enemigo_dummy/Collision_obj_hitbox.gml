tiempo_flash = 6;
hp -= other.dano; // bajar la vida

// Sale volando en la dirección del golpe
hsp = lengthdir_x(other.fuerza_empuje, other.direccion_golpe);
vsp = lengthdir_y(other.fuerza_empuje, other.direccion_golpe);

var _sonido = audio_play_sound(sound_dano, 1, false);
// Le cambiamos el tono (pitch) al azar entre un 80% y un 120% de su velocidad original
audio_sound_pitch(_sonido, random_range(0.8, 1.2));
show_debug_message("HP: " + string(hp));