// Inicializar variables globales
global.game_state = GAME_STATE.PLAYING;
global.current_bgm = noone; 

// Base de datos (Structs)
global.weapons = {
    Katana: {
        name: "Katana",
        ataques_ligeros: [
            { sprite: spr_Kenji_golpe_ligero_1, dano: 8, attack_speed: 1, frame_hit: 5 , empuje: 4, max_objetivos: 1, tiempo_aturdido: 20, shake_magnitude: 2 },
            { sprite: spr_Kenji_golpe_ligero_2, dano: 10, attack_speed: 1.1, frame_hit: 5, empuje: 5, max_objetivos: 1, tiempo_aturdido: 20, shake_magnitude: 3 },
            { sprite: spr_Kenji_golpe_ligero_3, dano: 15, attack_speed: 1.2, frame_hit: 5, empuje: 10, max_objetivos: 2, tiempo_aturdido: 35, shake_magnitude: 6 }
        ],
        ataques_pesados: [
            { sprite: spr_Kenji_golpe_pesado_1, dano: 15, attack_speed: 0.8, frame_hit: 5, empuje: 12, max_objetivos: 99, tiempo_aturdido: 50, shake_magnitude: 8 },
            { sprite: spr_Kenji_shuriken, dano: 20, attack_speed: 0.8, frame_hit: 5, empuje: 12, max_objetivos: 99, tiempo_aturdido: 50, shake_magnitude: 8 }
        ]
    },
    Shuriken: { 
        name: "Shuriken",
        ataques_ligeros: [
            { sprite: spr_Kenji_shuriken, dano: 5, attack_speed: 2.0, frame_hit: 4, empuje: 1, max_objetivos: 1, tiempo_aturdido: 5, shake_magnitude: 1 },
            { sprite: spr_Kenji_shuriken, dano: 5, attack_speed: 2.0, frame_hit: 4, empuje: 1, max_objetivos: 1, tiempo_aturdido: 5, shake_magnitude: 1 }
        ],
        ataques_pesados: []
    }
}

// Crear los Managers
instance_create_layer(0, 0, "Instances", obj_game_manager);
instance_create_layer(0, 0, "Instances", obj_input_manager);

// Ir al juego
room_goto(Inicio);
