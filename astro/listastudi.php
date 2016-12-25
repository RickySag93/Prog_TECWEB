<?php
  include "backend/connessione.php";
  echo file_get_contents("parti/listastudi0.html");
  session_start();
  if(isset($_SESSION['usermail'])){ // loggato
    echo file_get_contents("parti/headerloggato.html");
    echo '  <div id="breadcrumb">
          <p>Ti trovi in: <span xml:lang="en"><a href="index.html">Home</a></span> &raquo;  <a href="listastudi.html">Lista studi</a> </p>
      </div>';
    $usermail=$_SESSION['usermail'];
    $st_query="SELECT * FROM studia WHERE astrofilo='$usermail' ORDER BY studia.inizio DESC";
    if(!$result=$connessione->query($st_query)){
      echo "Errore della query: ".$connessione->error.".";
    }else{
      if($result->num_rows>0){
        while($row=$result->fetch_array(MYSQLI_ASSOC)){
          $imm_query="SELECT * FROM foto WHERE idstudio=".$row['idstudio']." AND idstudio IS NOT NULL LIMIT 1";
          $imm_studio=$connessione->query($imm_query);
          $imm_row=mysqli_fetch_array($imm_studio);
          echo '<div class="list_element">';
          echo '<a href="studioutente.php?idst='.$row['idstudio'].'" class="element_foto"><img src="data:image/jpeg;base64,'.base64_encode( $imm_row['immagine'] ).'"  alt="" /> </a>';
          echo '<a href="studioutente.php?idst='.$row['idstudio'].'" class="element_content"> <span>'.$row['titolo'].'</span><p>Hai studiato -> '.$row['evento'].'</p><p> Arco temporale -> ['.$row['inizio'].' , '.$row['fine'].']</p><p>';
          $rank_query="SELECT SUM(voto) AS rank FROM giudicastudio WHERE studio=".$row['idstudio'];
          $rank_studio=$connessione->query($rank_query);
          $rank_row=mysqli_fetch_array($rank_studio);
          echo "Rank: ".$rank_row['rank'];
          echo '</p></a></div>';
        }
  			$result->free();
      }else echo "Nessuno studio";
  	}
  }else{
    echo file_get_contents("parti/headernonloggato.html");
    echo '  <div id="breadcrumb">
          <p>Ti trovi in: <span xml:lang="en"><a href="index.html">Home</a></span> &raquo;  <a href="listastudi.html">Lista studi</a> </p>
      </div>';
    echo "Devi aver effettuato l'accesso per poter godere di questa funzionalità.";
  }
    echo file_get_contents("parti/listastudi1.html");
?>
