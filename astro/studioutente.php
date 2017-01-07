<?php
$idst=$_REQUEST['idst']; // per i test, dovrà essere passato dalla pagina precedente
    include "backend/connessione.php";
    echo file_get_contents("parti/studioutente0.html");
    session_start();
    if(!isset($_SESSION['usermail'])) echo file_get_contents("parti/headernonloggato.html");
    else echo file_get_contents("parti/headerloggato.html");
    echo '<div id="breadcrumb">
        <p>Ti trovi in: <span xml:lang="en"><a href="index.php">Home</a></span> &raquo; Studio utente</p>
    </div>';
    $data_studio= "SELECT studia.*,astrofilo.username,astrofilo.imgprofilo
                  FROM studia JOIN astrofilo ON studia.astrofilo=astrofilo.mail
                  WHERE studia.idstudio='$idst'";
    if(!$result=$connessione->query($data_studio)){
      echo "Errore della query: ".$connessione->error.".";
    }else{
      if($result->num_rows > 0){ // potrebbe essere passato l'id di uno studio non esistente.
        // Questo controllo impedisce di "visualizzare" studi inesistenti
          $row=mysqli_fetch_array($result);
          $foto_query= "SELECT * FROM foto WHERE idstudio='$idst'";
          $foto_studio=$connessione->query($foto_query);
          $foto_row=mysqli_fetch_array($foto_studio);
          $tecn_data_query="SELECT * FROM coinvolto WHERE id='$idst'"; // dati tecnici
          echo '<h2>'.$row['titolo'].'</h2><h3>Studio di: '.$row['username'].'</h3><div class="list_element">
            <div class="element_content" > <ul><li>Arco temporale: ('.$row['inizio'].', '.$row['fine'].') </li>';

          if(!$tecn_data_studio=$connessione->query($tecn_data_query))
              echo "Errore della query: ".$connessione->error.".";
          else{
              echo '<li>Corpi coinvolti:<ul> ';
            while($tecn_row=$tecn_data_studio->fetch_array(MYSQLI_ASSOC)){
              echo '<li>'.$tecn_row['corpo'].' (magnitudo: '.$tecn_row['magnitudo'].'; altezza: '.$tecn_row['altezza'].';
              azimut: '.$tecn_row['azimut'].')</li>';
            }
            echo '</ul></li></ul>';
          }
          echo '</div></div>'; // il secondo div è stato aperto nel file parti/studioutente0.html
          echo '<div class="list_element"><span>'.$row['appunti'].'</span></div>';
          $rank_query="SELECT SUM(voto) AS rank FROM giudicastudio WHERE studio=".$row['idstudio'];
          $rank_studio=$connessione->query($rank_query);
          $rank_row=mysqli_fetch_array($rank_studio);
          echo '<div id="rank"> <span id="vota">+ | -</span> <span id="rank_txt">rank: '.$rank_row['rank'].'</span></div>';
          echo file_get_contents("parti/commenti.html");
          $commenti_studio_query= "SELECT astrofilo.username,astrofilo.imgprofilo,commentastudio.commento,commentastudio.datainserimento
                                  FROM commentastudio JOIN astrofilo ON commentastudio.astrofilo=astrofilo.mail
                                  WHERE commentastudio.studio='$idst'
                                  ORDER BY commentastudio.datainserimento DESC";
         if(!$commenti_studio=$connessione->query($commenti_studio_query))
           echo "Errore della query: ".$connessione->error.".";
         else{
           while($commenti_row=$commenti_studio->fetch_array(MYSQLI_ASSOC)){
             echo '<div class="list_element">
                   <div class="element_content">
                   <p> '.$commenti_row['username'].': '.$commenti_row['commento'].' </p>  </div> </div> </div>';
           }
          }
        }else echo 'IMPOSSIBILE VISUALIZZARE LO STUDIO';
  	}
      echo file_get_contents("parti/studioutente1.html");
?>
