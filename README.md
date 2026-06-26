# exile_alchemy

Standalone Exile mod for distillation, wiha fermentation, and basic alchemical materials.

## Features

- **Alembic** — distill liquids from clay pots placed underneath (salt, alcohol, sugar, acetic acid).
- **Wiha chain** — mashed wiha → must → wine → cider (vinegar in pot), with drink effects.
- **Materials** — salt, alcohol, sugar, acetic acid, dregs, clear glass tubes.
- **Alchemy effects** — custom status effects via `player_api`, visible on the Character tab.

## Dependencies

Requires the base Exile game mods plus:

- `exile_advanced_ceramics` — alembic is crafted on the pottery wheel (level 2).
- `player_api` / `player_monoids` — effect display and movement penalties.

Does **not** modify the base Exile repository.

## Progression

1. Craft **clear glass tubes** at the glass furnace (`tech:clear_glass_ingot` → 2 tubes).
2. Craft **alembic (unfired)** on the pottery wheel: 4 wet clay + 2 tubes.
3. Fire the unfired alembic like other pottery.
4. Make **mashed wiha** (6 wiha, mortar and pestle) → **must** (4 mashed + freshwater pot).
5. Ferment must → wine → **cider** (10–34°C). Cider is wiha vinegar in a pot (`group:vinegar`), like base-game Tang vinegar.
6. Place the alembic above a vinegar pot with heat to distill **acetic acid** (from wiha cider or `tech:tang_vinegar`).

## Vinegar vs acetic acid

| Form | Source | Use |
|------|--------|-----|
| **Pot vinegar** (`group:vinegar`) | Exile Tang chain or wiha cider | Crafting ingredient (`group:vinegar/pot`) |
| **Acetic acid** (item) | Alembic over a vinegar pot | Concentrated reagent for advanced alchemy (future) |

## Effects

Alchemy effects use `player_api` so they appear on the **Character** inventory tab (same list as "Well-rested" or "Drunk").

| Trigger | Effect | Severity |
|---------|--------|----------|
| Drink wiha cider | Sour Revulsion | 1 (queasy) |
| Drink acetic acid (item) | Sour Revulsion | 3 (wretching) |

New effects can be registered with `exile_alchemy.register_effect()` in `common/effects.lua` (future: dirtiness, heavy metals, etc.).

## Notes

- The alembic cannot be disassembled yet; complex clay disassembly is planned for `exile_advanced_ceramics`.
- Unused fantasy/alchemy textures are kept in `textures/unused/` for future work.
- Legacy item name `exile_alchemy:vinegar` aliases to `exile_alchemy:acetic_acid`.

## License

Unlicense — see LICENSE.
