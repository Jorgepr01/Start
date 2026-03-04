hp -= other.dano; // bajar la vida

// Sale volando en la dirección del golpe
hsp = lengthdir_x(other.fuerza_empuje, other.direccion_golpe);
vsp = lengthdir_y(other.fuerza_empuje, other.direccion_golpe);

show_debug_message("HP: " + string(hp));