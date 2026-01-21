FROM python:3-alpine AS builder

# Build-Argumente
ARG UID=1000
ARG GID=1000

ENV UID=${UID} \
    GID=${GID} \
    PIP_NO_CACHE_DIR=true \
    PIPENV_CACHE_DIR=/dev/null \
    PIPENV_IGNORE_VIRTUALENVS=true \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Pip-Pakete aus requirements.txt installieren
COPY requirements.txt /tmp/requirements.txt
# besser noch wäre:
# COPY Pipfile Pipfile.lock ./

# Systempakete, vgl. https://pipenv.pypa.io/en/latest/installation.html#docker-installation
# git brauchen wir selber und gcc et al sind typische build dependencies
RUN apk --no-cache upgrade && \
    apk add --no-cache git gcc musl-dev libffi-dev && \
    pip install --upgrade pip && \
    pip install --root-user-action=ignore -r /tmp/requirements.txt && \
    rm -rf /tmp/* && \
    apk del gcc musl-dev libffi-dev

#### Stage 2 für kleineres Image:
FROM python:3-alpine

ARG UID=1000
ARG GID=1000

ENV UID=${UID} \
    GID=${GID}

COPY --from=builder /usr/local /usr/local
COPY entrypoint.sh /entrypoint.sh

# Nicht-root User + Gruppe anlegen
RUN addgroup -g ${GID} cheffie && \
    adduser -D -u ${UID} -G cheffie cheffie && \
    chmod +x /entrypoint.sh && ls -la /entrypoint.sh 

# Arbeitsverzeichnis und user
WORKDIR /docs

# Default CMD (hier ist die Angabe optional), kann im Compose überschrieben werden
# das entrypoint script korrigiert Permissions und macht danach den Userwechsel selbst
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
CMD ["hugo", "server", "--port", 8000, "--buildDrafts" ]