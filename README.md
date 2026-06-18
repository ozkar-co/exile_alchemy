# exile_alchemy

Standalone Exile mod for distillation, wiha fermentation, and basic alchemical materials.

## Features

- **Alembic** — distill liquids from clay pots placed underneath (salt, alcohol, sugar, vinegar).
- **Wiha chain** — mashed wiha → must → wine → cider, with drink effects.
- **Materials** — salt, alcohol, sugar, vinegar, dregs, clear glass tubes.
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
5. Ferment must → wine → cider (10–34°C). Place alembic above filled pots to distill.

## Effects

Alchemy effects use `player_api` so they appear on the **Character** inventory tab (same list as "Well-rested" or "Drunk").

| Trigger | Effect | Severity |
|---------|--------|----------|
| Drink wiha cider | Sour Revulsion | 1 (queasy) |
| Drink vinegar (item) | Sour Revulsion | 2 (nauseous) |

New effects can be registered with `exile_alchemy.register_effect()` in `common/effects.lua` (future: dirtiness, heavy metals, etc.).

## Notes

- The alembic cannot be disassembled yet; complex clay disassembly is planned for `exile_advanced_ceramics`.
- Unused fantasy/alchemy textures are kept in `textures/unused/` for future work.

## License

Unlicense — see LICENSE.
