# Kenji RPG (Project "Start") - GEMINI.md

## Project Overview
**Kenji RPG** is a top-down Action RPG developed using **GameMaker (v2024+)**. The project features a structured approach to game management, a modular combat system, and tile-based physics.

### Main Technologies & Architecture
- **Engine:** GameMaker (IDE Version: 2024.1400.4.986)
- **Language:** GML (GameMaker Language)
- **Architecture:** Manager-based with a central initialization object (`obj_init`) and inheritance for entities.
- **Key Systems:**
    - **Initialization:** `obj_init` handles the global state, weapon database initialization, and manager spawning.
    - **Input Management:** `obj_input_manager` provides a centralized way to handle keyboard inputs (WASD, Arrows, J/K for attacks, Shift/C for dash) via global variables.
    - **Entity & Physics:** `obj_entidad` acts as a parent for all physical objects, providing tile-based collision logic using the `Tiles_Colisiones` layer.
    - **Player Logic:** `obj_jugador` implements a state machine (`PLAYER_STATE`) for actions like `IDLE`, `MOVE`, `ATTACK`, and `DASH`.
    - **Combat System:** A dynamic system where weapons are defined as structs in `global.weapons`. Each weapon has properties for light and heavy attacks, including damage, speed, and hitbox frames.

## Building and Running
Since this is a GameMaker project, it is primarily managed through the GameMaker IDE.

- **Run Project:** Press `F5` within the GameMaker IDE.
- **Build Executable:** Use `Build > Create Executable` in the GameMaker menu.
- **Config:** The project uses the "Default" configuration defined in `Start.yyp`.

## Development Conventions

### Resource Naming
- **Objects:** Prefixed with `obj_` (e.g., `obj_jugador`, `obj_game_manager`).
- **Scripts:** Prefixed with `scr_` (e.g., `scr_constantes`).
- **Sprites:** Various naming (e.g., `Josh_step_up`, `Sprite20`, `str_htipbox`).
- **Rooms:** Prefixed with `rm_` or named descriptively (e.g., `rm_init`, `Inicio`).

### Global Constants & Enums
All global constants, macros, and enums are defined in `scripts/scr_constantes/scr_constantes.gml`.
- **GAME_STATE:** `PLAYING`, `PAUSED`, `MENU`, `CUTSCENE`.
- **PLAYER_STATE:** `IDLE`, `MOVE`, `ATTACK`, `DASH`, `HURT`, `DEAD`.
- **DIR:** `RIGHT`, `UP`, `LEFT`, `DOWN`.

### Physics & Collisions
- **Tile Size:** 32x32 pixels (defined as `TILE_SIZE` macro).
- **Collision Layer:** The physics system expects a tile layer named `"Tiles_Colisiones"` for environmental collisions.
- **Inheritance:** All entities requiring physics should inherit from `obj_entidad` and call `event_inherited()` in their Create event.

### Combat System
- Weapons are stored in `global.weapons` as structs.
- When adding a new weapon, ensure it has `ataque_ligero` and `ataque_pesado` definitions with `sprite`, `dano`, `attack_speed`, `frame_hit`, and `empuje`.
