<?php
  include "backend/connessione.php";
  echo file_get_contents("parti/attivita1.html");
  session_start();
  if(isset($_SESSION['usermail'])){ // loggato
   echo file_get_contents("parti/headerloggato.html");
   echo '  <div id="breadcrumb">
         <p>Ti trovi in: <span xml:lang="en"><a href="index.html">Home</a></span> &raquo;  <a href="listastudi.html">Lista studi</a> </p>
     </div><div class="list_attivita">';
   $usermail=$_SESSION['usermail'];
   $att_studi="SELECT studia.datainserimento,studia.idstudio,studia.titolo,studia.evento,studia.inizio,
                      astrofilo.username,astrofilo.nome,astrofilo.cognome,astrofilo.imgprofilo
               FROM studia JOIN relazioni ON studia.astrofilo=relazioni.astro2 JOIN astrofilo ON studia.astrofilo=astrofilo.mail
               WHERE relazioni.astro1='$usermail'";

   // manca foto.immagine nel SELECT, questo solo per fare dei test da terminale
   $att_foto= "SELECT foto.datainserimento,foto.idfoto,foto.titolo,foto.idastrofilo,astrofilo.username
                          FROM foto JOIN relazioni ON foto.idastrofilo=relazioni.astro2 JOIN astrofilo ON foto.idastrofilo=astrofilo.mail
                          WHERE relazioni.astro1='$usermail' AND foto.idastrofilo IS NOT NULL";

   $attivita_soci=array();

   if(!$result=$connessione->query($att_studi)){
     echo "Errore della query: ".$connessione->error.".";
   }else{
     if($result->num_rows>0){
       while($studi_soci=$result->fetch_array(MYSQLI_ASSOC)){
         /*echo $studi_soci['username']." ha fatto uno studio";
         if($studi_soci['titolo']=="") echo" il ".$studi_soci['datainserimento'].".\n";
         else echo ": ".$studi_soci['titolo'].", il ".$studi_soci['datainserimento'].".\n";*/
        array_push($attivita_soci,$studi_soci);
      }
       $result->free();
       //echo "Trovati studi \n";
     }
   }

   if(!$result=$connessione->query($att_foto)){
     echo "Errore della query: ".$connessione->error.".";
   }else{
     if($result->num_rows>0){
       while($foto_soci=$result->fetch_array(MYSQLI_ASSOC)){
        /* echo $foto_soci['username']." ha fatto una foto";
         if($foto_soci['titolo']=="") echo " il ".$foto_soci['datainserimento'].".\n";
         else echo ": ".$foto_soci['titolo'].", il ".$foto_soci['datainserimento'].".\n";*/
         array_push($attivita_soci,$foto_soci);
       }
       //$result->free();
      // echo "Trovate foto\n";
     }
   }

   // fondo studi con foto per ordinali e visualizzarli con un ordine cronologico

   //$attivita_soci=array_merge($studi_soci,$foto_soci);
   //echo "Stampo array \n";
   // algoritmo di ordinamento
   function sortAttivitaSoci(&$array, $key){
       $sorter=array();
       $ret=array();
       reset($array);
       foreach ($array as $ii => $va) {
           $sorter[$ii]=$va[$key];
       }
       arsort($sorter);
       foreach ($sorter as $ii => $va) {
           $ret[$ii]=$array[$ii];
       }
       $array=$ret;
   }
   // l'array è ordinato in base all'attributo key.

   sortAttivitaSoci($attivita_soci,"datainserimento");
   // la stampa delle attività si basa sul fallimento della ricerca di certe chiavi.
   // quando la ricerca fallisce, PHP ritorna un NOTICE a video. In fase di sviluppo e debug va bene,
   // ma alla consegna dovrà essere abilitata la funzione error_reporting(0); .
   error_reporting(0);

   // stampa attività
  if(sizeof($attivita_soci)){
   foreach($attivita_soci as $att){
     echo '<a href="#" class="attivita_singola"><span>';
     if($att['idfoto']==""){
         echo $att['username']." ha fatto uno studio";
         if($att['titolo']=="") echo" il ".$att['datainserimento'].".\n";
         else echo ": \"".$att['titolo']."\", il ".$att['datainserimento'].".\n";
     }else if($att['idstudio']==""){
         echo $att['username']." ha fatto una foto";
         if($att['titolo']=="") echo " il ".$att['datainserimento'].".\n";
         else echo ": \"".$att['titolo']."\", il ".$att['datainserimento'].".\n";
     }
     echo '</a>';
   }
 }else echo 'Nessuna attività.';
}else{
  echo file_get_contents("parti/headernonloggato.html");
   echo "Devi aver effettuato l'accesso per poter godere di questa funzionalità."; // non loggato
 }
 echo file_get_contents("parti/attivita2.html");
   /*
   echo "\n ############ \n";
   print_r($attivita_soci);
   */

?>
