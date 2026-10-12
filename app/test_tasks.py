import unittest

import tasks


class Queries(unittest.TestCase):
    def test_add_task_takes_the_team_from_the_session(self):
        self.assertIn("current_setting('app.team_id')", tasks.ADD_TASK)

    def test_list_tasks_has_no_team_filter_of_its_own(self):
        # row-level security scopes the rows; the query stays simple
        self.assertNotIn("team_id", tasks.LIST_TASKS)


if __name__ == "__main__":
    unittest.main()
