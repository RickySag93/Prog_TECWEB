var slideIndex = 1;
if(window.addEventListener){
  window.addEventListener('load',initDivs);
}
else if(window.attachEvent){
  window.attachEvent("onload",initDivs);
}



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
  var l=document.getElementById("slidebuttonleft");
  var r=document.getElementById("slidebuttonright");
  if(l.addEventListener){
  l.addEventListener('click',leftDivs);
}else if(l.attachEvent){
  l.attachEvent("onclick",leftDivs)
}
  if(r.addEventListener){
  r.addEventListener('click',rightDivs);
}else if(r.attachEvent){
    r.attachEvent("onclick",rightDivs);
  }
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
