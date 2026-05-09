/// @description Configurar Jugador
mask_index = spr_Kenji;
// IMPORTANTE: Heredar las variables y funciones del padre
event_inherited(); 
hp = 100; 
tiempo_flash = 0;
tiempo_aturdido = 0;
velocidad_base = 1.5; 
estado = PLAYER_STATE.IDLE;

// Salto y Movimiento
max_saltos = 2;
saltos_realizados = 0;
coyote_time = 0;
coyote_time_max = 5;
jump_buffer = 0;
jump_buffer_max = 5;

velocidad_roll = 2;
dash_cooldown = 0;
dash_cooldown_max = 15;
direccion_mirando = 0;

// SISTEMA DE ARMAS Y COMBATE 
inventario_armas = [global.weapons.Katana, global.weapons.Shuriken];
indice_arma = 0;
arma_equipada = inventario_armas[indice_arma];

tipo_ataque = "ligero";
hitbox_creada = false;

// --- SISTEMA DE COMBOS ---
combo_step = 0;           // Índice del golpe actual en el array de ataques (0 = primer golpe)
combo_timer = 0;          // Temporizador para encadenar el siguiente golpe
combo_timer_max = 120;     // Ventana de frames reducida para mayor exigencia


// --- FUNCIONES DE AYUDA (Helper Functions) ---

crear_hitbox_ataque = function(_datos) {
    var _xx = x + ((direccion_mirando == 0) ? 10 : -10);
    var _hitbox = instance_create_layer(_xx, y, "Instances", obj_hitbox);
    _hitbox.creador = id;
    _hitbox.dano = _datos.dano;
    _hitbox.image_angle = direccion_mirando;
    _hitbox.objetivo_colision = obj_enemigo_dummy;
    _hitbox.fuerza_empuje = _datos.empuje;
    _hitbox.direccion_golpe = direccion_mirando;
    _hitbox.max_objetivos = _datos.max_objetivos;
    _hitbox.tiempo_aturdido = _datos.tiempo_aturdido;
    _hitbox.shake_magnitude = _datos.shake_magnitude;
    _hitbox.enemigos_golpeados = [];
    hitbox_creada = true;
};

intentar_ataque = function() {
    var _puedo_atacar = false;
    if (global.key_ataque_ligero && array_length(arma_equipada.ataques_ligeros) > 0) {
        tipo_ataque = "ligero";
        _puedo_atacar = true;
    } else if (global.key_ataque_pesado && array_length(arma_equipada.ataques_pesados) > 0) {
        tipo_ataque = "pesado";
        _puedo_atacar = true;
    }
    
    if (_puedo_atacar) {
        if (!choca_con_entorno(x, y + 1)) estado = PLAYER_STATE.AIR_ATTACK;
        else estado = PLAYER_STATE.ATTACK;
        
        image_index = 0;
        hitbox_creada = false;
        // Limpiar buffers
        global.buffer_ataque_ligero = 0;
        global.buffer_ataque_pesado = 0;
        return true;
    }
    return false;
};


