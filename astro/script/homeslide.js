var slideIndex = 1;
if (window.addEventListener) {
    window.addEventListener('load', initDivs);
} else if (window.attachEvent) {
    window.attachEvent("onload", initDivs);
}



function leftButtonDivs(e) {
    if (e.keyCode == 13 || e.which == 13) {
        leftDivs(e);
    }
}

function rightButtonDivs(e) {
    if (e.keyCode == 13 || e.which == 13) {
        rightDivs(e);
    }
}




function leftDivs(event) {
  event.preventDefault ? event.preventDefault() : (event.returnValue = false);
    plusDivs(-1);
}

function rightDivs(event) {
    event.preventDefault ? event.preventDefault() : (event.returnValue = false);
    plusDivs(1);
}

function plusDivs(n) {
    showDivs(slideIndex += n);
}

function initDivs() {
    showDivs(1);
    var l = document.getElementById("slidebuttonleft");
    var r = document.getElementById("slidebuttonright");
    if (l.addEventListener) {
        l.addEventListener('click', leftDivs);
        l.addEventListener('keypress', leftButtonDivs);
    } else if (l.attachEvent) {
        l.attachEvent("onclick", leftDivs);
        l.attachEvent("onkeypress", leftButtonDivs);
    }
    if (r.addEventListener) {
        r.addEventListener('click', rightDivs);
        r.addEventListener('keypress', rightButtonDivs);
    } else if (r.attachEvent) {
        r.attachEvent("onclick", rightDivs);
        r.attachEvent("onkeypress", rightButtonDivs);
    }
}

function showDivs(n) {
    var i;
    var x = document.querySelectorAll(".imgslide");
    var y = document.querySelectorAll(".slide_didasc");
    var z = document.querySelectorAll(".imgslide_a");

    var tot = x.length;
    if (n > x.length) {
        slideIndex = 1;
    }
    if (n < 1) {
        slideIndex = x.length;
    }
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
        y[i].style.display = "none";
        z[i].style.display = "none";
    }
    x[slideIndex - 1].style.display = "block";
    y[slideIndex - 1].style.display = "block";
    z[slideIndex - 1].style.display = "block";
    var g = document.getElementById("number");
    g.innerHTML = "".concat(slideIndex, "/", tot);
}
