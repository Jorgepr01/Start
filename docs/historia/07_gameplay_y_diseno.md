# 07 — Gameplay y diseño

## Evolución del género

| Antes (documento original) | Ahora |
|---|---|
| Action RPG narrativo 2D, exploración y combate en tiempo real | **Metroidvania de acción 2D lateral** |
| Cámara top-down semifrontal (vista 3/4) | Vista lateral |
| Zonas pequeñas interconectadas, instancias narrativas, escenarios con eventos (no mundo abierto) | Mapa interconectado con backtracking |
| Referencias: juegos narrativos indie | Referencia principal: **Katana ZERO** |

**Por qué el cambio:** facilitó el diseño de personajes y el dibujo. El mapa se volvió más difícil de plantear, pero el arte es más sencillo de trabajar. **La historia sigue igual**; las ramificaciones siguen presentes.

Por qué funciona como metroidvania:

1. Kenji aprende habilidades progresivamente → cada mejora abre zonas.
2. Isla + subterráneos = mapa natural de dos capas (gameplay en superficie, lore abajo).
3. El backtracking tiene sentido narrativo.

## Loop jugable

1. Explorar una zona.
2. Encontrar supers/enemigos.
3. Combate dinámico (dash + katana).
4. Aprender patrones.
5. Descubrir lore.
6. Tomar decisiones.
7. Desbloquear la evolución de Kenji.

Se repite, cada vez más complejo.

## Recursos

- **Barra de vida:** daño recibido.
- **Barra de resistencia (stamina):** se consume al atacar, bloquear, esquivar y correr. **Si se agota, Kenji queda temporalmente vulnerable**, incapaz de defenderse bien.

## Combate

Acción en tiempo real, estilo *Katana ZERO*: combates rápidos, los errores castigan fuerte, **precisión > fuerza bruta**. La diferencia: **no solo matas, también manipulas el combate** (Vector Break).

**Tipos de ataque:**

- **Ligeros:** rápidos, para combos.
- **Fuertes:** más lentos, más daño.
- **Habilidades especiales:** técnicas únicas que consumen energía (con costo o enfriamiento).

**Recompensa:** reflejos, lectura del oponente, uso del entorno.

**Enemigos iniciales:** otros supers, cada uno con habilidades distintas.

### Kenji al inicio puede

- atacar con katana (combos cortos);
- bloquear;
- esquivar;
- correr;
- resistir daño moderado (fuerza física mayor que la humana);
- moverse rápido y ágil, adaptarse al estilo del enemigo.

### Kenji al inicio NO puede

- entender ni usar conscientemente sus poderes;
- robar habilidades;
- usar habilidades infinitamente;
- resistir demasiados golpes directos;
- volar ni usar poderes exagerados;
- dominar todo su potencial.

> Nota: el documento original dice tanto "no tiene habilidades especiales activas" (al inicio) como "puede usar habilidades especiales limitadas". Interpretación: empieza sin ellas y las gana pronto, siempre limitadas.

## Movimiento

El combate depende de movilidad y posicionamiento: Kenji no pelea quieto. Las peleas son **más persecuciones que duelos estáticos**.

- **Dash corto:** en cualquier dirección, para esquivar o acercarse.
- **Salto mejorado:** más alto de lo normal.
- **Deslizamiento:** por el suelo, para evitar ataques.
- **Impulso en paredes:** para cambiar de dirección.

### Profundidad en un juego 2D

Antes se pensaba en top-down (moverse arriba/abajo por el suelo). Decisión: **mantener el movimiento lateral como base**, pero con **profundidad en zonas concretas** (Jorge lo marcó como *"mega importantísimo; de eso depende la dinámica del juego"*):

- **Rutas verticales:** plataformas, escaleras, paredes, estructuras derrumbadas.
- **Entradas al fondo:** puertas, túneles y pasillos que llevan a otra habitación.
- **Zonas de exploración especiales:** entrar en una estructura o refugio y explorar un pequeño escenario desde otra perspectiva, si la historia lo justifica.

No mezclar movimiento libre arriba/abajo en todos los escenarios (complica colisiones y diseño).

**Sensación de profundidad sin 3D:**

