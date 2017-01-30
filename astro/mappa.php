<?php
  include "backend/connessione.php";
  echo file_get_contents("parti/mappa0.html");
  session_start();
  if(!isset($_SESSION['usermail'])) echo file_get_contents("parti/headernonloggato.html");
  else echo file_get_contents("parti/headerloggato.html");
  if(isset($_SESSION['msg_login'])){
    echo '<p>'.$_SESSION['msg_login'].'<p>';
    unset($_SESSION['msg_login']);
  }

     echo file_get_contents("parti/mappa1.html");
