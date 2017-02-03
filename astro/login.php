<?php
  include "backend/connessione.php";
  echo file_get_contents("parti/login0.html");
  session_start();
 echo ' <div id="breadcrumb">
      <p>Ti trovi in: <span xml:lang="en"><a href="index.php">Home</a></span> &raquo; <strong>Login</strong></p>
   </div>';
   if(isset($_SESSION['msg_login'])){
     echo '<p><strong>'.$_SESSION['msg_login'].'</strong></p>';
     unset($_SESSION['msg_login']);
   }

  if($errore_DB==FALSE){
   if(!isset($_SESSION['usermail'])){
     if(isset($_SESSION['err'])){
       echo $_SESSION['err'];
       unset($_SESSION['err']);
     }
     echo file_get_contents("parti/formlogin.html");
   }else echo '<p><strong>Non puoi effettuare il <span xml:lang="en"> login </span> se hai già effettuato l\'accesso. </strong><a href="backend/logout.php">Disconnettiti</a></p>';
 }else echo $msg_errore_DB;
   echo file_get_contents("parti/login1.html");
