<?php
/*
     //PARAMETRI IN LOCALE(cioè botta)
       $host="127.0.0.1";
       $user="root";
       $pwd="";
       $db="ASTROSERIO";
       * */
/*
    * PARAMETRI IN REMOTO*/
       $host="localhost";
       $user="mbottaro";
       $pwd="toosie5eimooW6ai";
       $db="mbottaro";
    /*
    In fase di sviluppo, debug e test dev'essere disabilitato il metodo error_reporting().
    Questo metodo non stampa gli eventuali warning generati. Alla consegna, invece, il metodo dovrà essere abilitato.
    Questo non perchè vogliamo imbrogliare, ma perchè i casi che generao i warning sono gestiti.
    Per provare, si faccia fallire in qualche modo la connsessione al DB(ad es cambiando i parametri di connessione).
    */
    //error_reporting(E_ERROR | E_PARSE);


   $connessione=new mysqli($host,$user,$pwd,$db);
   $msg_errore_DB="";
   $errore_DB=FALSE;
   if($connessione->connect_errno){
	   $msg_errore_DB='<p><strong>Abbiamo dei problemi a connetterci con il nostro database. I nostri tecnici stanno facendo il possibile.</strong></p>';
     $errore_DB=TRUE;
	   // qui ci andrebbe uno script che invia una mail a chi deve fixare il problema
   }else{
	   /*echo "Connesso! \n";
	   echo "Today is " . date("Y-m-d H:i:s")."\n";*/
     //$usermail="matbo@mail.it"; // serve solo per i test
   }
?>
