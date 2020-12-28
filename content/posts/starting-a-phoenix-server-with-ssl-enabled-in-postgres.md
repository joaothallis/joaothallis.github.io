+++
title = "Starting a Phoenix server with SSL enabled in Postgres"
date = 2020-12-27
+++

Clone a Phoenix project with Elixir releases configured and SSL enabled:

```bash
git clone https://github.com/by-team/by.git && cd by
```

Start Postgres:

```bash
cd

mkdir postgres

docker run -d \
--name postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 \
-v $PWD/postgres:/var/lib/postgresql/data \
-v $PWD/server.crt:/var/lib/postgresql/server.crt \
-v $PWD/server.key:/var/lib/postgresql/server.key \
postgres:9-alpine \
-c ssl=on \
-c ssl_cert_file=/var/lib/postgresql/server.crt \
-c ssl_key_file=/var/lib/postgresql/server.key
```

Set `DATABASE_URL`:

```bash
export DATABASE_URL=postgres://postgres:postgres@localhost:5432/by_prod
```

Assembles the release:

```bash
cd -
mix deps.get --only prod
export MIX_ENV=prod
export SECRET_KEY_BASE=$(mix phx.gen.secret)
mix release
```

Create database:

```bash
_build/prod/rel/by/bin/by eval "Ecto.Adapters.Postgres.storage_up(username: \"postgres\", database: \"by_prod\", hostname: \"localhost\")"
```

Run migrations:

```bash
_build/prod/rel/by/bin/by eval "BY.Release.migrate"
```

Start server:

```bash
_build/prod/rel/by/bin/by start
```
