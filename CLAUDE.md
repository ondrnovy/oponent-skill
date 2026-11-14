# oponent-skill — pravidla pro úpravy repa

Veřejný skill. Platí pro každou změnu:

- **Žádné osobní ani firemní údaje.** Příklady jsou vymyšlené nebo obecné.
- Česky, krátké věty, prostý jazyk. Data absolutně.
- Nová sada rolí = `skills/oponent/role/<sada>.md` se sekcemi `## <role>` + řádek v tabulce
  v `SKILL.md` a `README.md`.
- Změna chování → zvýšit verzi v `skills/oponent/VERZE` a `.claude-plugin/plugin.json`
  a zapsat do `CHANGELOG.md`.

## Vydání

`tools/zabal.sh` vytvoří zip pro claude.ai do `dist/`. Ten se přikládá k GitHub release.
