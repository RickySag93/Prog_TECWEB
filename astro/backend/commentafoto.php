<?php
include "connessione.php";
if($_SERVER['REQUEST_METHOD']==='POST'){
  // se siamo arrivati fino a qui, vuol dire che l'utente è sicuramente loggato
  // e può sicuramente loggare
  session_start();
  $usermail=$_SESSION['usermail'];
  $idft=$_POST['foto'];
  $data=date("Y-m-d H:i:s");
  $commento=$_POST['commento'];
//  echo $commento;
  $commento=htmlentities($commento);
//  $commento=html_entity_decode($commento);
//  echo $commento;
  $commento=strip_tags($commento); // rimuove i tag html
  if($idft==NULL OR strlen($commento)<2 OR strlen($commento)>300) $_SESSION['err_commento']='<p>Il commento deve essere lungo almeno 2 caratteri e massimo 300.</p>';
  else{
    $commento=str_replace("'","\'",$commento); // questo aiuta contro sql injection
    $ins="INSERT INTO commentafoto(astrofilo,idfoto,commento,datainserimento) VALUES ('$usermail','$idft','$commento','$data')";
    if(!$connessione->query($ins)){
      echo $connessione->error;
    }
  }
}
header('Location: ../fotoutente.php?idft='.$idft);
?>
