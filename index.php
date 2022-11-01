<!-- Landing page shown when opening the dbv-apps container in a browser -->
<html>
<body>

<h1>DBV Dashboards</h1>

<p><a href="http://localhost:<?php echo getenv("PHP_PORT") ?>/dbv/dbv_opaldb/">Opal DB</a></p>
<p><a href="http://localhost:<?php echo getenv("PHP_PORT") ?>/dbv/dbv_questionnairedb/">Questionnaire DB</a></p>
<p><a href="http://localhost:<?php echo getenv("PHP_PORT") ?>/dbv/dbv_registerdb/">Register DB</a></p>
<p><a href="http://localhost:<?php echo getenv("PHP_PORT") ?>/dbv/dbv_opalreportdb/">Opal Report DB</a></p>

</body>
</html>
