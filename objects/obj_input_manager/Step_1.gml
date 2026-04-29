/// @description Leer controles del jugador

// Movimiento (Soporta flechas y WASD al mismo tiempo)
global.key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
global.key_left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
global.key_salto_mantenido    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
global.key_salto_presionado = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))
global.salto_soltada = keyboard_check_released(ord("Z"))
global.key_down  = keyboard_check(vk_down)  || keyboard_check(ord("S"));

// Acciones (Apretado una sola vez por frame)
global.key_action = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter);
global.key_cancel = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("X"));
global.key_pause  = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("P"));

global.key_down_pressed = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
global.key_up_pressed   = keyboard_check_pressed(vk_up)   || keyboard_check_pressed(ord("W"));

// Tecla para rodar (Input Buffer)
if (global.buffer_dash > 0) global.buffer_dash--;
if (keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("C"))) global.buffer_dash = 60;
global.key_dash = (global.buffer_dash > 0);
// NOTA: Si luego añades un mando, sumarías aquí la lógica con gamepad_button_check()

// ataques
if (global.buffer_ataque_ligero > 0) global.buffer_ataque_ligero--;
if (global.buffer_ataque_pesado > 0) global.buffer_ataque_pesado--;

if (keyboard_check_pressed(ord("J"))) global.buffer_ataque_ligero = 12;
if (keyboard_check_pressed(ord("K"))) global.buffer_ataque_pesado = 12;

global.key_ataque_ligero = (global.buffer_ataque_ligero > 0);
global.key_ataque_pesado = (global.buffer_ataque_pesado > 0);
global.key_cambiar_arma  = keyboard_check_pressed(ord("Q"));