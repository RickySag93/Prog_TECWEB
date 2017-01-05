function validateRegistrazione(){
  var nm = document.forms["modulo"]["nome"].value;
  var cnm = document.forms["modulo"]["cognome"].value;
  var eml = document.forms["modulo"]["email"].value;
  var usrnm = document.forms["modulo"]["username"].value;
  var pw = document.forms["modulo"]["psw"].value;
  var rpw = document.forms["modulo"]["rpsw"].value;
  var pwdregex=/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,32}$/;
  var usrnmregex=/^[A-Za-z]{1}[A-Za-z0-9]{4,20}$/;
  var nmcnmregex=/^[A-Za-z]{3,20}$/;
  var emlregex=/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  var valid=true;

if(nmcnmregex.test(nm)==false){
    alert('nome non valido');
    valid=false;
  }
  if(nmcnmregex.test(cnm)==false){
      valid=false;
    }
  if(emlregex.test(eml)==false){
        alert('email non valida');
        valid=false;
    }
  if(usrnmregex.test(usrnm)==false){
          valid=false;
  }
  if(pwdnmregex.test(pw)==false){
        valid=false;
    }
    if(rpw!=pw){
      valid=false;
    }
    return valid;
}
