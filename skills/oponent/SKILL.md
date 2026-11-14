---
name: oponent
description: >-
  Oponentura závěru nebo rozhodnutí: nezávislý Claude (volitelně i jiný model) dostane jen zadání,
  bez historie debaty a bez toho, co chce uživatel slyšet, a má ho vyvrátit z pohledu zvolených rolí.
  Pak verdikt ke každé námitce a upravený závěr. Proti tomu, že dlouhá debata s AI postupně „dotlačí“
  k odpovědi, kterou chce tazatel slyšet. Použij před rozhodnutím s dopadem (partnerství, investice,
  marketing, nábor, číslo rizika, doporučení testu, výklad nálezu) a na „oponent“, „oponentura“,
  „advokát ďábla“, „druhý názor“, „ať to někdo vyvrátí“, „pre-mortem“, „je to fakt dobrý nápad?“.
---

# Oponent

## Proč

AI v dlouhé debatě sklouzává k tomu, co chce tazatel slyšet. Drží se toho, co už řekla, výhrady
napíše, ale nepromítne je do závěru, a protiargument typu „to nejde vyloučit“ bere jako důkaz pro.
Sama to nevidí, protože má v kontextu celou debatu.

Oponent dostane **jen zadání**: bez historie, bez přání uživatele. Jeho úkolem je závěr **vyvrátit**.
Z testů: hlavní přínos je **role oponenta a čistý kontext**. Jiný model (jiného výrobce) přidá
rozmanitost, ale nutný není. Zásady, jak chybě předcházet už během práce: `zasady.md`.

## Kdy

**Ano:** rozhodnutí s dopadem nebo penězi (partnerství, spolupráce, investice, nákup, nábor,
marketingová kampaň, změna produktu) · číslo rizika nebo pravděpodobnosti · doporučení testu, léčby,
zákroku · výklad nálezu · podklad, který půjde dál (vedení, lékař, partner) · téma, ke kterému se
s AI vracíte dny nebo týdny.
**Ne:** shrnutí, logistika, přepis, drobnosti.

## Sady rolí

Vyber sadu podle tématu (`role/<sada>.md`). Role jde i kombinovat nebo dopsat vlastní.

| Sada | Role | Kdy |
|---|---|---|
| `byznys` | `financni`, `protistrana`, `zakaznik`, `premortem` | partnerství, marketing, investice, produkt |
| `zdravi` | `lekar`, `statistik` | výsledky, rizika, doporučení testů a léčby |
| `obecne` | `skeptik`, `premortem` | cokoliv jiného |

Stačí 2 role, u velkých rozhodnutí 3–4.

## 1. Zadání

Napiš ho do souboru (Claude Code: dočasná složka) nebo do textu (claude.ai):

```markdown
# Závěr / rozhodnutí
<1–3 věty, přesně co tvrdím nebo navrhuji, včetně čísel>
# Z čeho vychází
<data a argumenty, zdroje>
# Předpoklady
<každý zvlášť, výslovně>
# Kritéria
<podle čeho se rozhoduje; co by rozhodnutí zabilo — ideálně sepsané PŘED debatou>
# Co by závěr vyvrátilo
<vlastní nejslabší místa>
```

- **Nepiš, co si uživatel přeje** ani jak dlouho se o tom mluví.
- Jen to, co je k závěru potřeba. **Anonymizuj** osobní údaje (jména, kontakty, rodná čísla, zdravotní
  údaje konkrétních lidí). U firemních dat respektuj pravidla firmy, hlavně když zadání půjde k jinému
  výrobci AI.

## 2. Spuštění

Šablona promptu: `SKILL_DIR/prompt.md` (`{{ROLE}}`, `{{ZADANI}}`). Text role: `SKILL_DIR/role/<sada>.md`,
sekce `## <role>`.

### Claude Code

1. **Vždy: čerství subagenti Claude**, jeden na roli, paralelně (nástroj na agenty, obecný typ).
   Do promptu dej **jen** vyplněnou šablonu. Žádnou historii, žádné shrnutí debaty, žádné „uživatel chce“.
2. **Volitelně jiný model** přes Codex CLI (`codex`), když je nainstalovaný a přihlášený a uživatel
   souhlasí, že zadání půjde do OpenAI:
   ```bash
   OPONENT_SADA=byznys OPONENT_ROLES="financni premortem" SKILL_DIR/run.sh <zadani.md> <vystupni_slozka>
   ```
   Pusť na pozadí, trvá minuty. `OPONENT_MODEL` volitelně. Když selže (přihlášení, kvóta), řekni to
   a pokračuj se subagenty. Neselhávej potichu.

### claude.ai

Subagenty tu nemáš:
1. Vyplň šablonu pro první roli a dej ji uživateli jako jeden blok ke zkopírování.
2. Ať ji vloží do **nového chatu** (bez projektu a bez paměti), případně i do jiné AI, a výsledek vloží
   zpátky. Totéž pro další role.
3. Když to dělat nechce: udělej oponenturu sám v samostatné části odpovědi a **napiš, že je slabší**
   (máš v kontextu celou debatu).

## 3. Verdikt

Ke **každé** námitce:

| Námitka | Kdo | Přijímám / odmítám | Proč | Co měním |
|---|---|---|---|---|

- Oponenti jsou nastavení tvrdě, ne každá námitka platí. Odmítnutí ale musí mít důvod, ne „nesouhlasím“.
- Shoda oponentů není důkaz.
- Pak uprav závěr a napiš, **jak se změnil** (původně → nově). Když se nezměnil, řekni proč.

## 4. Zápis

Kde se v projektu vedou rozhodnutí nebo analýzy, přidej sekci `## Oponentura (<datum>, <modely>)`
s tabulkou a změnou závěru. Surové výstupy oponentů neukládej.

Když se později ukáže, jak to dopadlo, doplň do sekce, kdo měl pravdu. Z toho se časem pozná,
jestli oponent pomáhá a v čem.
