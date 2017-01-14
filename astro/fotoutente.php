<?php
$idft=$_REQUEST['idft']; // per i test, dovrà essere passato dalla pagina precedente
    include "backend/connessione.php";
    echo file_get_contents("parti/fotoutente0.html");
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
      <p>Ti trovi in: <span xml:lang="en"><a href="index.php">Home</a></span> &raquo; <a href="listafoto.php">Lista foto</a> &raquo; <strong>Foto</strong></p>
    </div>';
   if($errore_DB==FALSE){
    $data_foto= "SELECT foto.*,astrofilo.username,astrofilo.imgprofilo
                FROM foto JOIN astrofilo ON foto.idastrofilo=astrofilo.mail
                WHERE foto.idfoto='$idft' AND foto.idstudio IS NULL";
    if(!$result=$connessione->query($data_foto)){
        //echo "Errore della query: ".$connessione->error.".";
        echo '<p>Abbiamo riscontrato dei problemi nel visualizzare la foto.</p>';
    }else{
      if($result->num_rows > 0){ // potrebbe essere passato l'id di una foto non esistente o di una foto associata ad uno studio
        //(non visualizzabile in questa pagina). Questo controllo impedisce di "visualizzare" foto inesistenti
        $row=mysqli_fetch_array($result);
        $rank_query="SELECT SUM(voto) AS rank FROM giudicafoto WHERE idfoto=".$row['idfoto'];
        $rank_foto=$connessione->query($rank_query);
        $rank_row=mysqli_fetch_array($rank_foto);

    	echo'<h2>'.$row['titolo'].'</h2><img id="foto" src="'.$row['immagine'].'"  alt="'.$row['didascalia'].'" />';
    	echo '<div id="rank">';
      if(isset($_SESSION['usermail'])){
        echo '<form method="post" action="backend/votafoto.php">
                 <button name="up"><img src="parti/immagini/up.png" alt="mi piace"/></button>
                 <button name="down"><img src="parti/immagini/down.png" alt=" non mi piace"/></button>
                 <input type="hidden" name="foto" value="'.$idft.'"/>
                 </form>';
      }// else non puoi votare
    	echo '<p id="rank_txt">'.$rank_row['rank'].'</p></div>';
      echo '
    	 <div class="big_list_element didascalia_el">
            <div class="big_element_content">
              <p> '.$row['didascalia'].'  </p>
            </div>
        </div>';
        if(isset($_SESSION['usermail'])){
          if(isset($_SESSION['err_commento'])){
            echo $_SESSION['err_commento'];
            unset($_SESSION['err_commento']);
          }

           echo '<div id="box_comment">
          <form method="post" action="backend/commentafoto.php">
              <textarea name="commento"></textarea>
              <input type="hidden" name="foto" value="'.$idft.'" />
              <button id="comment" name="commenta">Commenta</button>
          </form>
          </div><div id="list_comment"><h3>Commenti</h3>';
        }
        $commenti_foto_query= "SELECT astrofilo.username,astrofilo.imgprofilo,commentafoto.commento,commentafoto.datainserimento
                       FROM commentafoto JOIN astrofilo ON commentafoto.astrofilo=astrofilo.mail
                       WHERE commentafoto.idfoto='$idft'
                       ORDER BY commentafoto.datainserimento DESC";
       if(!$commenti_foto=$connessione->query($commenti_foto_query))
         echo "Errore della query: ".$connessione->error.".";
       else{
          while($commenti_row=$commenti_foto->fetch_array(MYSQLI_ASSOC)){
            echo '
               <div class="big_list_element">
               <p> '.$commenti_row['username'].' scrive:</p><p> '.$commenti_row['commento'].' <span id="data_ora">'.$commenti_row['datainserimento'].' </span></p>
               </div>';
         }
       }
     }else echo '<p><strong>La foto che cerchi non esiste. </strong><a href="listafoto.php">Torna alla lista delle foto</a></p>';
    }
   }else echo $msg_errore_DB;
   echo '</div>';
   echo file_get_contents("parti/fotoutente1.html");

?>
