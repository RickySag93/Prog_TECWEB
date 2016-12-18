<?php
   include "connessione.php";
   $att_studi="SELECT studia.idstudio,studia.titolo,studia.evento,studia.inizio,studia.datainserimento,
                      astrofilo.username,astrofilo.nome,astrofilo.cognome,astrofilo.imgprofilo
               FROM studia JOIN relazioni ON studia.astrofilo=relazioni.astro2 JOIN astrofilo ON studia.astrofilo=astrofilo.mail
               WHERE relazioni.astro1='$usermail'";

   $att_foto= "SELECT foto.idfoto,foto.immagine,foto.titolo,foto.idastrofilo,foto.datainserimento,astrofilo.username
                          FROM foto JOIN relazioni ON foto.idastrofilo=relazioni.astro2 JOIN astrofilo ON foto.idastrofilo=astrofilo.mail
                          WHERE relazioni.astro1='$usermail' AND foto.idastrofilo IS NOT NULL";

   $studi_soci=array();
   $foto_soci=array();

   if(!$result=$connessione->query($att_studi)){
     echo "Errore della query: ".$connessione->error.".";
   }else{
     if($result->num_rows>0){
       while($studi_soci=$result->fetch_array(MYSQLI_ASSOC)){
         echo $studi_soci['username']." ha fatto uno studio";
         if($studi_soci['titolo']=="") echo" il ".$studi_soci['datainserimento'].".\n";
         else echo ": ".$studi_soci['titolo'].", il ".$studi_soci['datainserimento'].".\n";
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
         echo $foto_soci['username']." ha fatto una foto";
         if($foto_soci['titolo']=="") echo" il ".$foto_soci['datainserimento'].".\n";
         else echo ": ".$foto_soci['titolo'].", il ".$foto_soci['datainserimento'].".\n";
       }
       $result->free();
      // echo "Trovate foto\n";
     }
   }

   // fondo studi con foto per ordinali e visualizzarli con un ordine cronologico

   //$attivita_soci=array_merge($studi_soci,$foto_soci);

?>
