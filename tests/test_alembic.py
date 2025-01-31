from pytest_alembic import create_alembic_fixture, tests

opaldb = create_alembic_fixture({'script_location': 'db_management/opaldb'})
questionnairedb = create_alembic_fixture({'script_location': 'db_management/questionnairedb'})


def test_opaldb_single_head_revision(opaldb):
    tests.test_single_head_revision(opaldb)


def test_opaldb_upgrade(opaldb):
    tests.test_upgrade(opaldb)


def test_opaldb_model_definitions_match_ddl(opaldb):
    # print(opaldb.config)
    # assert False
    tests.test_model_definitions_match_ddl(opaldb)

# def test_opaldb_up_down_consistency(opaldb):
    # tests.test_up_down_consistency(opaldb)

# def test_questionnairedb_single_head_revision(questionnairedb):
#     tests.test_single_head_revision(questionnairedb)

# def test_questionnairedb_upgrade(questionnairedb):
#     tests.test_upgrade(questionnairedb)

# def test_questionnairedb_model_definitions_match_ddl(questionnairedb):
#     tests.test_model_definitions_match_ddl(questionnairedb)

# def test_questionnairedb_up_down_consistency(questionnairedb):
#     tests.test_up_down_consistency(questionnairedb)
