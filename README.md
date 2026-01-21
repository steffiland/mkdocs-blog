# Static Pages Blog

* in `./.github/` ist eine Pipeline für den Bau in Github Pages
* außerdem geht auch lokal:

## Vorbereitung

```bash
pip install --user pipenv
pipenv install
pipenv shell

# oder Docker 
docker compose up -d
```

## mkdocs Befehle

* ggf. `pipenv run` davor setzen:

```bash
# Testserver, der sich laufend selbst aktualisiert
hugo server -p ${PORT}

# bauen
hugo
```

# Pipeline

die Github Pipeline springt nur an, wenn die commit Message `#deploy` enthält.
