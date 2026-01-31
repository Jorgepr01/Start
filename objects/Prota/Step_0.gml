// derecha positivo, izquierda negativo
var _hor = keyboard_check((ord("D")))-keyboard_check(ord("A"))
var _ver = keyboard_check((ord("S")))-keyboard_check(ord("W"))

move_and_collide(_hor*move_speed,_ver*move_speed,tilemap,undefined,undefined,undefined,move_speed,move_speed)