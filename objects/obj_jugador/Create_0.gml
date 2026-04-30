/// @description Configurar Jugador
mask_index = spr_josh_mask;
// IMPORTANTE: Heredar las variables y funciones del padre
event_inherited(); 
hp = 100; 
tiempo_flash = 0;
tiempo_aturdido = 0;
velocidad_base =1; 
estado = PLAYER_STATE.IDLE;

velocidad_roll = 1.35;
direccion_mirando = 0;
hitbox_creada = false;
arma_equipada = global.weapons.Latigo
//SISTEMA DE ARMAS Y COMBATE 
inventario_armas = [global.weapons.Latigo, global.weapons.espadon_hierro];
indice_arma = 0;
arma_equipada = inventario_armas[indice_arma];

tipo_ataque = "ligero";
hitbox_creada = false;

