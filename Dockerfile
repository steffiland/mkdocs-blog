FROM python:3.12-alpine

# Build-Argumente
ARG UID=1000
ARG GID=1000

ENV UID=${UID}
ENV GID=${GID}

# Systempakete
RUN apk update && apk upgrade && \
    apk add --no-cache \
      build-base \
      libffi-dev \
      musl-dev \
      git \
      shadow

# Nicht-root User + Gruppe
RUN addgroup -g ${GID} mkdocs && \
    adduser -D -u ${UID} -G mkdocs mkdocs

# Pip-Pakete aus requirements.txt installieren
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Arbeitsverzeichnis
WORKDIR /docs
USER mkdocs

# Default CMD, kann im Compose überschrieben werden
CMD ["/entrypoint.sh"]
