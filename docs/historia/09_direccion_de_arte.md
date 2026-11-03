# 09 — Dirección de arte

## Estilo

**Low-res stylized pixel art**: pixel art indie de baja resolución, estilizado, con siluetas definidas y estética de acción oscura.

| Característica | Descripción |
|---|---|
| Técnica | Pixel art digital |
| Resolución visual | Baja, píxeles gruesos y visibles |
| Nivel de detalle | Bajo a moderado |
| Paleta | Limitada, con contrastes marcados |
| Personajes | Sprites estilizados, proporciones simplificadas, contornos oscuros |
| Sombreado | Por bloques de color |
| Efectos | Pixel art brillante y contrastado |
| Género visual | Acción indie 2D |

- **No** es estrictamente 8-bit ni 16-bit.
- Personajes reconocibles por forma, postura, cabello, ropa y armas, sin cada detalle anatómico.
- El estilo de Jorge es **un poco menos detallado** que las referencias, y se quiere **mantener así**.

## Lo que Jorge busca (y lo que no)

✅ Sí:

- pixel art sencillo y estilizado que combine con Kenji;
- ambientes con personalidad: naturaleza, ruinas, instalaciones lejanas, señales de que hubo gente viviendo allí;
- **tecnología sutil**;
- atmósfera **oscura pero humana**: misterio, soledad, melancolía;
- un mundo que se sienta **grande** con elementos visuales **sencillos**.

❌ No:

- todo robótico-mecánico, como una fábrica;
- arte demasiado crudo o brutal;
- hiperrealismo, *ultra-detailed 4K*, *photorealistic*, *8-bit retro*.

Referencias que le gustaron: los estilos de **"refugios y humanidad"**, **"siluetas definidas y diseño estilizado"** (el más parecido al suyo), **"superficie de la isla"** y **"refugios subterráneos"**; y el panorama de la costa que generó Claude (Kenji se ve bien ahí).

> No hace falta que cada escenario sea espectacular; hace falta que **todos parezcan del mismo juego**.

## Paleta (versión corta)

| Color | Hex | Uso |
|---|---|---|
| Negro carbón | `#171719` | Sombras y siluetas |
| Gris acero | `#34343A` | Estructuras y laboratorios |
| Azul pizarra | `#56616C` | Tecnología y atmósfera fría |
| Marrón oscuro | `#49352D` | Ropa de Kenji y refugios |
| Rojo carmesí | `#8B2935` | Poderes y misterio |
| Rojo brillante | `#E34B52` | Efectos de Vector Break |
| Ámbar | `#D99A52` | Luces cálidas de los refugios |
| Blanco cálido | `#D7D0C8` | Piel, reflejos y detalles |

Otros tonos citados: marrón neutro `#6B5142`, piel cálida `#D7B18B`.

**Distribución orientativa** en escenarios normales: 50 % negros y grises · 25 % azules/fríos · 15 % marrones/neutros · 10 % rojos y acentos luminosos. Refugios, jefes y zonas narrativas importantes pueden romperla a propósito.

> **El mundo debe sentirse frío; las personas, vulnerables; y los poderes, anormales.**

## Paleta por zona

| Zona | Colores | Sensación |
|---|---|---|
| **La Isla / laboratorios / contención** | Negro carbón, gris acero, azul pizarra; rojo solo en alarmas, señales de peligro y rastros de destrucción | Opresión, misterio, frío, artificial, hostil |
| **Refugios** | Marrones apagados, beige, gris cálido, ámbar tenue | Humanidad, vulnerabilidad, posibilidad de confiar en otros (primeros colores cálidos) |
| **Sectores experimentales** | Azul frío, negro profundo, rojo intenso | Secretos y peligro; el rojo aumenta cuanto más cerca del pasado de Kenji |
| **Superficie / costa** | Carbón, verde apagado, gris azulado, marrón oscuro, toques carmesí | Misterio, soledad, ligeramente inquietante, cielo nublado y luz fría |

## El rojo como motivo narrativo

- Kenji normal: negro, marrón oscuro, gris, piel cálida. Sobrio y humano.
- Kenji con Vector Break: aire distorsionado, líneas carmesí, píxeles rojo brillante.
- El jugador **aprende a asociar el rojo con el poder de Kenji antes de entender su origen**. Cuando encuentre tecnología, experimentos o personajes con esa estética, la repetición despertará sospechas.
- Todavía **no fijar** que todo lo rojo pertenezca a Kenji: dejar espacio para que la historia revele conexiones (p. ej. el "otro personaje rojo").

## Qué tomar de *Katana ZERO* y qué no

Tomar:

- **contraste fuerte** (lo importante se reconoce de inmediato);
- **color con intención** (la iluminación construye el estado emocional);
- **efectos contundentes** (impactos legibles incluso con sprites pequeños).

Evitar: la dependencia de **neones saturados**. Este juego es más industrial y desaturado: isla, experimentación humana, pérdida de memoria, distorsión vectorial.

## Fondos: reglas para que combinen con los sprites

1. **Pixel art estilizado, no hiperrealista.**
2. **Contraste reservado para los personajes:** Kenji debe destacar al instante.
3. **Perspectiva lateral 2D estricta**, sin isometría ni top-down.
4. **Capas independientes** (primer plano, jugable, fondo) para parallax y colisiones.
5. **Zona central despejada** para combate.
6. Detalles del fondo relativamente **grandes y simples** (Kenji mide solo 27 × 50 px).
7. Los fondos pueden ser algo más detallados que los personajes, mientras compartan el mismo lenguaje visual.

### Capas del fondo de la costa (ya en uso)

De atrás hacia delante:

1. `00_cielo`
2. `01_oceano`
3. `02_costa_lejana`
4. `03_vegetacion_rocas`
5. `04_suelo_jugable` — donde camina Kenji
6. `05_primer_plano` — delante de Kenji

`isla_costa_compuesto` es solo una vista previa con todo junto; no usarla junto a las capas.

En GameMaker: una **Asset Layer** por imagen en la Room, alineando horizonte y suelo. **El dibujo del suelo no tiene colisión**: hace falta un objeto/capa de colisión debajo de la superficie.

Formato ideal de entrega desde una IA: PNG por capa, dimensiones compatibles, fondo transparente cuando corresponda, todo en un ZIP, con dimensiones exactas de cada archivo.

Prompts completos en [10 — Prompts para IA](10_prompts_ia.md).
