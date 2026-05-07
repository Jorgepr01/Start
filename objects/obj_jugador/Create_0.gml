/// @description Configurar Jugador
mask_index = spr_josh_mask;
// IMPORTANTE: Heredar las variables y funciones del padre
event_inherited(); 
hp = 100; 
tiempo_flash = 0;
tiempo_aturdido = 0;
velocidad_base =1.3; 
estado = PLAYER_STATE.IDLE;

// Salto y Movimiento
max_saltos = 2;
saltos_realizados = 0;
coyote_time = 0;
coyote_time_max = 5;
jump_buffer = 0;
jump_buffer_max = 5;

velocidad_roll = 2.;
direccion_mirando = 0;
hitbox_creada = false;
arma_equipada = global.weapons.Latigo
//SISTEMA DE ARMAS Y COMBATE 
inventario_armas = [global.weapons.Latigo, global.weapons.espadon_hierro];
indice_arma = 0;
arma_equipada = inventario_armas[indice_arma];

tipo_ataque = "ligero";
hitbox_creada = false;

