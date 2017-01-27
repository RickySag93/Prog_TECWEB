<?php
   include "connessione.php";
   if($errore_DB==FALSE){
    $password=$_POST['password'];
    $r_password=$_POST['ripetiPassword'];
    $usermail=$_POST['email'];
    $nome=$_POST['nome'];
    $cognome=$_POST['cognome'];
    $username=$_POST['username'];
    $pwd_pattern='/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,32}$/'; // minimo 8 caratteri, un numero, un carattere maiuscolo, un carattere minuscolo. Max 32 char
    $usrn_pattern='/^[A-Za-z]{1}[A-Za-z0-9]{4,20}$/'; //  almeno 5 caratteri, max 20. solo lettere e numeri. Non può partire con un numero.
    $nome_cognome_pattern='/^[A-Za-z]{3,20}$/'; // almeno 3 caratteri,max 20, solo lettere, no numeri
     if($password==$r_password){ // se le password coincidono...
      if(preg_match($nome_cognome_pattern,$nome)){ // se il nome rispetta la regex...
        if(preg_match($nome_cognome_pattern,$cognome)){ // se il cognome risp..
          if(filter_var($usermail,FILTER_VALIDATE_EMAIL) && strlen($usermail)<=40){ // se la mail è valida...
             $check_mail="SELECT mail FROM astrofilo WHERE mail='$usermail'";
             if(!$res_mail=$connessione->query($check_mail)){
             }else if(!$res_mail->num_rows){// se la mail non è in uso...
             if(preg_match($usrn_pattern,$username)){ // se l'username rispetta
               $check_usrn="SELECT username FROM astrofilo WHERE username='$username'";
               if(!$res_us=$connessione->query($check_usrn)){
               }else if(!$res_us->num_rows){// se l'username non è in uso...
                   if(preg_match($pwd_pattern,$password)){// se la pwd rispetta...
                      // Tutto ok! Inseriamo...
                      $_POST['password']=md5($_POST['password']); // criptiamo la password
                      $_POST['ripetiPassword']=md5($_POST['ripetiPassword']);
                      $password=$_POST['password'];
                      $ins="INSERT INTO astrofilo(mail,nome,cognome,username,password) VALUES('$usermail','$nome','$cognome','$username','$password')";
                      if(!$connessione->query($ins)){
                        session_start();
                        $_SESSION['err']="Spiacenti, abbiamo avuto un problema con il nostro database.";
                        header('Location: ../registrazione.php');
                      }else{
                        session_start();
                         $_SESSION['err']='<p class="p_rsucc">Registrazione avvenuta con successo! </p>
                         <p class="p_rsucc"><a href="index.php">Torna in <span xml:lang="en">Home</span></a></p>';
                         header('Location: ../login.php');
                       }
                   }else{//password non valida
                     session_start();
                     $_SESSION['err']="La password inserita non è corretta.";
                     header('Location: ../login.php');
                   }
              }else{// username già in uso
                session_start();
                $_SESSION['err']="l'username inserito è già in uso.";
                header('Location: ../registrazione.php');
              }
            }else{//username non valido
               session_start();
               $_SESSION['err']="L'username inserito non è corretto o già in uso.";
               header('Location: ../registrazione.php');
             }
         }else{// mail già in uso
           session_start();
           $_SESSION['err']="la mail inserita è già in uso.";
           header('Location: ../registrazione.php');
         }
       }else{// mail non valida
            session_start();
            $_SESSION['err']="la mail inserita non è corretta.";
            header('Location: ../registrazione.php');
          }
        }else{// cognome non valido
          session_start();
          $_SESSION['err']="Il cognome inserito non è corretto.";
          header('Location: ../registrazione.php');
        }
      }else{// nome non valido
        session_start();
        $_SESSION['err']="Il nome inserito non è corretto.";
        header('Location: ../registrazione.php');
      }

      // Questa struttura aiuta in fase di sviluppo e debug per testare
      /*
      if(preg_match($pwd_pattern,$password)) echo "password OK \n";
      else echo "password NO \n"; // occhio alla criptazione md5
      if(preg_match($usrn_pattern,$username)) echo "username OK \n";
      else echo "username NO \n";
      if(preg_match($nome_cognome_pattern,$nome)) echo "nome OK \n";
      else echo "nome NO \n";
      if(preg_match($nome_cognome_pattern,$cognome)) echo "nome OK \n";
      else echo "nome NO \n";
      if(filter_var($usermail,FILTER_VALIDATE_EMAIL) && strlen($usermail)<=40) echo "email OK";
      else echo "email NO";
      */
    }else{
      session_start();
      $_SESSION['err']="Le password inserite non sono uguali.";
      header('Location: ../registrazione.php');
      //echo "Password distinte";
    }
  }
 ?>
