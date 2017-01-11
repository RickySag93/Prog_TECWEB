<?php
  include "backend/connessione.php";
  echo file_get_contents("parti/login0.html");
  session_start();
  if(!isset($_SESSION['usermail'])) echo file_get_contents("parti/headernonloggato.html");
  else echo file_get_contents("parti/headerloggato.html");
  if(isset($_SESSION['msg_login'])){
    echo '<p>'.$_SESSION['msg_login'].'<p>';
    unset($_SESSION['msg_login']);
  }

 echo ' <div id="breadcrumb">
      <p>Ti trovi in: <span xml:lang="en"><a href="index.php">Home</a></span> &raquo; <strong>Login</strong></p>
   </div>';
  if($errore_DB==FALSE){
   if(!isset($_SESSION['usermail'])){
     if(isset($_SESSION['err'])){
       echo $_SESSION['err'];
       unset($_SESSION['err']);
     }
     echo file_get_contents("parti/formlogin.html");
   }else echo '<p>Non puoi effettura il login se sei già loggato.</p>';
 }else echo '<p>'.$msg_errore_DB.'</p>';
   echo file_get_contents("parti/login1.html");
