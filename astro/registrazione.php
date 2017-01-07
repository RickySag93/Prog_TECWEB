<?php
  include "backend/connessione.php";
  echo file_get_contents("parti/registrazione0.html");
  session_start();
  if(isset($_SESSION['usermail'])){ // loggato
    echo file_get_contents("parti/headerloggato.html");
    echo "Non puoi registrarti se sei loggato.";
  }else{
    echo file_get_contents("parti/formlogin.html");
    echo '<div id="breadcrumb">
      <p>Ti trovi in: <span xml:lang="en"><a href="index.php">Home</a></span> &raquo; <strong>Registrati</strong></p>
    </div>';

    if(isset($_SESSION['err'])){
      echo '<p><strong>'.$_SESSION['err'].'</strong></p>';
      session_destroy();
    }

    if($errore_DB==FALSE) echo file_get_contents("parti/mod_registrazione.html");
    else echo '<p>'.$msg_errore_DB.'</p>';

  }
  echo file_get_contents("parti/registrazione1.html");
?>
