<?php

    echo file_get_contents("parti/about0.html");
    session_start();
    if(!isset($_SESSION['usermail'])) echo file_get_contents("parti/headernonloggato.html");
    else echo file_get_contents("parti/headerloggato.html");
    echo file_get_contents("parti/about1.html");
