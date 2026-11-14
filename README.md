# Oponent — ať AI vyvrátí vlastní závěr (skill pro Claude)

Znáte to: s AI řešíte týden, jestli dává smysl nějaká spolupráce, kampaň nebo investice. Debata se
postupně stáčí k „ano, dává to smysl“. Pak se zeptáte jinak a vyjde, že to vlastně dobrý nápad není.

To není náhoda. AI v dlouhé debatě sklouzává k tomu, co chcete slyšet: drží se toho, co už řekla,
výhrady napíše, ale nepromítne je do závěru, a „to nejde vyloučit“ bere jako důkaz pro. Sama to
nevidí, protože má v kontextu celou debatu.

**Oponent** to obrací. Závěr dostane nezávislý Claude (volitelně i model jiného výrobce) **jen jako
zadání**: bez historie debaty a bez toho, co si přejete. Jeho úkolem je závěr **vyvrátit** z pohledu
zvolených rolí. Hlavní Claude pak ke každé námitce rozhodne, jestli ji přijímá, nebo odmítá a proč,
a upraví závěr.

## Instalace

```bash
npx skills add ondrnovy/oponent-skill
```

Globálně pro všechny projekty: `npx skills add ondrnovy/oponent-skill -g`.

Jako plugin pro Claude Code:

```
/plugin marketplace add ondrnovy/oponent-skill
/plugin install oponent@oponent-skill
```

**claude.ai:** zip ze [Releases](https://github.com/ondrnovy/oponent-skill/releases) nahrajte
v Nastavení → Capabilities → Skills.

## Použití

Stačí říct „pusť na to oponenta“, „advokát ďábla“, „pre-mortem“ nebo „je to fakt dobrý nápad?“.
Claude sepíše zadání, pustí oponenty, ukáže tabulku námitek s verdiktem a upravený závěr.

### Sady rolí

| Sada | Role | Kdy |
|---|---|---|
| `byznys` | skeptický finanční ředitel · druhá strana dohody · zákazník · pre-mortem | partnerství, marketing, investice, produkt |
| `zdravi` | klinický lékař · epidemiolog/statistik | výsledky, rizika, doporučení testů |
| `obecne` | skeptický odborník · pre-mortem | cokoliv jiného |

Vlastní sadu přidáte jako `skills/oponent/role/<sada>.md` se sekcemi `## <role>`.

### Jiný model (volitelné)

Pro druhý názor od jiného výrobce umí skill pustit oponenty přes [Codex CLI](https://github.com/openai/codex)
(funguje i s bezplatným účtem ChatGPT, s limity). Zadání pak odchází do OpenAI, proto ho Claude
anonymizuje a pustí jen se souhlasem.

## Funguje to?

První test proběhl naslepo na reálném rozhodnutí, kde už byl známý výsledek. Odhad, který se
v několikatýdenní debatě s AI vyšplhal na „asi 10 %“, dostali oponenti bez historie. Oba (Codex
i čerstvý Claude) ho nezávisle odmítli **stejným argumentem, jaký pak použil odborník**, a přidali
body, které v debatě chyběly.

Kontrolní pokus ukázal, že rozhoduje hlavně **role oponenta a čistý kontext**. Čerstvý Claude chytil
argument stejně jako jiný model. Jiný výrobce tedy přidá rozmanitost, ale nutný není.

## Co je uvnitř

- `skills/oponent/SKILL.md` — postup: zadání, spuštění, verdikt, zápis
- `skills/oponent/zasady.md` — osm zásad, jak „dotlačení“ k odpovědi předejít už během práce
- `skills/oponent/prompt.md` — šablona pro oponenta
- `skills/oponent/role/` — sady rolí
- `skills/oponent/run.sh` — volitelné spuštění přes Codex CLI

## Licence

MIT
