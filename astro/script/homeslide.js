var slideIndex = 1;
var l=document.getElementById("slidebuttonleft");
var r=document.getElementById("slidebuttonright");
if(l.addEventListener){
  window.addEventListener('load',initDivs);
  l.addEventListener('click',leftDivs);
  r.addEventListener('click',rightDivs);
}
/*else if(l.attachEvent){
  window.attachEvent("onload",initDivs);
  l.attachEvent("onclick",leftDivs);
  r.attachEvent("onclick",rightDivs);

}*/


function leftDivs(){
  plusDivs(-1);
}

function rightDivs(){
  plusDivs(1);

}

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function initDivs(){
  showDivs(1);
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
  g.innerHTML="".concat(slideIndex,"/",tot);
}
