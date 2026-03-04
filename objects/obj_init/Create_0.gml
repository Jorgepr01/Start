

// Inicializar variables globales
global.game_state = GAME_STATE.PLAYING;
global.current_bgm = noone; 

// Base de datos (Structs)
    global.weapons = {
        Latigo_basic: {
            name: "Latigo basico",
            dano: 3,
            attack_speed: 1.2,
            sprite: Josh_attack
        },
        Latigo_hard: {
            name: "Latigo duro",
            dano: 7,
            attack_speed: 0.3,
            sprite: Josh_attack
        }
    };

// Crear los Managers
instance_create_layer(0, 0, "Instances", obj_game_manager);
instance_create_layer(0, 0, "Instances", obj_input_manager);


// Ir al juego
room_goto(Inicio);