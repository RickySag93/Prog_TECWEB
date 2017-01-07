<?php

    include "backend/connessione.php";
    // SLIDESHOW
    //echo file_get_contents("index0.html");
    echo file_get_contents("parti/eventi0.html");
    session_start();
    if(!isset($_SESSION['usermail'])) echo file_get_contents("parti/headernonloggato.html");
    else echo file_get_contents("parti/headerloggato.html");
    if(isset($_SESSION['msg_login'])){
      echo '<p>'.$_SESSION['msg_login'].'<p>';
      unset($_SESSION['msg_login']);
    }

	$datetime_now=date("Y-m-d H:i:s");
  // AVVENIMENTI PASSATI: quelli finiti. Dal piu` recente al meno recente.
  echo file_get_contents("parti/eventi1.html");
  if($errore_DB==FALSE){
   if(!$result=$connessione->query("SELECT * FROM avvenimenti WHERE fine<'$datetime_now' ORDER BY fine DESC LIMIT 5")){
     //echo "<p>Errore della query: ".$connessione->error.".</p>";
     echo '<p>Abbiamo riscontrato dei problemi nel visualizzare gli eventi passati.</p>';
   }else{
    if($result->num_rows>0){
      while($row=$result->fetch_array(MYSQLI_ASSOC)){
        echo "<p>".$row['tipo'].", in data ".$row['inizio']."</p>";
      }
      $result->free();
     }
   }
 }else echo '<p>'.$msg_errore_DB.'</p>';
  echo file_get_contents("parti/eventi2.html");
  // AVVENIMENTI FUTURI: quelli non ancora finiti. Dal piu` prossimo al piu` distante
 if($errore_DB==FALSE){
  if(!$result=$connessione->query("SELECT * FROM avvenimenti WHERE fine>'$datetime_now'ORDER BY inizio LIMIT 5")){
    echo '<p>Abbiamo riscontrato dei problemi nel visualizzare gli eventi futuri.</p>';
    //	echo "Errore della query: ".$connessione->error.".";
	}else{
		if($result->num_rows>0){
			while($row=$result->fetch_array(MYSQLI_ASSOC)){
				echo "<p>".$row['tipo'].", in data ".$row['inizio']."</p>";
			}
			$result->free();
		}
	}
}else echo '<p>'.$msg_errore_DB.'</p>';
  echo file_get_contents("parti/eventi3.html");

?>
