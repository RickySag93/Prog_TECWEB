<?php
$idst=$_REQUEST['idst']; // per i test, dovrà essere passato dalla pagina precedente
    include "backend/connessione.php";
    echo file_get_contents("parti/studioutente0.html");
    session_start();
    if(!isset($_SESSION['usermail'])) {
      echo file_get_contents("parti/headernonloggato.html");
      $usr=NULL;
    }else{
      echo file_get_contents("parti/headerloggato.html");
      $usr=$_SESSION['usermail'];
    }
    if(isset($_SESSION['msg_login'])){
      echo '<p>'.$_SESSION['msg_login'].'<p>';
      unset($_SESSION['msg_login']);
    }
    echo '<div id="breadcrumb">
        <p>Ti trovi in: <span xml:lang="en"><a href="index.php">Home</a></span> &raquo; Studio utente</p>
    </div>';
   if($errore_DB==FALSE){
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
          echo '<h2>'.$row['titolo'].'</h2><div class="list_element">
            <div class="element_content" > <ul><li>Arco temporale: ('.$row['inizio'].', '.$row['fine'].') </li>';

          if(!$tecn_data_studio=$connessione->query($tecn_data_query))
              //echo "Errore della query: ".$connessione->error.".";
              echo '<p>Abbiamo riscontrato dei problemi nel visualizzare lo studio.</p>';
          else{
              echo '<li>Corpi coinvolti:<ul> ';
            while($tecn_row=$tecn_data_studio->fetch_array(MYSQLI_ASSOC)){
              echo '<li>'.$tecn_row['corpo'].' (magnitudo: '.$tecn_row['magnitudo'].'; altezza: '.$tecn_row['altezza'].';
              azimut: '.$tecn_row['azimut'].')</li>';
            }
            echo '</ul></li></ul>';
          }
          echo '</div></div>'; // il secondo div è stato aperto nel file parti/studioutente0.html
          echo '<div class="big_list_element">
                <div class="big_element_content">
                <span>'.$row['appunti'].'</span> </div> </div>';
          $rank_query="SELECT SUM(voto) AS rank FROM giudicastudio WHERE studio=".$row['idstudio'];
          $rank_studio=$connessione->query($rank_query);
          $rank_row=mysqli_fetch_array($rank_studio);
    	echo '<div id="rank"><span id="vota">';
      if(isset($_SESSION['usermail']) AND $votante_result=$connessione->query("SELECT votante FROM giudicastudio WHERE studio='$idst' AND votante='$usr'")){
        if($votante_result->num_rows==0){ // non possiamo votare due volte la stessa foto
          echo ' <form method="post" action="backend/votastudio.php">
                 <button name="up"><img src="parti/immagini/up.png"></button> |
                 <button name="down"><img src="parti/immagini/down.png"></button>
                 <input type="hidden" name="studio" value="'.$idst.'" />
                 </form>';
         }
      }// else non puoi votare
    	echo '</span><span id="rank_txt">'.$rank_row['rank'].'</span></div>';
      if(isset($_SESSION['usermail'])){
        if(isset($_SESSION['err_commento'])){
          echo $_SESSION['err_commento'];
          unset($_SESSION['err_commento']);
        }
        echo '<div class="commenti">
        <form method="post" action="backend/commentastudio.php">
            <h4>Commenti</h4>
            <textarea name="commento" rows="20" cols="80"></textarea>
            <input type="hidden" name="studio" value="'.$idst.'" />
            <button name="commenta">Commenta</button>
        </form>
        </div>';
      }
          $commenti_studio_query= "SELECT astrofilo.username,astrofilo.imgprofilo,commentastudio.commento,commentastudio.datainserimento
                                  FROM commentastudio JOIN astrofilo ON commentastudio.astrofilo=astrofilo.mail
                                  WHERE commentastudio.studio='$idst'
                                  ORDER BY commentastudio.datainserimento DESC";
         if(!$commenti_studio=$connessione->query($commenti_studio_query))
           echo "Errore della query: ".$connessione->error.".";
         else{
           while($commenti_row=$commenti_studio->fetch_array(MYSQLI_ASSOC)){
             echo '<div class="big_list_element">
                   <div class="big_element_content">
                   <p> '.$commenti_row['username'].': '.$commenti_row['commento'].' '.$commenti_row['datainserimento'].'</p>  </div></div>';
           }
          }
        }else echo '<p>Lo studio non è presente nel database.</p>';
      }
  	}else echo '<p>'.$msg_errore_DB.'</p>';
      echo file_get_contents("parti/studioutente1.html");
?>
