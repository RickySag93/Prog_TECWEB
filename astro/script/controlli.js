var pwdregex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,32}$/;
var usrnmregex = /^[A-Za-z]{1}[A-Za-z0-9]{4,20}$/;
var nmcnmregex = /^[A-Za-z]{3,20}$/;
var emlregex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;


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

    writeError("");

    if (nmx.addEventListener) {
        nmx.addEventListener('blur', chkName, false);
    } else if (nmx.attachEvent) {
        nmx.attachEvent("onblur", chkName);
    }

    if (cnmx.addEventListener) {
        cnmx.addEventListener('blur', chkSurname, false);
    } else if (cnmx.attachEvent) {
        cnmx.attachEvent("onblur", chkSurname);
    }

    if (emlx.addEventListener) {
        emlx.addEventListener('blur', chkMail, false);
    } else if (emlx.attachEvent) {
        emlx.attachEvent("onblur", chkMail);
    }

    if (usrnmx.addEventListener) {
        usrnmx.addEventListener('blur', chkUsrnm, false);
    } else if (usrnmx.attachEvent) {
        usrnmx.attachEvent("onblur", chkUsrnm);
    }

    if (pwx.addEventListener) {
        pwx.addEventListener('blur', chkPwd, false);
    } else if (pwx.attachEvent) {
        pwx.attachEvent("onblur", chkPwd);
    }

    if (rpwx.addEventListener) {
        rpwx.addEventListener('blur', chkRpwd, false);
    } else if (rpwx.attachEvent) {
        rpwx.attachEvent("onblur", chkRpwd);
    }
}

function writeError(str) {
    var loc = document.getElementById("aiuti_reg");
    var elem = document.getElementById("el_error");
    if (elem) {
        loc.removeChild(elem);
    }
    loc.innerHTML += str;
    if (str != "") {
        var foc = document.getElementById("el_error");
        if (foc) {
            foc.focus();
        }
    }

}


function chkName() {
    var valid = true;
    var nm = document.forms["modulo"]["nome"].value;
    if (nmcnmregex.test(nm) == false) {
        valid = false;
    }
    if (!valid) {
        writeError('<p id="el_error" tabindex="0"><strong> Nome non valido. </strong></p>');
    }
}

function chkSurname() {
    var valid = true;
    var cnm = document.forms["modulo"]["cognome"].value;
    if (nmcnmregex.test(cnm) == false) {
        valid = false;
    }
    if (!valid) {
        writeError('<p id="el_error" tabindex="0"> <strong> Cognome non valido. </strong> </p>');
    }
}

function chkMail() {
    var valid = true;
    var eml = document.forms["modulo"]["email"].value;
    if (emlregex.test(eml) == false) {
        valid = false;
    }
    if (!valid) {
        writeError(' <p id="el_error" tabindex="0"> <strong> <span xml:lang="en"> Mail </span> non valida. </strong> </p> ');
    }
}

function chkUsrnm() {
    var valid = true;
    var usrnm = document.forms["modulo"]["username"].value;
    if (usrnmregex.test(usrnm) == false) {
        valid = false;
    }
    if (!valid) {
        writeError('<p id="el_error" tabindex="0"> <strong> <span xml:lang="en"> Username </span> non valido. </strong> </p>');
    }
}

function chkPwd() {
    var valid = true;
    var pw = document.forms["modulo"]["password"].value;
    if (pwdregex.test(pw) == false) {
        valid = false;
    }
    if (!valid) {
        writeError('<p id="el_error" tabindex="0"> <strong> <span xml:lang="en"> Password </span> non valida. </strong> </p>');
    }
}

function chkRpwd() {
    var valid = true;
    var pw = document.forms["modulo"]["password"].value;
    var rpw = document.forms["modulo"]["ripetiPassword"].value;
    if (rpw != pw) {
        valid = false;
    }
    if (!valid) {
        writeError('<p id="el_error" tabindex="0"> <strong> <span xml:lang="en"> Password </span> e Ripeti <span xml:lang="en"> password </span> non corrispondono. </strong> </p>');
    }
}
