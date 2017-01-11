<?php
include "connessione.php";
if($_SERVER['REQUEST_METHOD']==='POST'){
  // se siamo arrivati fino a qui, vuol dire che l'utente è sicuramente loggato
  // e può sicuramente loggare
  session_start();
  $usermail=$_SESSION['usermail'];
  $idft=$_POST['foto'];
  $data=date("Y-m-d H:i:s");

  if(!$votante_result=$connessione->query("SELECT votante FROM giudicafoto WHERE idfoto='$idft' AND votante='$usermail'")){
    echo $connessione->error;
  }else{
    if($votante_result->num_rows>0){
      if(!$del_vot=$connessione->query("DELETE FROM giudicafoto WHERE idfoto='$idft' AND votante='$usermail'")){
      }else{
      }
    }
    if(isset($_POST['up'])){
      $ins="INSERT INTO giudicafoto(votante,idfoto,voto,datainserimento) VALUES ('$usermail','$idft',1, '$data')";
      if(!$connessione->query($ins)){

      }
    }else if(isset($_POST['down'])){
      $ins="INSERT INTO giudicafoto(votante,idfoto,voto,datainserimento) VALUES ('$usermail','$idft',-1, '$data')";
      if(!$connessione->query($ins)){

      }
    }
  }
    header('Location: ' . $_SERVER['HTTP_REFERER']);
}
?>
