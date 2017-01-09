<?php
    include "connessione.php";
    session_start();
    $pwd_pattern='/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,32}$/'; // minimo 8 caratteri, un numero, un carattere maiuscolo, un carattere minuscolo. Max 32 char
    $regex_pwd=TRUE;
    if(!preg_match($pwd_pattern,$_POST['password'])) $regex_pwd=FALSE;
    $_POST['password']=md5($_POST['password']); // criptiamo la password
    $usermail=$_POST['mail'];
    $pwd=$_POST['password'];
    if($errore_DB==FALSE){
     $check_user_query="SELECT * FROM astrofilo WHERE mail='$usermail' AND password='$pwd'";
     if(!$check_user_result=$connessione->query($check_user_query)){
    //    echo "Errore della query: login ";
          $_SESSION['msg_login']="Abbiamo avuto dei problemi con il database. Risolveremo al più presto.";
     }else{
       if($check_user_result->num_rows==1){
         // qui dovremmo essere protetti da SQL injection visto il forte controllo sulle regex.
         $row_user=mysqli_fetch_array($check_user_result);
         $_SESSION['usermail']=$usermail;
       }else{
         $_SESSION['msg_login']="Login non valido.";

       }
     }
   }
   header('Location: ../login.php');
 ?>
