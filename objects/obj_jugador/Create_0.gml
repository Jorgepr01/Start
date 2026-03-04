/// @description Configurar Jugador

// IMPORTANTE: Heredar las variables y funciones del padre
event_inherited(); 

// Ajustes específicos del jugador
velocidad_base =1; 
estado = PLAYER_STATE.IDLE;// estado inicial

velocidad_roll = 1.35; // velocidad del roll
direccion_mirando = 270; // va abajo por defecto
hitbox_creada = false;
arma_equipada = global.weapons.Latigo
// --- SISTEMA DE ARMAS Y COMBATE ---
inventario_armas = [global.weapons.Latigo, global.weapons.espadon_hierro];
indice_arma = 0;
arma_equipada = inventario_armas[indice_arma];

tipo_ataque = "ligero";
hitbox_creada = false;