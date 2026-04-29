/// @description Navegar por el menú
// Mover el cursor hacia abajo
if (global.key_down_pressed) {
    if (menu_index >= array_length(opciones) - 1) {
        menu_index = 0;
    } else {
        menu_index += 1;
    }
}

// Mover el cursor hacia arriba
if (global.key_up_pressed) { // <-- CAMBIO AQUÍ
    if (menu_index <= 0) {
        menu_index = array_length(opciones) - 1;
    } else {
        menu_index -= 1;
    }
}

// Seleccionar una opción
if (global.key_action) {
    switch (menu_index) {
        case 0: // Jugar
            
            if(room==Inicio){
                room_goto(prueba);
            }else{
                instance_activate_all();
                instance_destroy();
            }
            
            break;
        case 1:
            show_debug_message("Abriendo menú de opciones...");
            show_message("Por programar opcciones :) \n Samuel tranqui estamos trabajando en eso")
            break;
        case 2:
            game_end();
            break;
    }
}