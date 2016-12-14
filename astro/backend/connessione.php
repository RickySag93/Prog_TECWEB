<?php
   /* 
    * PARAMETRI IN LOCALE
       $host="localhost";
       $user="root";
       $pwd="";
       $db="ASTROSERIO";
    
    * PARAMETRI IN REMOTO
       $host="localhost";
       $user="mbottaro";
       $pwd="toosie5eimooW6ai";
       $db="mbottaro";
    * */
       $host="localhost";
       $user="mbottaro";
       $pwd="toosie5eimooW6ai";
       $db="mbottaro";
   
   $connessione=new mysqli($host,$user,$pwd,$db);
   
   if($connessione->connect_errno){
	   echo "Connessione fallita(".$connessione->connect_errno."):"
	         .$connessione->$connect_error;
	   exit();      
   }else{
	   echo "Connesso! ";
	   echo "Today is " . date("Y-m-d H:i:s")." -- ";
   }
?>
