# Team Tasks

A small task tracker for teams. Each team sees only its own tasks.

- `db/schema.sql`: the tables, the application role and row-level security.
- `app/tasks.py`: the API's database calls.
- `.github/workflows/ci.yml`: starts PostgreSQL 17, loads the schema and runs the tests.
- `.github/workflows/assure.yml`: starts PostgreSQL 17, loads the schema and runs the [Assure](https://github.com/Symbolia-Assurance/assure-action) check against it.

## Run it

```sh
psql "$DATABASE_URL" -f db/schema.sql
python3 -m unittest discover -s app
```
