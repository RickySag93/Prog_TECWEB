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
	   echo "Connesso! PROVIAMO un query! \n";
	   if(!$result=$connessione->query("SELECT username FROM astrofilo")){
		   echo "Errore query:".$connessione->error.". \n";
		   exit();
	   }else{
		   if($result->num_rows>0){
			   while($row = $result->fetch_array(MYSQLI_ASSOC)){
                     echo $row['username'] ." /n";
               }
           $result->free();
		   }
		   $connessione->close();
	   }
   }
?>
