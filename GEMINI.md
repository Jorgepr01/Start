# Kenji RPG - Project Context

## Project Overview
Kenji is a 2D **Metroidvania** Action developed using **GameMaker Studio 2** (v2024.1400.4.986+). The project follows a modular architecture with specialized manager objects and a state-driven player controller. One of its primary inspirations is **Katana Zero**.

### Core Technologies
- **Engine:** GameMaker Studio 2
- **Language:** GML (GameMaker Language)
- **Architecture:** Manager-based with Inheritance (`obj_entidad` as base for physics/collisions).

## Architecture & Systems

### 1. Initialization & Managers
- **Initialization:** Handled by `obj_init` in the `rm_init` room. It sets up global data structures and spawns persistent managers.
- **Global Managers:**
  - `obj_game_manager`: Tracks global game state (`GAME_STATE` enum).
  - `obj_input_manager`: Centralizes input reading (`global.key_right`, `global.key_jump`, etc.).
  - `obj_camara`: Manages view following and screen effects.

### 2. Entity & Physics System
- **`obj_entidad`:** The base parent for all moving entities.
  - **Tile-based Collisions:** Uses `choca_con_tile()` to check against the tilemap layer named `"Tiles_Colisiones"`.
  - **Movement Logic:** Implements `aplicar_movimiento()` for pixel-perfect collision resolution.
- **`obj_jugador`:** Inherits from `obj_entidad` and implements a comprehensive state machine.

### 3. State Machine (Player)
Managed via the `PLAYER_STATE` enum in `scr_constantes.gml`:
- `IDLE`, `MOVE`, `ATTACK`, `DASH`, `AIR`, `AIR_ATTACK`, `HURT`, `DEAD`.

### 4. Combat System
- **Weapon Data:** Stored in `global.weapons` as a struct (e.g., `Latigo`, `espadon_hierro`).
- **Hitboxes:** Dynamic spawning of `obj_hitbox` during attack frames. Hitboxes carry properties like damage, knockback, and stun time.

## Development Conventions

### Coding Style
- **Naming:** `obj_` for objects, `spr_` for sprites, `scr_` for scripts, `rm_` for rooms.
- **Constants:** Macros and Enums are defined in `scripts/scr_constantes/scr_constantes.gml`.
- **Global State:** Accessible via the `global` scope (e.g., `global.game_state`).

### Scene Setup
- **Resolution:** 640x360 (`RESOLUTION_W`, `RESOLUTION_H`).
- **Tile Size:** 32px (`TILE_SIZE`).
- **Collision Layer:** Always ensure a tile layer named `"Tiles_Colisiones"` exists in rooms for physics to work.

## Building and Running
- **IDE:** Open `Start.yyp` in GameMaker Studio 2.
- **Run:** Press `F5` or the Play button in the IDE.
- **Debug:** Press `F6` for the debugger.
- **Testing:** New features should be tested in the `prueba` room.

## Key Files
- `Start.yyp`: Project definition file.
- `scripts/scr_constantes/scr_constantes.gml`: Central hub for game-wide settings.
- `objects/obj_init/Create_0.gml`: Game entry point and data initialization.
- `objects/obj_entidad/Create_0.gml`: Core physics and collision logic.
- `objects/obj_jugador/Step_0.gml`: Primary player logic and state machine.

## 5. Communication
- `Role`: Act as a Senior Developer
- Always reply in English. Use clear, professional, and technical language suitable for a B1 level.

