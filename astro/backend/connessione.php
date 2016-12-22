<?php
   /*
    * PARAMETRI IN LOCALE(cioè botta)
       $host="127.0.01";
       $user="root";
       $pwd="";
       $db="ASTROSERIO";

    * PARAMETRI IN REMOTO
       $host="localhost";
       $user="mbottaro";
       $pwd="toosie5eimooW6ai";
       $db="mbottaro";
    * */

    $host="127.0.0.1";
    $user="root";
    $pwd="";
    $db="ASTROSERIO";

   $connessione=new mysqli($host,$user,$pwd,$db);

   if($connessione->connect_errno){
	   echo "Connessione fallita(".$connessione->connect_errno."):"
	         .$connessione->$connect_error;
	   exit();
   }else{
	   /*echo "Connesso! \n";
	   echo "Today is " . date("Y-m-d H:i:s")."\n";*/
     $usermail="matbo@mail.it"; // serve solo per i test
   }
?>
