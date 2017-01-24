<?php
include "connessione.php";
if($_SERVER['REQUEST_METHOD']==='POST'){
  // se siamo arrivati fino a qui, vuol dire che l'utente è sicuramente loggato
  // e può sicuramente loggare
  session_start();
  $usermail=$_SESSION['usermail'];
  $idst=$_POST['studio'];
  $data=date("Y-m-d H:i:s");
  $commento=$_POST['commento'];
//  echo $commento;
//  $commento=htmlentities($commento);
//  $commento=html_entity_decode($commento);
//  echo $commento;
  if(strlen($commento)<2 OR strlen($commento)>300) $_SESSION['err_commento']='<p>Il commento deve essere lungo almeno 2 caratteri e massimo 300.</p>';
  else{
    $commento=str_replace("'","\'",$commento); // questo aiuta contro sql injection
    $ins="INSERT INTO commentastudio(astrofilo,commento,studio,datainserimento) VALUES ('$usermail','$commento','$idst','$data')";
    if(!$connessione->query($ins)){
      echo $connessione->error;
    }
  }
}
  header('Location: ../studioutente.php?idst='.$idst);
?>
