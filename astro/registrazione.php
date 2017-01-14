<?php
  include "backend/connessione.php";
  echo file_get_contents("parti/registrazione0.html");
  session_start();
  if(isset($_SESSION['usermail'])) echo file_get_contents("parti/headerloggato.html");
  else echo file_get_contents("parti/headernonloggato.html");

    echo '<div id="breadcrumb">
      <p>Ti trovi in: <span xml:lang="en"><a href="index.php">Home</a></span> &raquo; <strong>Registrati</strong></p>
    </div>';

    if(isset($_SESSION['err'])){
      echo '<p><strong>'.$_SESSION['err'].'</strong></p>';
      session_destroy();
    }

  if($errore_DB==FALSE){
    if(!isset($_SESSION['usermail'])) echo file_get_contents("parti/mod_registrazione.html");
    else echo '<p><strong>Non puoi registrarti se hai già effettuato l\'accesso. </strong><a href="backend/logout.php">Disconnettiti</a></p>';
  }else echo $msg_errore_DB;
  echo file_get_contents("parti/registrazione1.html");
?>
