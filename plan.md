# exile_alchemy — Plan de Desarrollo

## Filosofía

Máxima química posible disfrazada de alquimia, usando **materiales ya existentes** en el juego como punto de partida.  
No modificar el juego base. No añadir minerales nuevos salvo los imprescindibles.  
Simplicidad: pocas mecánicas bien hechas valen más que muchas a medias.

---

## Dependencias

- `advanced_ceramics` ← **mod nuevo** (a crear): provee `alembic`, `clay_amphora` y el sistema de cocción de cerámica
- `tech` — materiales base, nodeboxes compartidos
- `climate` — temperatura ambiente para fermentación
- `ncrafting` — sistema de cocción/firing
- `nodes_nature` — plantas, hongos, suelos

---

## Materiales existentes aprovechables

Estos ya están en el juego (`tech:*`) y serán insumos de las cadenas:

| Material | Nodo/Item |
|---|---|
| Ceniza de madera | `tech:wood_ash` |
| Carbon vegetal | `tech:charcoal` |
| Cal viva | `tech:quicklime` |
| Cal apagada | `tech:slaked_lime` |
| Potasa | `tech:potash` |
| Harina de hueso | `tech:bonemeal` |
| Aceite vegetal | `tech:vegetable_oil` |
| Hierro | `tech:iron_ingot` |
| Mineral de hierro | `tech:roasted_iron_ore_powder` |
| Mosto de wiha | `tech:wiha_must_pot` |
| Sidra de wiha | `tech:wiha_cider_pot` |
| Jarabe de tartaris | `tech:tartaris_syrup_amphora` |
| Jarabe de tartaris fermentado | `tech:fermented_tartaris_syrup_amphora` |
| Tang | `tech:tang` |
| Polvo de cuarzo | `tech:quartz_powder` |
| Ceniza molida de basalto | `tech:crushed_basalt` |
| Vidrio verde/claro | `tech:green_glass_pieces` / `tech:clear_glass_pieces` |

---

## Etapa 1 — Cerámica Primitiva (Alembic + Amphora)

> Dependencia: `advanced_ceramics`  
> Meta: desalinización del agua del mar y fermentación de la wiha en vino.

### 1.1 Desalinización — Destilación en Alembic

El alembic se calienta debajo con fuego (ya tiene `heatable`).  
Implementar via `on_timer` que se activa cuando la temperatura del nodo supera un umbral.

```
Agua de Mar (bucket) + Alembic caliente → Sal + Agua (bucket)
```

- **Mecánica:** `on_timer` del alembic detecta calor (`climate.get_point_temp` o nodo de fuego debajo), consume el agua de mar del inventario del nodo y produce sal + agua.
- **Sal:** item `exile_alchemy:salt` (sin usos en esta etapa — subproducto inútil intencional).
- El alembic tiene un slot de entrada y dos de salida.

### 1.2 Fermentación — Amphora de Wiha Must → Vino

Rescatar y limpiar el código existente de `tech:wiha_must_pot`.

```
Wiha molida (mashed_wiha) + Amphora → Wiha Must Pot (timer, 10-34°C) → Wiha Cider Pot (vino)
```

- La amphora usa `climate` para temperatura de fermentación.
- El vino (`wiha_cider_pot`) tiene efecto ebrio al consumirse.
- Rescatar también el `tang` fermentado (`tech:tang` → `tech:tang_unfermented`) si ya tiene lógica.

---

## Etapa 2 — Destilación y Acetificación (Glass Retort + Vessel)

> Dependencia: `advanced_ceramics`, vidrio de `tech`  
> Meta: producir alcohol puro, vinagre y azúcar. Primeros usos reales de la sal.

### Nuevos nodos (proveer en este mod)
- `exile_alchemy:glass_retort` — rescatar nodebox de `tech:glass_retort`
- `exile_alchemy:glass_vessel` — rescatar nodebox de `tech:glass_vessel`

### 2.1 Destilación en Retort

```
Wiha Cider (amphora) + Retort caliente → Alcohol + Wiha Dregs
Tartaris Syrup (amphora) + Retort caliente → Azúcar + Agua
```

