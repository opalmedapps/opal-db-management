#!/bin/bash
set -euo pipefail

MYSQL_PWD=$MARIADB_ROOT_PASSWORD mysql -uroot -hlocalhost << EOF
GRANT ALL PRIVILEGES ON \`OpalDB\`.* TO \`$MARIADB_USER\`@\`%\`;
GRANT ALL PRIVILEGES ON \`test_OpalDB\`.* TO \`$MARIADB_USER\`@\`%\`;
GRANT ALL PRIVILEGES ON \`QuestionnaireDB\`.* TO \`$MARIADB_USER\`@\`%\`;
GRANT ALL PRIVILEGES ON \`test_QuestionnaireDB\`.* TO \`$MARIADB_USER\`@\`%\`;
GRANT ALL PRIVILEGES ON \`OrmsDatabase\`.* TO \`$MARIADB_USER\`@\`%\`;
GRANT ALL PRIVILEGES ON \`OrmsLog\`.* TO \`$MARIADB_USER\`@\`%\`;
EOF
