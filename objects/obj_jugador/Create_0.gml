/// @description Configurar Jugador

// IMPORTANTE: Heredar las variables y funciones del padre
event_inherited(); 

// Ajustes específicos del jugador
velocidad_base =1; 
estado = PLAYER_STATE.IDLE;// estado inicial

velocidad_roll = 1.35; // velocidad del roll
direccion_mirando = 270; // va abajo por defecto
hitbox_creada = false;
arma_equipada = global.weapons.Latigo_basic