- **Alcohol:** item `exile_alchemy:alcohol`. Usos: combustible de lámpara mejorada, base de vinagre, base etapa 3.
- **Azúcar:** item `exile_alchemy:sugar`. Usos: recetas de cocina, fermentación acelerada.

### 2.2 Acetificación — Vino → Vinagre

Proceso histórico: sidra o vino expuesto al aire con inoculante (hongo) a 15–34°C durante 1–3 semanas (escala de juego: ~600 s de timer).

```
Wiha Cider Pot + Hongo silvestre (right-click) → Amphora abierta (timer, 15-34°C) → Vinegar Pot
```

- El hongo actúa como inoculante de *Acetobacter* (históricamente así se hacía: "madre del vinagre").
- Hongos disponibles: `nodes_nature:mushroom_*` o similares.
- **Vinagre:** item/node `exile_alchemy:vinegar_pot`. Usos: conservación, receta de jabón (etapa 3), carbón activado (etapa 3).

### 2.3 Sal — Primeros usos

Con alcohol y vinagre disponibles, la sal puede usarse en:
- Escabeche / conservación de comida (si existe mechanic de caducidad)
- Salmuera en vessel: `sal + agua → brine` para curar cuero

---

## Etapa 3 — Química Aplicada (Jabón, Carbón Activado, Pólvora)

> Meta: productos de utilidad práctica en el juego derivados de cadenas largas.  
> Usar materiales ya construidos en etapas anteriores.

### Ruta del Jabón (saponificación histórica)

```
Ceniza → [hidratación] → Potasa (ya existe: tech:potash)
Piedra caliza → [calcinación, horno] → Cal viva (ya existe: tech:quicklime)
Cal viva → [hidratación] → Cal apagada (ya existe: tech:slaked_lime)
Cal apagada + Potasa → [vessel, tiempo] → Lixiviado alcalino (nuevo: exile_alchemy:lye)
Aceite vegetal + Lixiviado → [retort, calor] → Pasta de jabón (nuevo)
Pasta de jabón + Sal → [tiempo] → Jabón salado (grado de calidad superior)
```

El jabón tiene usos en salud/higiene si existe mecánica, o como componente de otros procesos.

### Ruta del Carbón Activado

```
Carbón vegetal (tech:charcoal) → [calcinación, horno] → Carbón calcinado
Carbón calcinado + Vinagre → [vessel, tiempo] → Carbón activado (exile_alchemy:activated_carbon)
```

Usos del carbón activado: purificación de agua, filtro (mecánica de agua potable si existe), antídoto leve.

### Ruta de la Pólvora

```
Ceniza de madera → [hidratación] → Potasa (tech:potash)
Potasa + Nitrato de Sodio* → Nitrato de Potasio (salitre)
Salitre + Carbón + Azufre** → Pólvora
```

\* Nitrato de Sodio: destilación de agua de mar concentrada (salt brine evaporada) — el agua de mar contiene nitratos.  
\*\* Azufre: extraído de `tech:crushed_basalt` (la arena volcánica contiene azufre según el lore del juego).

**Nota:** La pólvora abre posibilidades de explosivos o propulsión (flechas de fuego, etc.) — definir usos en contexto del juego.

---

## Etapa 4 — Alquimia Avanzada (Ácidos, Metales, Fantasía)

> Meta: la "magia" de la alquimia. Cadenas largas con alta recompensa. Opcional/endgame.

### Ruta del Ácido Sulfúrico

```
Azufre + Hierro + Agua → [retort, calor alto] → Ácido Sulfúrico (exile_alchemy:sulfuric_acid)
```

### Ruta del Aluminio

```
Feldespato (de gneis o granito) → [molienda] → Polvo de feldespato
Polvo de feldespato + Ácido Sulfúrico → [retort] → Alumina (Óxido de Aluminio)
Alumina → [horno a alta temperatura] → Aluminio (exile_alchemy:aluminium)
```

Ya existe `tech:aluminium_ingot` y `tech:aluminium_mix` — conectar la cadena desde cero con materiales naturales.

### Materiales de Fantasía

Usando las cadenas anteriores como "ingredientes alquímicos":

