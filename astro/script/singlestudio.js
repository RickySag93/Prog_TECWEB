/**
 * Created by RiccardoSaggese on 06/12/16.
 */

var slideIndex = 1;
var y=document.getElementsByClassName("otherimages");
y.style.display="block";
showDivs(slideIndex);

function plusDivs(n) {
    showDivs(slideIndex += n);
}

function currentDiv(n) {
    showDivs(slideIndex = n);
}

function showDivs(n) {
    var i;
    var x = document.getElementsByClassName("imgslide");
    var dots = document.getElementsByClassName("imageproperties");
    if (n > x.length) {slideIndex = 1}
    if (n < 1) {slideIndex = x.length}
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
    }
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace("opacity", " ");
    }
    x[slideIndex-1].style.display = "block";
    for (i = 0; i < dots.length; i++) {
        if(i!=slideIndex-1)
          dots[i].className += "opacity";
    }
}
