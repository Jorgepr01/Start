event_inherited(); 
hp = 50
hsp = 0;
vsp = 0;
friccion = 0.15;
tiempo_flash = 0;
tiempo_aturdido = 0
enum ENEMY_STATE {
    IDLE, // quieto
    CHASE  // reconocido a enemigo (persergir)
}
estado_actual = ENEMY_STATE.IDLE;
radio_vision = 150;
velocidad_caminar = 0.65;
