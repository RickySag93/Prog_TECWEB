<?php
include "connessione.php";
if($_SERVER['REQUEST_METHOD']==='POST'){
  // se siamo arrivati fino a qui, vuol dire che l'utente è sicuramente loggato
  // e può sicuramente loggare
  session_start();
  $usermail=$_SESSION['usermail'];
  $idst=$_POST['studio'];
  $data=date("Y-m-d H:i:s");
  if(!$votante_result=$connessione->query("SELECT votante FROM giudicastudio WHERE studio='$idst' AND votante='$usermail'")){

  }else{
    if($votante_result->num_rows>0){
      if(!$del_vot=$connessione->query("DELETE FROM giudicastudio WHERE studio='$idst' AND votante='$usermail'")){
      }else{
      }
    }
    if(isset($_POST['up'])){
      $ins="INSERT INTO giudicastudio(votante,studio,voto,datainserimento) VALUES ('$usermail','$idst',1, '$data')";
      if(!$connessione->query($ins)){
      }
    }else if(isset($_POST['down'])){
      $ins="INSERT INTO giudicastudio(votante,studio,voto,datainserimento) VALUES ('$usermail','$idst',-1, '$data')";
      if(!$connessione->query($ins)){

      }
     }
    }
    header('Location: ../studioutente.php?idst='.$idst);
}
?>
