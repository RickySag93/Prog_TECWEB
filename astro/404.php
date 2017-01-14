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




  echo file_get_contents("parti/index3.html");

?>
