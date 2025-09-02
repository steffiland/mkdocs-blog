# MKDOcs Static Pages Blog

* in `./.github/` ist eine Pipeline für den Bau in Github Pages
* außerdem geht auch lokal:

## Vorbereitung

```bash
pip install --user pipenv
pipenv install -r requirements.txt
pipenv shell

# oder Docker 
docker compose up -d
```

## mkdocs Befehle

* ggf. `pipenv run` davor setzen:

```bash
# Testserver, der sich laufend selbst aktualisiert
mkdocs serve -a 0.0.0.0:8000

# bauen
mkdocs build
```