/// @description Inicializar física con Tiles

hsp = 0;
vsp = 0;
velocidad_base = 2;

// 1. EL ESCÁNER DE TILES
// Esta función simula un place_meeting pero leyendo la cuadrícula del mapa
choca_con_tile = function(_x, _y) {
    // Buscamos la capa exacta donde tu amigo pintará las colisiones
    var _tilemap = layer_tilemap_get_id("Tiles_Colisiones");
    
    // Si la capa no existe en este nivel, no hay colisión
    if (_tilemap == -1) return false; 

    // Guardamos la posición actual para no mover al personaje por accidente
    var _x_real = x;
    var _y_real = y;

    // Movemos teóricamente al personaje a la posición futura
    x = _x;
    y = _y;

    // Revisamos si alguna de las 4 esquinas del personaje toca un tile sólido
    // tilemap_get_at_pixel devuelve > 0 si hay un tile dibujado ahí
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
// Es exactamente igual que antes, pero usando nuestro nuevo escáner
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