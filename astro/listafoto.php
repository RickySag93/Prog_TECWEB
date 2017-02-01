<?php
  include "backend/connessione.php";
  echo file_get_contents("parti/listafoto0.html");
  session_start();
  if(!isset($_SESSION['usermail'])) echo file_get_contents("parti/headernonloggato.html");
  else echo file_get_contents("parti/headerloggato.html");
  if(isset($_SESSION['msg_login'])){
    echo '<p>'.$_SESSION['msg_login'].'<p>';
    unset($_SESSION['msg_login']);
  }
    echo '<div id="breadcrumb">
        <p>Ti trovi in: <span xml:lang="en"><a href="index.php">Home</a></span> &raquo; <strong>Lista foto</strong></p>
     </div>';
    $imm_query="SELECT * FROM foto WHERE idstudio IS NULL ORDER BY datainserimento DESC";
   if($errore_DB==FALSE){
    if(!$result=$connessione->query($imm_query)){
      //echo "Errore della query: ".$connessione->error.".";
      echo '<p>Abbiamo riscontrato dei problemi nel visualizzare le foto.</p>';
    }else{
      if($result->num_rows > 0){
        echo '<h2>Ecco tutte le nostre foto.</h2>';
        while($row=$result->fetch_array(MYSQLI_ASSOC)){
          echo '<div class="list_element not_single_studio">';
          echo '<a href="fotoutente.php?idft='.$row['idfoto'].'" class="element_foto" tabindex="-1"><img src="'.$row['immagine'].'"  alt="'.$row['didascalia'].'" /> </a>';
          echo '<a href="fotoutente.php?idft='.$row['idfoto'].'" class="element_content"> <span>'.$row['titolo'].'</span><span> '.$row['didascalia'].'</span><span> In data: '.$row['datainserimento'].'</span><span>';
          $rank_query="SELECT SUM(voto) AS rank FROM giudicafoto WHERE idfoto=".$row['idfoto'];
          $rank_studio=$connessione->query($rank_query);
          $rank_row=mysqli_fetch_array($rank_studio);
          echo "Rank: ".$rank_row['rank'];
          echo '</span></a></div>';
        }
  			$result->free();
      }else echo '<p>Nessuna foto</p>';
  	 }
   }else echo $msg_errore_DB;
    echo file_get_contents("parti/listafoto1.html");
?>
