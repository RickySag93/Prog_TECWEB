<?php

    include "backend/connessione.php";
    // SLIDESHOW
    //echo file_get_contents("index0.html");
    echo file_get_contents("parti/index0.html");
    session_start();
    if(!isset($_SESSION['usermail'])) echo file_get_contents("parti/formlogin.html");
    else echo file_get_contents("parti/logout.html");
    echo file_get_contents("parti/slideshow.html");
    $imm_query="SELECT *  FROM foto JOIN fotobyrank ON foto.idfoto=fotobyrank.idfoto LIMIT 5";
    if(!$result=$connessione->query($imm_query)){
			echo "Errore della query: ".$connessione->error.".";
	}else{
		if($result->num_rows>0){
			// while stampa immagini
      while($row=$result->fetch_array(MYSQLI_ASSOC)){
        echo '<img src="'.$row['immagine'].'" class="imgslide" alt="" />';
        //echo "<p>".$row['idfoto']."</p>";

        /* $row['immagine']=pack('H*',$row['immagine']);
         $im=imagecreatefromstring($row['immagine']);
         imagejpeg($im);*/
         //echo $row['immagine'];
      //  imagedestroy($img);
      }
			$result->free();
		}
	}

	$datetime_now=date("Y-m-d H:i:s");
  // AVVENIMENTI PASSATI: quelli finiti. Dal piu` recente al meno recente.
  echo file_get_contents("parti/index1.html");
  if(!$result=$connessione->query("SELECT * FROM avvenimenti WHERE fine<'$datetime_now' ORDER BY fine DESC LIMIT 5")){
      echo "Errore della query: ".$connessione->error.".";
  }else{
    if($result->num_rows>0){
      while($row=$result->fetch_array(MYSQLI_ASSOC)){
        echo "<p>".$row['tipo'].", in data ".$row['inizio']."</p>";
      }
      $result->free();
    }
  }

  echo file_get_contents("parti/index2.html");
  // AVVENIMENTI FUTURI: quelli non ancora finiti. Dal piu` prossimo al piu` distante
  if(!$result=$connessione->query("SELECT * FROM avvenimenti WHERE fine>'$datetime_now'ORDER BY inizio LIMIT 5")){
			echo "Errore della query: ".$connessione->error.".";
	}else{
		if($result->num_rows>0){
			while($row=$result->fetch_array(MYSQLI_ASSOC)){
				echo "<p>".$row['tipo'].", in data ".$row['inizio']."</p>";
			}
			$result->free();
		}
	}
  echo file_get_contents("parti/index3.html");

?>
