<?php
$idft=$_REQUEST['idft']; // per i test, dovrà essere passato dalla pagina precedente
    include "backend/connessione.php";
    echo file_get_contents("parti/fotoutente0.html");
    session_start();
    if(!isset($_SESSION['usermail'])) echo file_get_contents("parti/headernonloggato.html");
    else echo file_get_contents("parti/headerloggato.html");
    if(isset($_SESSION['msg_login'])){
      echo '<p>'.$_SESSION['msg_login'].'<p>';
      unset($_SESSION['msg_login']);
    }
    echo '<div id="breadcrumb">
      <p>Ti trovi in: <span xml:lang="en"><a href="index.php">Home</a></span> &raquo; <a href="listafoto.php">Lista foto</a> &raquo; <strong>Foto</strong></p>
    </div>';
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
    	echo '<div id="rank"><span id="vota">+ | -</span><span id="rank_txt">'.$rank_row['rank'].'</span></div>';
      echo '
    	 <div class="list_element">
            <div class="element_content" >
              <span> '.$row['didascalia'].'  </span>
            </div>
        </div>';
        $commenti_foto_query= "SELECT astrofilo.username,astrofilo.imgprofilo,commentafoto.commento,commentafoto.datainserimento
                       FROM commentafoto JOIN astrofilo ON commentafoto.astrofilo=astrofilo.mail
                       WHERE commentafoto.idfoto='$idft'
                       ORDER BY commentafoto.datainserimento DESC";
       if(!$commenti_foto=$connessione->query($commenti_foto_query))
         echo "Errore della query: ".$connessione->error.".";
       else{
         echo '<h4>Commenti</h4>';
          while($commenti_row=$commenti_foto->fetch_array(MYSQLI_ASSOC)){
            echo '
               <div class="big_list_element">
               <div class="big_element_content">
               <p>'.$commenti_row['username'].': '.$commenti_row['commento'].'</p>
               </div>
               </div>';
         }
       }
     }else echo '<p>La foto non è presente nel database.</p>';
        echo file_get_contents("parti/fotoutente1.html");
    }

?>
