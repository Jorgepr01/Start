/// @description Configurar Jugador

// IMPORTANTE: Heredar las variables y funciones del padre
event_inherited(); 

// Ajustes específicos del jugador
velocidad_base =1; 

// Estado inicial
estado = PLAYER_STATE.IDLE;

// En tu Evento Create, añade estas variables:
velocidad_roll = 1.2; // Debe ser más alta que la velocidad_base
direccion_mirando = 270; // 270 grados es hacia abajo por defecto