<?php
     include "connessione.php";
    $idft=1; // parametro arrivante

    $data_foto = $connessione->query("SELECT foto.*,astrofilo.username,astrofilo.imgprofilo
            FROM foto JOIN astrofilo ON foto.idastrofilo=astrofilo.mail
            WHERE foto.id='$ft'AND foto.idastrofilo IS NOT NULL");
    //var_dump($datastudio);
    $data_foto=$data_foto->fetch_array(MYSQLI_ASSOC);

    $rank_foto= $connessione->query("SELECT SUM(voto) AS rank
           FROM giudicafoto
           WHERE idfoto='$idft'");
    $rank_foto=$rank_foto->fetch_array(MYSQLI_ASSOC);

    echo " ".$data_foto['username']."| ".$rank_foto['rank']."] ";

    // COMMENTI STUDIO
  if(!$result=$connessione->query("SELECT astrofilo.username,astrofilo.imgprofilo,commentafoto.commento,commentafoto.datainserimento
               FROM commentafoto JOIN astrofilo ON commentafoto.astrofilo=astrofilo.mail
               WHERE commentafoto.studio='$idft'
               ORDER BY commentafoto.datainserimento DESC")){
			echo "Errore della query: ".$connessione->error.".";
	}else{
		if($result->num_rows>0){
			while($row=$result->fetch_array(MYSQLI_ASSOC)){
				echo $row['username'].": ".$row['commento']." ".$row['datainserimento']." // ";
			}
			$result->free();
		}
    // voto=+1;-1;
    // si può votare una sola volta per ogni foto

  if(!$result=$connessione->query("SELECT votante FROM giudicafoto WHERE idfoto='$idft' AND votante='$mail_votante'")){
			echo "Errore della query: ".$connessione->error.".";
	}else{
		if($result->num_rows<=0){ // vuol dire che può votare
      $giudica_foto="INSERT INTO giudicafoto(votante,idfoto,voto,datainserimento) VALUES('$mail_votante','$idft','$voto','date("Y-m-d H:i:s")')";
      if(!$connessione->query($giudica_foto)){
        //errore nell'insert
      }
      $result->free();
		}

	}
?>
