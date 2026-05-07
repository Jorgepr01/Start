/// @description Perseguir al jugador suavemente

// 1. Verificamos que Josh exista en el nivel (para que el juego no crashee si muere)
var _x_destino = x;
var _y_destino = y;

if (estado == "seguir_jugador" && instance_exists(obj_jugador)) {
    // Aquí va tu código actual (Jugador + Mouse)
    var _x_ideal = obj_jugador.x + (mouse_x - obj_jugador.x) * peso_mouse;
    var _y_ideal = obj_jugador.y + (mouse_y - obj_jugador.y) * peso_mouse;
    
    _x_destino = _x_ideal - (ancho_camara / 2);
    _y_destino = _y_ideal - (alto_camara / 2);

} else if (estado == "fija" && instance_exists(objetivo_actual)) {
    // Ignoramos el mouse y nos centramos rígidamente en el 'objetivo_actual'
    // (Que podría ser un obj_zona_camara invisible en el centro de la arena)
    _x_destino = objetivo_actual.x - (ancho_camara / 2);
    _y_destino = objetivo_actual.y - (alto_camara / 2);
}

// El Lerp y el Clamp se aplican SIN IMPORTAR el estado
x = lerp(x, _x_destino, suavizado);
y = lerp(y, _y_destino, suavizado);

x = clamp(x, 0, room_width - ancho_camara);
y = clamp(y, 0, room_height - alto_camara);

// --- SCREEN SHAKE ---
var _shake_x = 0;
var _shake_y = 0;
if (shake_magnitude > 0) {
    _shake_x = random_range(-shake_magnitude, shake_magnitude);
    _shake_y = random_range(-shake_magnitude, shake_magnitude);
    shake_magnitude -= shake_fade;
    if (shake_magnitude < 0) shake_magnitude = 0;
}

// Renderizado nítido con el shake aplicado temporalmente a la vista (no afecta a x/y base)
camera_set_view_pos(camara, round(x + _shake_x), round(y + _shake_y));