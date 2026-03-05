

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
                attack_speed: 1.5, 
                frame_hit: 8 ,
                empuje: 3
            },
            ataque_pesado: { 
                sprite: Josh_attack,
                dano: 15, 
                attack_speed: 0.5, 
                frame_hit: 10,
                empuje: 8
            }
        },
        espadon_hierro: { // otra arma
            name: "Espadón Pesado",
            ataque_ligero: { // cuando presiona j
                sprite: Sprite20, 
                dano: 10, 
                attack_speed: 1.0, 
                frame_hit: 9,
                empuje: 3
            },
            ataque_pesado: { // cuando presiona k
                sprite: Sprite20, 
                dano: 25, 
                attack_speed: 0.2, 
                frame_hit: 12,
                empuje: 8
            }
        }
         }

// Crear los Managers
instance_create_layer(0, 0, "Instances", obj_game_manager);
instance_create_layer(0, 0, "Instances", obj_input_manager);


// Ir al juego
room_goto(Inicio);