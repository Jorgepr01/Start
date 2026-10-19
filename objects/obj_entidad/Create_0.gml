/// @description Inicializar física con Tiles

hsp = 0;
vsp = 0;
velocidad_base = 2;
invencible = false;
hit_stop_timer = 0;
velocidad_animacion_guardada = 1;
quiere_bajar = false; // true = atravesar plataformas one-way (el jugador lo controla con abajo)


gravedad = 0.4;       // Fuerza constante hacia abajo
fuerza_salto = 5.8;   // Fuerza inicial negativa hacia arriba
fuerza_segundo_salto = 4.5; // Menor que fuerza_salto (4.8)
vsp_maxima = 8;

// 1. EL ESCÁNER DE TILES
choca_con_tile = function(_x, _y) {
    var _tilemap = layer_tilemap_get_id("Tiles_Colisiones");
    if (_tilemap == -1) return false;
    // Tamaño real del tile del tileset (8px en prueba, 4px en Room1), no TILE_SIZE
    var _tw = tilemap_get_tile_width(_tilemap);
    var _th = tilemap_get_tile_height(_tilemap);
    var _x_real = x;
    var _y_real = y;
    // Movemos teóricamente al personaje a la posición futura
    x = _x;
    y = _y;
    // Revisamos una rejilla de puntos cada tile (no solo las 4 esquinas),
    // para que una máscara más alta/ancha que un tile no atraviese un tile por el medio
    var _colision = false;
    var _yy = bbox_top;
    while (true) {
        var _xx = bbox_left;
        while (true) {
            if (tilemap_get_at_pixel(_tilemap, _xx, _yy)) {
                _colision = true;
                break;
            }
            if (_xx >= bbox_right) break;
            _xx = min(_xx + _tw, bbox_right);
        }
        if (_colision || _yy >= bbox_bottom) break;
        _yy = min(_yy + _th, bbox_bottom);
    }

    // Regresamos al personaje a su posición real
    x = _x_real;
    y = _y_real;
    return _colision;
};

choca_con_entorno = function(_x, _y) {
    var _choca_tile = choca_con_tile(_x, _y);
    var _x_real = x;
    var _y_real = y;
    
    // Guardamos el borde inferior actual para la lógica de plataformas atravesables
    var _actual_bottom = bbox_bottom;
    
    x = _x; y = _y;
    var _choca_rampa = place_meeting(x, y, obj_rampa) || place_meeting(x, y, obj_rampa_invertida);
    
    var _choca_plataforma = false;
    // Solo colisionar si caemos, no queremos bajar y estábamos sobre la plataforma.
    // Revisamos TODAS las plataformas que tocamos (instance_place solo devuelve una)
    if (vsp >= 0 && !quiere_bajar) {
        var _entidad = id;
        with (obj_one_way_platform) {
            if (_actual_bottom <= bbox_top && place_meeting(x, y, _entidad)) {
                _choca_plataforma = true;
                break;
            }
        }
    }
    
    x = _x_real; y = _y_real;
    return (_choca_tile || _choca_rampa || _choca_plataforma);
};




// 2. EL MOTOR DE MOVIMIENTO
aplicar_movimiento = function() {
    var _escalon = 5;
	var _estaba_en_suelo = choca_con_entorno(x, y + 1);
	
    if (choca_con_entorno(x + hsp, y)) {
        var _pudo_subir = false;
        
        for (var i = 1; i <= _escalon; i++) {
            if (!choca_con_entorno(x + hsp, y - i)) {
                y -= i;
                _pudo_subir = true;
                break;
            }
        }

        if (!_pudo_subir) {
            if (hsp != 0) { // Protección anti-cuelgues
                while (!choca_con_entorno(x + sign(hsp), y)) {
                    x += sign(hsp);
                }
            }
            hsp = 0; 
        }
    }
    x += hsp;

    // 2.2 SNAP DOWN (Para bajar rampas/escaleras sin despegarse del suelo)
    if (_estaba_en_suelo && !choca_con_entorno(x, y + 1) && vsp >= 0) {
        for (var i = 1; i <= _escalon; i++) {
            if (choca_con_entorno(x, y + i + 1)) {
                y += i;
                break;
            }
        }
    }

    if (choca_con_entorno(x, y + vsp)) {
        // Nos acercamos píxel por píxel hasta tocar el tile
        while (!choca_con_entorno(x, y + sign(vsp))) {
            y += sign(vsp);
        }
        vsp = 0; 
    }
    y += vsp; 
};

