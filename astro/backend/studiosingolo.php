<?php
    include "connessione.php";
    $idst=1; // parametro arrivante

    $data_studio = $connessione->query("SELECT studia.*,astrofilo.username,astrofilo.imgprofilo
                   FROM studia JOIN astrofilo ON studia.astrofilo=astrofilo.mail
                   WHERE studia.idstudio='$idst'");
    //var_dump($datastudio);
    $data_studio=$data_studio->fetch_array(MYSQLI_ASSOC);

    $foto_studio=$connessione->query("SELECT * FROM foto WHERE idstudio='$idst' LIMIT 3");
    $foto_studio=$foto_studio->fetch_array(MYSQLI_ASSOC);

    $rank_studio= $connessione->query("SELECT SUM(voto) AS rank FROM giudicastudio WHERE studio='$idst'");
    $rank_studio=$rank_studio->fetch_array(MYSQLI_ASSOC);

    echo " [".$data_studio['titolo']."| ".$data_studio['username']."| ".$data_studio['appunti']."| ".$rank_studio['rank']."] ";

    // COMMENTI STUDIO
    if(!$result=$connessione->query("SELECT astrofilo.username,astrofilo.imgprofilo,commentastudio.commento,commentastudio.datainserimento
                                     FROM commentastudio JOIN astrofilo ON commentastudio.astrofilo=astrofilo.mail
                                     WHERE commentastudio.studio='$idst'
                                     ORDER BY commentastudio.datainserimento DESC")){
			echo "Errore della query: ".$connessione->error.".";
	}else{
		if($result->num_rows>0){
			while($row=$result->fetch_array(MYSQLI_ASSOC)){
				echo $row['username'].": ".$row['commento']." ".$row['datainserimento']." // ";
			}
			$result->free();
		}
	}

  // voto=+1;-1;
  // si può votare una sola volta per ogni studio

if(!$result=$connessione->query("SELECT votante FROM giudicastudio WHERE idfoto='$idst' AND votante='$mail_votante'")){
    echo "Errore della query: ".$connessione->error.".";
}else{
  if($result->num_rows<=0){ // vuol dire che può votare
    $giudica_studio="INSERT INTO giudicastudio(votante,studio,voto,datainserimento) VALUES('$mail_votante','$idst','$voto','date("Y-m-d H:i:s")')";
    if(!$connessione->query($giudica_studio)){
      //errore nell'insert
    }
    $result->free();
  }

}

?>
