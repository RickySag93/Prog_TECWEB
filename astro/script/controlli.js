var pwdregex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,32}$/;
var usrnmregex = /^[A-Za-z]{1}[A-Za-z0-9]{4,20}$/;
var nmcnmregex = /^[A-Za-z]{3,20}$/;
var emlregex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
var valid = true;


//var writehere=document.getElementById();

if (window.addEventListener) {
    window.addEventListener('load', Chk);
} else if (window.attachEvent) {
    window.attachEvent("onload", Chk);
}

function Chk() {

  var nmx = document.forms["modulo"]["nome"];
  var cnmx = document.forms["modulo"]["cognome"];
  var emlx = document.forms["modulo"]["email"];
  var usrnmx = document.forms["modulo"]["username"];
  var pwx = document.forms["modulo"]["password"];
  var rpwx = document.forms["modulo"]["ripetiPassword"];

    if (nmx.addEventListener) {
        nmx.addEventListener('blur', chkName,false);
    } else if (nmx.attachEvent) {
        nmx.attachEvent("onblur", chkName);
    }

    if (cnmx.addEventListener) {
        cnmx.addEventListener('blur', chkSurname,false);
    } else if (cnmx.attachEvent) {
        cnmx.attachEvent("onblur", chkSurname);
    }

    if (emlx.addEventListener) {
        emlx.addEventListener('blur', chkMail,false);
    } else if (emlx.attachEvent) {
        emlx.attachEvent("onblur", chkMail);
    }

    if (usrnmx.addEventListener) {
        usrnmx.addEventListener('blur', chkUsrnm,false);
    } else if (usrnmx.attachEvent) {
        usrnmx.attachEvent("onblur", chkUsrnm);
    }

    if (pwx.addEventListener) {
        pwx.addEventListener('blur', chkPwd,false);
    } else if (pwx.attachEvent) {
        pwx.attachEvent("onblur", chkPwd);
    }

    if (rpwx.addEventListener) {
        rpwx.addEventListener('blur', chkRpwd,false);
    } else if (rpwx.attachEvent) {
        rpwx.attachEvent("onblur", chkRpwd);
    }
}

function chkName() {
    var nm = document.forms["modulo"]["nome"].value;
    if (nmcnmregex.test(nm) == false) {
        valid = false;
    }
    if (!valid) {
        alert("Nome");
    }
}

function chkSurname() {
    var cnm = document.forms["modulo"]["cognome"].value;
    if (nmcnmregex.test(cnm) == false) {
        valid = false;
    }
    if (!valid) {
        alert("Cognome");
    }
}

function chkMail() {
    var eml = document.forms["modulo"]["email"].value;
    if (emlregex.test(eml) == false) {
        valid = false;
    }
    if (!valid) {
        alert("Mail");
    }
}

function chkUsrnm() {
    var usrnm = document.forms["modulo"]["username"].value;
    if (usrnmregex.test(usrnm) == false) {
        valid = false;
    }
    if (!valid) {
        alert("UserNome");
    }
}

function chkPwd() {
    var pw = document.forms["modulo"]["password"].value;
    if (pwdregex.test(pw) == false) {
        valid = false;
    }
    if (!valid) {
        alert("psw");
    }
}

function chkRpwd() {
    var pw = document.forms["modulo"]["password"].value;
    var rpw = document.forms["modulo"]["ripetiPassword"].value;
    if (rpw != pw) {
        valid = false;
    }
    if (!valid) {
        alert("rpsw");
    }
}
