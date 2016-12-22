<?php
    include "backend/connessione.php";
    echo file_get_contents("parti/listafoto0.html");
    $imm_query="SELECT * FROM foto WHERE idastrofilo='$usermail' AND idstudio IS NULL ORDER BY datainserimento DESC";
    if(!$result=$connessione->query($imm_query)){
      echo "Errore della query: ".$connessione->error.".";
    }else{
        while($row=$result->fetch_array(MYSQLI_ASSOC)){
          echo '<div class="list_element">';
          echo '<a href="fotoutente.html" class="element_foto"><img src="data:image/jpeg;base64,'.base64_encode( $row['immagine'] ).'"  alt="" /> </a>';
          echo '<a href="fotooutente.html" class="element_content"> <span>'.$row['titolo'].'</span><p> '.$row['didascalia'].'</p><p> In data -> '.$row['datainserimento'].'</p><p>';
          $rank_query="SELECT SUM(voto) AS rank FROM giudicafoto WHERE idfoto=".$row['idfoto'];
          $rank_studio=$connessione->query($rank_query);
          $rank_row=mysqli_fetch_array($rank_studio);
          echo "Rank: ".$rank_row['rank'];
          echo '</p></a></div>';
        }
  			$result->free();
  	}
    echo file_get_contents("parti/listafoto1.html");
?>
