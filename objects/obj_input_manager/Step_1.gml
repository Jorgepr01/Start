/// @description Leer controles del jugador

// Movimiento (Soporta flechas y WASD al mismo tiempo)
global.key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
global.key_left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
global.key_up    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
global.key_down  = keyboard_check(vk_down)  || keyboard_check(ord("S"));

// Acciones (Apretado una sola vez por frame)
global.key_action = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter);
global.key_cancel = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("X"));
global.key_pause  = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("P"));

global.key_down_pressed = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
global.key_up_pressed   = keyboard_check_pressed(vk_up)   || keyboard_check_pressed(ord("W"));

// Tecla para rodar (Ejemplo: Shift o la tecla C)
global.key_dash = keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("C"));
// NOTA: Si luego añades un mando, sumarías aquí la lógica con gamepad_button_check()