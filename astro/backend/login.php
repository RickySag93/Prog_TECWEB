<?php
    include "connessione.php";
    session_start();

    $_POST['password']=md5($_POST['password']); // criptiamo la password
    $usermail=$_POST['mail'];
    $pwd=$_POST['password'];

    $check_user_query="SELECT * FROM astrofilo WHERE mail='$usermail' AND password='$pwd'";
    if(!$check_user_result=$connessione->query($check_user_query)){
        echo "Errore della query: ".$connessione->error.".";
    }else{
      if($check_user_result->num_rows==1){
        $row_user=mysqli_fetch_array($check_user_result);
        $_SESSION['usermail']=$usermail;
      }else echo "Problema";
      header('Location: ' . $_SERVER['HTTP_REFERER']);
    }

 ?>
