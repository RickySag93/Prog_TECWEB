<?php
include "backend/connessione.php";
echo file_get_contents("parti/listagruppi0.html");
session_start();
if(isset($_SESSION['usermail'])){ // loggato
  echo file_get_contents("parti/headerloggato.html");
  echo '<div id="breadcrumb">
      <p>Ti trovi in: <span xml:lang="en"><a href="index.html">Home</a></span> &raquo; Gruppi</p>
  </div>';
 $usermail=$_SESSION['usermail'];
 $gr_query="SELECT * FROM parte NATURAL JOIN gruppo WHERE astrofilo='$usermail' ORDER BY nome";
 if(!$result=$connessione->query($gr_query)){
   echo "Errore della query: ".$connessione->error.".";
 }else{
   if($result->num_rows > 0){
     while($row=$result->fetch_array(MYSQLI_ASSOC)){
       echo '<div class="list_element">
             <a href="gruppo.html" class="element_foto"> <img src="data:image/jpeg;base64,'.base64_encode( $row['immagine'] ).'"  alt="" /> </a>
             <a href="gruppo.html" class="element_content"> <span> '.$row['nome'].', '.$row['citta'].' ('.$row['prov'].') </span></a></div>';
     }
    $result->free();
  }else echo "Non fai parte di alcun gruppo.";
 }
}else{
  echo file_get_contents("parti/headernonloggato.html");
  echo '<div id="breadcrumb">
      <p>Ti trovi in: <span xml:lang="en"><a href="index.html">Home</a></span> &raquo; Gruppi</p>
  </div>';
  echo "Devi aver effettuato l'accesso per poter godere di questa funzionalità.";
}
 echo file_get_contents("parti/listagruppi1.html");
?>
