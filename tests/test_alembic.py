from pytest_alembic import create_alembic_fixture, tests

# Manually create fixtures for the DBs
# See: https://github.com/schireson/pytest-alembic/issues/98
opaldb = create_alembic_fixture({'script_location': 'db_management/opaldb'})
questionnairedb = create_alembic_fixture({'script_location': 'db_management/questionnairedb'})
ormsdb = create_alembic_fixture({'script_location': 'db_management/ormsdb'})
ormslogdb = create_alembic_fixture({'script_location': 'db_management/ormslogdb'})


# QuestionnaireDB needs to be tested first due to the foreign key constraint from OpalDB to QuestionnaireDB
def test_questionnairedb_single_head_revision(questionnairedb):
    tests.test_single_head_revision(questionnairedb)


def test_questionnairedb_upgrade(questionnairedb):
    tests.test_upgrade(questionnairedb)


def test_questionnairedb_model_definitions_match_ddl(questionnairedb):
    tests.test_model_definitions_match_ddl(questionnairedb)


def test_questionnairedb_up_down_consistency(questionnairedb):
    tests.test_up_down_consistency(questionnairedb)


def test_opaldb_single_head_revision(opaldb):
    tests.test_single_head_revision(opaldb)


def test_opaldb_upgrade(opaldb):
    tests.test_upgrade(opaldb)


def test_opaldb_model_definitions_match_ddl(opaldb):
    tests.test_model_definitions_match_ddl(opaldb)


# don't test OpalDB downgrade as it fails revision 7a189846a0f5
# since it adds an index requiring PatientDeviceIdentifier.PatientSerNum


def test_ormsdb_single_head_revision(ormsdb):
    tests.test_single_head_revision(ormsdb)


def test_ormsdb_upgrade(ormsdb):
    tests.test_upgrade(ormsdb)


def test_ormsdb_model_definitions_match_ddl(ormsdb):
    tests.test_model_definitions_match_ddl(ormsdb)


def test_ormsdb_up_down_consistency(ormsdb):
    tests.test_up_down_consistency(ormsdb)


def test_ormslogdb_single_head_revision(ormslogdb):
    tests.test_single_head_revision(ormslogdb)


def test_ormslogdb_upgrade(ormslogdb):
    tests.test_upgrade(ormslogdb)


def test_ormslogdb_model_definitions_match_ddl(ormslogdb):
    tests.test_model_definitions_match_ddl(ormslogdb)


def test_ormslogdb_up_down_consistency(ormslogdb):
    tests.test_up_down_consistency(ormslogdb)