- parallax por capas;
- elementos delante y detrás de Kenji (árboles, ramas, ruinas que lo tapan parcialmente);
- un escenario que respira: olas, hierba con viento, luces que parpadean, lluvia, partículas, cables balanceándose (pocos detalles bien elegidos).

> No confundir dinamismo con cantidad de efectos.

## Mapa y gating

- No diseñar un "mapa grande", sino **bloques conectados con propósito**.
- Todo conectado, pero no todo accesible al inicio.
- **El mapa nace del gameplay, no al revés:** una sala → dos conectadas → un mini recorrido.

**Módulos propuestos:**

| Zona | Contenido |
|---|---|
| 1 — Inicio (escape/despertar) | Tutorial, primer combate, primer encuentro con Shun |
| 2 — Superficie destruida | Enemigos básicos, primeros NPC escondidos, rutas bloqueadas |
| 3 — Subterráneo inicial | Laboratorio básico, primeras pistas del pasado de Kenji, puertas que aún no puede abrir |
| 4 — Sector de combate / arena | Enemigos más fuertes, mini-boss |
| 5 — Núcleo del laboratorio (late game) | Verdad del experimento, conexión con el villano |

**Gating con habilidades, no solo con llaves** (el mapa te enseña a usar habilidades):

- desviar proyectiles para activar un mecanismo;
- empuje vectorial para abrir una puerta bloqueada;
- controlar mejor el poder para cruzar una zona peligrosa.

**Otros elementos:** safe zones (refugios subterráneos con NPCs y decisiones), cambios en el mapa (zonas destruidas, rutas nuevas tras eventos).

## Prioridades de desarrollo (acordadas)

1. **Game feel primero.** Que mover a Kenji sea divertido antes que historia, mapas o enemigos complejos.
   - Dash rápido, preciso, responsivo.
   - Hit feedback: hitstop, pequeño retroceso, sonido satisfactorio.
   - Momentum: ágil, técnico, peligroso; no pesado.
2. **Un enemigo simple** (patrulla, ataca, recibe daño) para probar combate, distancia y timing.
3. **Probar el Vector Break muy temprano**: un enemigo dispara, Kenji desvía. Ese es el *"OH SHIT moment"* que hace único al juego.
4. **No diseñar el mapa completo aún.** Construir un **vertical slice** pequeño.
5. No obsesionarse con gráficos finales, lore completo ni cinemáticas.

### Hoja de ruta del prototipo

**Fase 1:** ✅ caminar · ✅ atacar · ⬜ dash · ⬜ daño a enemigos · ⬜ muerte simple
**Fase 2:** ⬜ proyectiles enemigos · ⬜ desviar proyectiles · ⬜ stamina · ⬜ hit feedback
**Fase 3:** ⬜ mini zona explorable · ⬜ save room · ⬜ primer NPC
**Fase 4:** ⬜ encuentro inicial con Shun · ⬜ persecución/tutorial real

**Zona de pruebas en la Isla:** Kenji camina y salta → cámara suave → parallax → vegetación y detalles animados → enemigo sencillo para probar estocada y shuriken. Luego, una segunda habitación con desniveles, ruta alternativa y algo que descubrir.

## Animaciones

**Sprite de Kenji:** ~27 × 50 px.

**Hechas** (al momento del chat):

- posición inicial (reposo/idle);
- caminar (hacia la derecha);
- estocada con katana;
- ataque aéreo (salta y golpea con la katana);
- lanzamiento de shuriken;
- una extra donde se queda dormido.

**Pendientes / ideas:**

- **Caminar hacia la izquierda** — no basta con invertir el sprite: la **correa de la katana en la espalda** es asimétrica y se invertiría también. Hay que redibujarla. (Ni el idle ni el walk existentes están invertidos.)
- **Salto.**
- **Doble salto con Vector Break + aterrizaje.**
- **Esquiva con sensación de profundidad.**
- **Agacharse.**
- **Combo de katana de 3 golpes.**
- **Animación especial de Vector Break.**

Orden sugerido: esquiva → combo de 3 golpes → Vector Break. (Jorge decidió no avanzar con animaciones por ahora.)
