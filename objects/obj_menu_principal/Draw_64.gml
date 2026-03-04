/// @description Dibujar el menú en pantalla

// Configurar la fuente y la alineación
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Calcular el centro de la pantalla
var centro_x = display_get_gui_width() / 2;
var centro_y = display_get_gui_height() / 2;
var espaciado = 40; // Espacio entre cada botón

// Título del juego (opcional)
draw_set_font(Menu);
draw_set_color(c_yellow);
draw_text(centro_x, centro_y - 80, "Menu");

// Bucle para dibujar las opciones
for (var i = 0; i < array_length(opciones); i++) {
    
    // Si la opción actual (i) es la que está seleccionada, cambia de color
    if (i == menu_index) {
        draw_set_font(Menu_negrita);
        draw_set_color(c_white);
        // Podemos añadirle un prefijo visual como una flechita
        draw_text(centro_x, centro_y + (i * espaciado), "> " + opciones[i] + " <");
        draw_set_font(Menu);
    } else {
        draw_set_color(c_gray);
        draw_text(centro_x, centro_y + (i * espaciado), opciones[i]);
    }
}