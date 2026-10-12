-- Team Tasks schema. Loaded by CI into a fresh PostgreSQL 17 server.
CREATE ROLE app_user LOGIN PASSWORD 'app-user-local-only' NOSUPERUSER NOCREATEDB NOCREATEROLE;

CREATE TABLE teams (
    id   bigserial PRIMARY KEY,
    name text NOT NULL UNIQUE
);

CREATE TABLE tasks (
    id         bigserial PRIMARY KEY,
    team_id    bigint NOT NULL REFERENCES teams(id),
    title      text NOT NULL,
    done       boolean NOT NULL DEFAULT false,
    created_at timestamptz NOT NULL DEFAULT now()
);

-- Each team sees only its own tasks: the API sets app.team_id per request.
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
CREATE POLICY team_isolation ON tasks
    USING (team_id = current_setting('app.team_id')::bigint);

GRANT SELECT ON teams TO app_user;
GRANT SELECT, INSERT, UPDATE ON tasks TO app_user;
GRANT USAGE ON SEQUENCE tasks_id_seq TO app_user;
