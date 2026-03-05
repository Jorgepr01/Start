/// @description Controlar el flujo del juego

if (global.key_pause) {
    show_debug_message("key_pause True", global.key_pause);
    if (global.game_state == GAME_STATE.PLAYING) {
        global.game_state = GAME_STATE.PAUSED; // se pone en pausa
        
        // 1. Apaga todo (excepto a mí mismo, el obj_game_manager)
        instance_deactivate_all(true); 
        
        // 2. Reactiva INMEDIATAMENTE los controladores vitales
        instance_activate_object(obj_input_manager);
        instance_activate_object(obj_menu_principal);
        // instance_activate_object(obj_audio_manager);
        
        // Aquí activarías el objeto que dibuja el menú de pausa
        instance_create_layer(0, 0, "UI_Layer", obj_menu_principal);
        
    } 
    else if (global.game_state == GAME_STATE.PAUSED) {
        global.game_state = GAME_STATE.PLAYING;
        // se va al juego
        instance_destroy(obj_menu_principal);
        // Reactiva todo el mundo (enemigos, jugador, balas)
        instance_activate_all();
        
        
        
        
    }
}