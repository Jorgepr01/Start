/// @description HUD: barra de vida

var _ancho = 120;
var _alto = 10;
var _x = 16;
var _y = 16;

draw_healthbar(_x, _y, _x + _ancho, _y + _alto, (max(hp, 0) / hp_max) * 100, c_black, c_red, c_lime, 0, true, true);
