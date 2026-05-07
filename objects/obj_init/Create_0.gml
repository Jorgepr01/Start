// Inicializar variables globales
global.game_state = GAME_STATE.PLAYING;
global.current_bgm = noone; 

// Base de datos (Structs)
global.weapons = {
    Latigo: {
        name: "Latigo",
        ataque_ligero: { 
            sprite: Josh_attack,
            dano: 5, 
            attack_speed: 1, 
            frame_hit: 8 ,
            empuje: 3,
            max_objetivos: 1,
            tiempo_aturdido: 20,
            shake_magnitude: 2
        },
        ataque_pesado: { 
            sprite: Josh_attack,
            dano: 15, 
            attack_speed: 0.5, 
            frame_hit: 10,
            empuje: 6,
            max_objetivos: 99,
            tiempo_aturdido: 40,
            shake_magnitude: 5
        }
    },
    espadon_hierro: { // otra arma
        name: "Espadón Pesado",
        ataque_ligero: { // cuando presiona j
            sprite: Sprite20, 
            dano: 7, 
            attack_speed: 1.0, 
            frame_hit: 9,
            empuje: 3,
            max_objetivos: 2,
            tiempo_aturdido: 30,
            shake_magnitude: 4
        },
        ataque_pesado: { // cuando presiona k
            sprite: Sprite20, 
            dano: 20, 
            attack_speed: 0.2, 
            frame_hit: 12,
            empuje: 8,
            max_objetivos: 99,
            tiempo_aturdido: 60,
            shake_magnitude: 8
        }
    }
}

// Crear los Managers
instance_create_layer(0, 0, "Instances", obj_game_manager);
instance_create_layer(0, 0, "Instances", obj_input_manager);

// Ir al juego
room_goto(Inicio);
