// derecha positivo, izquierda negativo

var _hor = global.key_right-global.key_left
var _ver = global.key_down-global.key_up


if (_hor == 0 && _ver == 0) 
    {
        //sprite_index = Josh
        if (sprite_index==Josh_step_derecha){sprite_index=Josh_stop_derecha}
        if (sprite_index==Josh_step_izquierda){sprite_index=Josh_stop_izquierda}
        if (sprite_index==Josh_step_up){sprite_index=Josh_stop_up}
        if (sprite_index==Josh_step_back){sprite_index=Josh_stop_back}
    } else {
    if _hor > 0 { sprite_index = Josh_step_derecha }
    if _hor < 0 { sprite_index = Josh_step_izquierda }
    if _ver > 0 { sprite_index = Josh_step_up }
    if _ver < 0 { sprite_index = Josh_step_back }
	}
move_and_collide(_hor*move_speed,_ver*move_speed,tilemap,undefined,undefined,undefined,move_speed,move_speed)

