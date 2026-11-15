.RECIPEPREFIX := >

VAULT := $(CURDIR)
DIA := $(shell date +%F)

.PHONY: dia nota llp-check abrir sync doctor clone

dia:
> @mkdir -p "09 - Diario de Aprendizaje"
> @if [ ! -f "09 - Diario de Aprendizaje/$(DIA).md" ]; then \
>   printf '# Diario $(DIA)\n\n## Aprendí hoy\n\n- \n\n## Reforcé\n\n- \n\n## Dudas abiertas\n\n- \n\n## Siguiente paso\n\n- \n\n## Refs\n\n- \n' > "09 - Diario de Aprendizaje/$(DIA).md"; \
> fi
> @echo "Nota del día: 09 - Diario de Aprendizaje/$(DIA).md"

nota:
> @test -n "$(AREA)" || (echo "uso: make nota AREA=01 TITULO='Titulo de la nota'"; exit 1)
> @test -d "$(AREA) - "* || (echo "no existe el área $(AREA)"; exit 1)
> @n=$$(ls "$(AREA) - "*/ | grep -v MOC | sed -E 's/.*([0-9]+)\.[0-9]+ -.*/\1/' | sort -n | tail -1); n=$$(( $${n:-0} + 1 )); \
>  dir=$$(ls -d "$(AREA) - "*); \
>  printf '# %s\n\n> @ref LLP 0000 — sesión de %s\n\n## Qué era la meta\n\n## Qué hice\n\n## Qué aprendí\n\n## Dudas\n' "$(TITULO)" "$$(date +%F)" > "$$dir/$(AREA).$$n - $(TITULO).md"; \
>  echo "creada: $$dir/$(AREA).$$n - $(TITULO).md"

llp-check:
> @bash tools/llp-check.sh

doctor:
> @bash tools/doctor.sh

clone:
> @bash tools/clone.sh

abrir:
> @xdg-open "obsidian://open?path=$(VAULT)" || open "obsidian://open?path=$(VAULT)"

sync:
> @git add -A
> @git commit -m "$(MSG)" || echo "nada que commitear"
> @git push
