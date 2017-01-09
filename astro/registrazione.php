<?php
  include "backend/connessione.php";
  echo file_get_contents("parti/registrazione0.html");
  session_start();
  if(isset($_SESSION['usermail'])){ // loggato
    echo file_get_contents("parti/headerloggato.html");
    echo "Non puoi registrarti se sei loggato.";
  }else{
    if(isset($_SESSION['msg_login'])){
      echo '<p>'.$_SESSION['msg_login'].'<p>';
      unset($_SESSION['msg_login']);
    }
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
