/// @description Perseguir al jugador suavemente

// 1. Verificamos que Josh exista en el nivel (para que el juego no crashee si muere)
if (instance_exists(objetivo)) {
    
    var _x_destino = objetivo.x - (ancho_camara / 2);
    var _y_destino = objetivo.y - (alto_camara / 2);
    
    x = lerp(x, _x_destino, suavizado);
    y = lerp(y, _y_destino, suavizado);
    
    x = clamp(x, 0, room_width - ancho_camara);
    y = clamp(y, 0, room_height - alto_camara);
    
    // 5. Aplicar las nuevas coordenadas X e Y a la vista real del juego
    camera_set_view_pos(camara, x, y);
}