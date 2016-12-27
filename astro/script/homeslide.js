var slideIndex = 1;
document.addEventListener('DOMContentLoaded', function() {
showDivs(1);
}, false);


function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = document.querySelectorAll(".imgslide");
  var tot=x.length;
  if (n > x.length) {slideIndex = 1;}
  if (n < 1) {slideIndex = x.length;}
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";
  }
  x[slideIndex-1].style.display = "block";
  var g=document.getElementById("number");
  g.innerHTML=slideIndex+"/"+tot;
}
