# exile_alchemy

Standalone Exile mod for distillation, wiha fermentation, and basic alchemical materials.

## Features

- **Alembic** — distill liquids from clay pots placed underneath (salt, alcohol, sugar, vinegar).
- **Wiha chain** — mashed wiha → must → wine → cider, with drink effects.
- **Materials** — salt, alcohol, sugar, vinegar, dregs, clear glass tubes.

## Dependencies

Requires the base Exile game mods plus:

- `exile_advanced_ceramics` — alembic is crafted on the pottery wheel (level 2).

Does **not** modify the base Exile repository.

## Progression

1. Craft **clear glass tubes** at the glass furnace (`tech:clear_glass_ingot` → 2 tubes).
2. Craft **alembic (unfired)** on the pottery wheel: 4 wet clay + 2 tubes.
3. Fire the unfired alembic like other pottery.
4. Make **mashed wiha** (6 wiha, mortar and pestle) → **must** (4 mashed + freshwater pot).
5. Ferment must → wine → cider (10–34°C). Place alembic above filled pots to distill.

## Notes

- Wiha cider temporarily applies **Food Poisoning** (mild); replace with **Nausea** when that effect exists in health.
- The alembic cannot be disassembled yet; complex clay disassembly is planned for `exile_advanced_ceramics`.
- Unused fantasy/alchemy textures are kept in `textures/unused/` for future work.

## License

Unlicense — see LICENSE.
