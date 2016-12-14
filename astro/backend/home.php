<?php
    
    include "connessione.php";
    // SLIDESHOW
    if(!$result=$connessione->query("SELECT *
        FROM foto JOIN fotobyrank ON foto.idfoto=fotobyrank.idfoto
        LIMIT 5")){
			echo "Errore della query: ".$connessione->error.".";
	}else{
		if($result->num_rows>0){
			// while stampa immagini
			$result->free();
		}
	}
	$datetime_now=date("Y-m-d H:i:s");
	// AVVENIMENTI FUTURI: quelli non ancora finiti. Dal piu` prossimo al piu` distante
    if(!$result=$connessione->query("SELECT * FROM avvenimenti WHERE fine>'$datetime_now'ORDER BY inizio LIMIT 5")){
			echo "Errore della query: ".$connessione->error.".";
	}else{
		if($result->num_rows>0){
			while($row=$result->fetch_array(MYSQLI_ASSOC)){
				echo $row['tipo']." ".$row['inizio']." // ";
			}
			$result->free();
		}
	}
	// AVVENIMENTI PASSATI: quelli finiti. Dal piu` recente al meno recente.
	if(!$result=$connessione->query("SELECT * FROM avvenimenti WHERE fine<'$datetime_now'ORDER BY fine DESC LIMIT 5")){
			echo "Errore della query: ".$connessione->error.".";
	}else{
		if($result->num_rows>0){
			while($row=$result->fetch_array(MYSQLI_ASSOC)){
				echo $row['tipo']." ".$row['inizio']." // ";
			}
			$result->free();
		}
	}
    
?>