| Producto | Ingredientes | Efecto |
|---|---|---|
| Elixir Vitae | Alcohol + Carbón Activado + Azúcar + [algo raro] | Buff de salud/curación |
| Superfertilizante | Potasa + Salitre + Carbón activado | Crecimiento acelerado de plantas |
| Combustible Alquímico | Alcohol concentrado + Azufre | Combustible de alto rendimiento para hornos |
| Augurelli Glaure | Feldespato + Ácido Sulfúrico + Salitre | "Oro alquímico" — moneda o decoración |

---

## Cadena de Materiales — Visión Completa

```
NATURALEZA
  Agua de Mar ──────────────────── Alembic ──→ Sal + Agua
  Wiha molida ── Amphora (timer) ── → Vino ─── Retort ──→ Alcohol
                                         └──── Amphora+hongo ──→ Vinagre
  Tartaris ────── Amphora (timer) ──→ Fermento ─ Retort ──→ Azúcar + Agua

SAL             → (usos cocina) → Salmuera → Cuero curado
ALCOHOL         → Retort ──────────────────────────────────→ Vinagre concentrado
VINAGRE         → Carbón calcinado ────────────────────────→ Carbón Activado
POTASA + Cal apagada → Vessel ─────────────────────────────→ Lejía
LEJÍA + Aceite  → Retort ──────────────────────────────────→ Jabón
AZUFRE          → + Hierro + Agua → Retort ────────────────→ Ácido Sulfúrico
ÁCIDO SULFÚRICO → + Feldespato ───→ Retort ────────────────→ Alumina → Aluminio
SALITRE + AZUFRE + CARBÓN ──────────────────────────────────→ Pólvora
```

---

## Implementos del Mod

| Nodo | Origen | Función |
|---|---|---|
| `exile_alchemy:alembic` | Rescatar de `tech:alembic` | Destilación caliente |
| `exile_alchemy:clay_amphora` | Rescatar de `tech:clay_amphora` | Fermentación (timer + temp) |
| `exile_alchemy:glass_retort` | Rescatar de `tech:glass_retort` | Destilación fina, reacciones |
| `exile_alchemy:glass_vessel` | Rescatar de `tech:glass_vessel` | Mezclas en frío, tiempo |

Todos los nodos de cerámica sin cocer (`_unfired`) serán responsabilidad de `advanced_ceramics`.

---

## Lo que se elimina del mod actual

- `tech:alchemy_bench` y todas sus recetas
- Minerales mágicos: `nightstone`, `nephritic_stone`, `star_dust`, `brimstone`, `death_salt`, `serpentine`, `aurifex`, `bauxita`
- Piedras trituradas sin cadena: `crushed_basalt`, `crushed_gneiss`, `crushed_granite` (si no tienen uso)
- `tech:clay_crucible`, `tech:clay_mortar` (sin uso en el nuevo diseño)
- `tech:soap`, `tech:soap_uncured` (se rehacen con cadena propia en etapa 3)
- `tech:acrimoniac_amphora`, `tech:vitriol_vessel`, `tech:elixir_vitae` (se rehacen en etapa 4)
- `tech:tartar_salt`, `tech:saltpeter` (se rehacen con cadena real)

---

## Estructura de Archivos Final

```
exile_alchemy/
  mod.conf           ← depends: advanced_ceramics, tech, climate, nodes_nature
  init.lua
  plan.md            ← este archivo
  common/
    alchemy.lua      ← nodeboxes, helpers, constantes de temperatura
  items/
    base.lua         ← salt, sugar, alcohol, vinegar (items simples)
    advanced.lua     ← lye, activated_carbon, saltpeter, sulfuric_acid...
  nodes/
    alembic.lua      ← destilador: seawater→salt, cider→alcohol, syrup→sugar
    amphora.lua      ← fermentación: wiha→cider, cider+hongo→vinegar
    glass.lua        ← retort y vessel con sus mecánicas
  crafts/
    stage1.lua       ← recetas etapa 1
    stage2.lua       ← recetas etapa 2
    stage3.lua       ← recetas etapa 3
    stage4.lua       ← recetas etapa 4
```
