<?php
  include "backend/connessione.php";
  echo file_get_contents("parti/listafoto0.html");
  session_start();
  if(isset($_SESSION['usermail'])){ // loggato
    echo file_get_contents("parti/headerloggato.html");
    echo '<div id="breadcrumb">
        <p>Ti trovi in: <span xml:lang="en"><a href="index.html">Home</a></span> &raquo; Lista foto</p>
     </div>';
    $usermail=$_SESSION['usermail'];
    $imm_query="SELECT * FROM foto WHERE idastrofilo='$usermail' AND idstudio IS NULL ORDER BY datainserimento DESC";
    if(!$result=$connessione->query($imm_query)){
      echo "Errore della query: ".$connessione->error.".";
    }else{
      if($result->num_rows > 0){
        while($row=$result->fetch_array(MYSQLI_ASSOC)){
          echo '<div class="list_element">';
          echo '<a href="fotoutente.php?idft='.$row['idfoto'].'" class="element_foto"><img src="data:image/jpeg;base64,'.base64_encode( $row['immagine'] ).'"  alt="" /> </a>';
          echo '<a href="fotooutente.php?idft='.$row['idfoto'].'" class="element_content"> <span>'.$row['titolo'].'</span><p> '.$row['didascalia'].'</p><p> In data -> '.$row['datainserimento'].'</p><p>';
          $rank_query="SELECT SUM(voto) AS rank FROM giudicafoto WHERE idfoto=".$row['idfoto'];
          $rank_studio=$connessione->query($rank_query);
          $rank_row=mysqli_fetch_array($rank_studio);
          echo "Rank: ".$rank_row['rank'];
          echo '</p></a></div>';
        }
  			$result->free();
      }else echo "Nessuna foto";
  	}
  }else{
    echo file_get_contents("parti/headernonloggato.html");
    echo '<div id="breadcrumb">
        <p>Ti trovi in: <span xml:lang="en"><a href="index.html">Home</a></span> &raquo; Lista foto</p>
     </div>';
    echo "Devi aver effettuato l'accesso per poter godere di questa funzionalità.";
  } // non loggato
    echo file_get_contents("parti/listafoto1.html");
?>
