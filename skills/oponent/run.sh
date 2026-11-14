#!/bin/bash
# Oponent jiným modelem přes Codex CLI (volitelné). Výchozí oponent jsou subagenti Claude.
# Usage: run.sh <zadani.md> <vystupni_slozka>
# Env: OPONENT_SADA (výchozí "obecne"), OPONENT_ROLES (výchozí všechny role sady), OPONENT_MODEL (volitelné)
set -u

zadani="$1"
outdir="$2"
dir="$(cd "$(dirname "$0")" && pwd)"
sada="${OPONENT_SADA:-obecne}"
role_file="$dir/role/$sada.md"

[ -s "$zadani" ] || { echo "Zadání chybí nebo je prázdné: $zadani" >&2; exit 2; }
[ -s "$role_file" ] || { echo "Sada rolí neexistuje: $role_file" >&2; exit 2; }
command -v codex >/dev/null || { echo "codex není nainstalovaný" >&2; exit 3; }
mkdir -p "$outdir"

roles="${OPONENT_ROLES:-$(sed -n 's/^## //p' "$role_file")}"

model_args=()
[ -n "${OPONENT_MODEL:-}" ] && model_args=(-m "$OPONENT_MODEL")

pids=()
for role in $roles; do
  prompt_file="$outdir/prompt_$role.md"
  python3 -I - "$dir/prompt.md" "$role_file" "$zadani" "$role" > "$prompt_file" <<'EOF'
import re, sys
tpl, roles, zadani, role = sys.argv[1:5]
m = re.search(r"^## " + re.escape(role) + r"\n+(.+?)(?=\n## |\Z)", open(roles).read(), re.S | re.M)
if not m:
    sys.exit(f"Role {role} v sadě není")
print(open(tpl).read().replace("{{ZADANI}}", open(zadani).read()).replace("{{ROLE}}", m.group(1).strip()))
EOF
  [ -s "$prompt_file" ] || { echo "FAIL  $role (role v sadě $sada není)"; continue; }
  codex exec --skip-git-repo-check --ephemeral --sandbox read-only -C "$outdir" \
    ${model_args[@]+"${model_args[@]}"} -o "$outdir/$role.md" - < "$prompt_file" \
    > "$outdir/$role.log" 2>&1 &
  pids+=("$!:$role")
done

status=0
for p in ${pids[@]+"${pids[@]}"}; do
  pid="${p%%:*}"; role="${p#*:}"
  if wait "$pid" && [ -s "$outdir/$role.md" ]; then
    echo "OK    $role -> $outdir/$role.md"
  else
    echo "FAIL  $role (viz $outdir/$role.log)"; tail -3 "$outdir/$role.log"
    status=1
  fi
done
[ ${#pids[@]} -gt 0 ] || status=1
exit $status
