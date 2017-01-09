<?php
include "connessione.php";
if($_SERVER['REQUEST_METHOD']==='POST'){
  // se siamo arrivati fino a qui, vuol dire che l'utente è sicuramente loggato
  // e può sicuramente loggare
  session_start();
  $usermail=$_SESSION['usermail'];
  $idft=$_POST['foto'];
  $data=date("Y-m-d H:i:s");
    if(isset($_POST['up'])){
      $ins="INSERT INTO giudicafoto(votante,idfoto,voto,datainserimento) VALUES ('$usermail','$idft',1, '$data')";
      if(!$connessione->query($ins)){

      }
    }else if(isset($_POST['down'])){
      $ins="INSERT INTO giudicafoto(votante,idfoto,voto,datainserimento) VALUES ('$usermail','$idft',-1, '$data')";
      if(!$connessione->query($ins)){

      }
    }
    header('Location: ' . $_SERVER['HTTP_REFERER']);
}
?>
