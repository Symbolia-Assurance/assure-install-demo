"""Team Tasks: the API's database calls (psql-free sketch; the queries are what matter)."""

LIST_TASKS = "SELECT id, title, done FROM tasks ORDER BY created_at"
ADD_TASK = "INSERT INTO tasks (team_id, title) VALUES (current_setting('app.team_id')::bigint, %s) RETURNING id"
COMPLETE_TASK = "UPDATE tasks SET done = true WHERE id = %s"


def set_team(cursor, team_id):
    """Scope the session to one team before any query (row-level security reads it)."""
    cursor.execute("SELECT set_config('app.team_id', %s, false)", (str(int(team_id)),))
