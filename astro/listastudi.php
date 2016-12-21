<?php
    include "backend/connessione.php";
    echo file_get_contents("parti/listastudi0.html");
    $st_query="SELECT * FROM studia WHERE astrofilo='$usermail' ORDER BY studia.datainserimento";
    if(!$result=$connessione->query($st_query)){
      echo "Errore della query: ".$connessione->error.".";
    }else{
        while($row=$result->fetch_array(MYSQLI_ASSOC)){
          $imm="SELECT immagine FROM foto WHERE idstudio=1 AND foto.idstudio";
          echo '<div class="list_element">';
          if($res=$connessione->query($imm)){
              $imm=$res->fetch_array(MYSQLI_ASSOC);
              echo '<a href="studioutente.html" class="element_foto"><img src="data:image/jpeg;base64,'.base64_encode( $imm['immagine'] ).'"  alt="" /> </a>';
          }
          echo '<a href="studioutente.html" class="element_content"> <span> '.$row['titolo'].' </span> </a>';
          echo "\n";
          echo '</div>';
        }
  			$result->free();
  	}
    echo file_get_contents("parti/listastudi1.html");
?>
