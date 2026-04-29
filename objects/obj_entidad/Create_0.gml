/// @description Inicializar física con Tiles

hsp = 0;
vsp = 0;
velocidad_base = 2;


gravedad = 0.4;       // Fuerza constante hacia abajo
fuerza_salto = 4.8 ;   // Fuerza inicial negativa hacia arriba
vsp_maxima = 8;

// 1. EL ESCÁNER DE TILES
choca_con_tile = function(_x, _y) {
    var _tilemap = layer_tilemap_get_id("Tiles_Colisiones");
    if (_tilemap == -1) return false; 
    var _x_real = x;
    var _y_real = y;
    // Movemos teóricamente al personaje a la posición futura
    x = _x;
    y = _y;
    var _colision = tilemap_get_at_pixel(_tilemap, bbox_left, bbox_top) ||
                    tilemap_get_at_pixel(_tilemap, bbox_right, bbox_top) ||
                    tilemap_get_at_pixel(_tilemap, bbox_left, bbox_bottom) ||
                    tilemap_get_at_pixel(_tilemap, bbox_right, bbox_bottom);

    // Regresamos al personaje a su posición real
    x = _x_real;
    y = _y_real;
    return _colision;
};

// 2. EL MOTOR DE MOVIMIENTO
aplicar_movimiento = function() {
    
    if (choca_con_tile(x + hsp, y)) {
        // Nos acercamos píxel por píxel hasta tocar el tile
        while (!choca_con_tile(x + sign(hsp), y)) {
            x += sign(hsp);
        }
        hsp = 0; 
    }
    x += hsp; 

    if (choca_con_tile(x, y + vsp)) {
        // Nos acercamos píxel por píxel hasta tocar el tile
        while (!choca_con_tile(x, y + sign(vsp))) {
            y += sign(vsp);
        }
        vsp = 0; 
    }
    y += vsp; 
};