// Evento Create de obj_init

// Inicializar variables globales
global.game_state = GAME_STATE.PLAYING;
global.current_bgm = noone; 

// Base de datos (Structs)
    global.weapons = {
        sword_basic: {
            name: "Espada de Madera",
            damage: 5,
            attack_speed: 1.2,
            sprite: noone
        },
        bow_basic: {
            name: "Arco Corto",
            damage: 3,
            attack_speed: 0.8,
            sprite: noone
        }
    };

// Crear los Managers
instance_create_layer(0, 0, "Instances", obj_game_manager);
instance_create_layer(0, 0, "Instances", obj_input_manager);


// Ir al juego
room_goto(Inicio);