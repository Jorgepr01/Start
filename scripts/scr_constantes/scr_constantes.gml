function scr_constantes(){
    // --- MACROS ---
    #macro TILE_SIZE 32
    #macro RESOLUTION_W 640
    #macro RESOLUTION_H 360
    #macro COLOR_TEXT_MAIN c_white
    
    // --- ENUMS ---
    // Estados generales del juego (para tu obj_game_manager)
    enum GAME_STATE {
        PLAYING,
        PAUSED,
        MENU,
        CUTSCENE
    }
    
    // Direcciones para los personajes
    enum DIR {
        RIGHT,
        UP,
        LEFT,
        DOWN
    }
    
    // Estados del jugador (para tu máquina de estados)
    enum PLAYER_STATE {
        IDLE,
        MOVE,
        ATTACK,
        DASH,
        HURT,
        DEAD
    }
}