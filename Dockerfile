FROM python:3.12-slim-bookworm as base

# Setup env
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

ENV PIP_NO_CACHE_DIR off
ENV PIP_DISABLE_PIP_VERSION_CHECK on
ENV PIP_DEFAULT_TIMEOUT 100
ENV POETRY_VIRTUALENVS_IN_PROJECT 1
ENV POETRY_NO_INTERACTION 1
ENV POETRY_HOME="/opt/poetry"
ENV VENV_PATH="/.venv"
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"


RUN apt-get update &&\
    apt-get install --no-install-recommends -y curl &&\
    curl https://www.postgresql.org/media/keys/ACCC4CF8.asc &&\
    echo "deb https://apt.postgresql.org/pub/repos/apt/ bookworm-pgdg main" \
      > /etc/apt/sources.list.d/postgresql.list &&\
    apt-get install --no-install-recommends -y build-essential gettext &&\
    groupadd -f -g 1002 app &&\
    useradd -l -u 1002 -g app -d /app -r -m app &&\
    chown -R app:app /app &&\
    curl -sSL https://install.python-poetry.org | python - &&\
    pip install --upgrade pip python-semantic-release


USER app
WORKDIR /app
