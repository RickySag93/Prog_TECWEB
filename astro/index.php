<?php

    include "backend/connessione.php";
    // SLIDESHOW
    //echo file_get_contents("index0.html");
    echo file_get_contents("parti/index0.html");
    session_start();
    if(!isset($_SESSION['usermail'])) echo file_get_contents("parti/headernonloggato.html");
    else echo file_get_contents("parti/headerloggato.html");
    if(isset($_SESSION['msg_login'])){
      echo '<p>'.$_SESSION['msg_login'].'<p>';
      unset($_SESSION['msg_login']);
    }
    echo file_get_contents("parti/slideshow.html");

  if($errore_DB==FALSE){
    $imm_query="SELECT *  FROM foto JOIN fotobyrank ON foto.idfoto=fotobyrank.idfoto LIMIT 3";
    if(!$result=$connessione->query($imm_query)){
      echo '<p>Abbiamo riscontrato dei problemi nel visualizzare le foto.</p>';
			//echo "Errore della query: ".$connessione->error.".";
	  }else if(!$connessione->connect_errno){
		 if($result->num_rows>0){
			// while stampa immagini
      while($row=$result->fetch_array(MYSQLI_ASSOC)){
        echo '<img src="'.$row['immagine'].'" class="imgslide" alt="'.$row['didascalia'].'" />';
        echo '<div class="slide_didasc"> <p class="p_slide">'.$row['didascalia'].'</p></div>';
      }
			$result->free();
		}
	}
}else echo '<p>'.$msg_errore_DB.'</p>';

	$datetime_now=date("Y-m-d H:i:s");
  // AVVENIMENTI PASSATI: quelli finiti. Dal piu` recente al meno recente.
  echo file_get_contents("parti/index1.html");
if($errore_DB==FALSE){
  if(!$result=$connessione->query("SELECT * FROM avvenimenti WHERE fine<'$datetime_now' ORDER BY fine DESC LIMIT 5")){
       echo '<p>Abbiamo riscontrato dei problemi nel visualizzare gli eventi passati.</p>';
      //echo "Errore della query: ".$connessione->error.".";
  }else{
    if($result->num_rows>0){
      while($row=$result->fetch_array(MYSQLI_ASSOC)){
        echo "<p>".$row['tipo'].", in data ".$row['inizio']."</p>";
      }
      $result->free();
    }
  }
}else echo '<p>'.$msg_errore_DB.'</p>';
  echo file_get_contents("parti/index2.html");
  // AVVENIMENTI FUTURI: quelli non ancora finiti. Dal piu` prossimo al piu` distante
if($errore_DB==FALSE){
  if(!$result=$connessione->query("SELECT * FROM avvenimenti WHERE fine>'$datetime_now'ORDER BY inizio LIMIT 5")){
      echo '<p>Abbiamo riscontrato dei problemi nel visualizzare gli eventi futuri.</p>';
      //echo "Errore della query: ".$connessione->error.".";
	}else{
		if($result->num_rows>0){
			while($row=$result->fetch_array(MYSQLI_ASSOC)){
				echo "<p>".$row['tipo'].", in data ".$row['inizio']."</p>";
			}
			$result->free();
		}
	}
}else echo '<p>'.$msg_errore_DB.'</p>';
  echo file_get_contents("parti/index3.html");

?>
