<?php

    include "backend/connessione.php";
    // SLIDESHOW
    //echo file_get_contents("index0.html");
    echo file_get_contents("parti/index0.html");
    session_start();
    if(!isset($_SESSION['usermail'])) echo file_get_contents("parti/headernonloggato.html");
    else echo file_get_contents("parti/headerloggato.html");
    if(isset($_SESSION['msg_login'])){
      echo '<p>'.$_SESSION['msg_login'].'<p>';
      unset($_SESSION['msg_login']);
    }

echo '<h2>La pagina che cerchi non è stata trovata!</h2>
    <p>
        Ritorna alla <a href="index.php">Home</a> oppure guarda la nostra <a href="mappa.html">Mappa del sito.</a>
    </p>';


  echo file_get_contents("parti/index3.html");

?>
