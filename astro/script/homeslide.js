var slideIndex = 1;

function leftButtonDivs(e){
    if(e.keyCode==13||e.which==13){
      leftDivs();
    }
}

function rightButtonDivs(){
  if(e.keyCode==13||e.which==13){
    rightDivs();
  }
}




function leftDivs(){
  plusDivs(-1);
}

function rightDivs(){
  plusDivs(1);

}

function plusDivs(n) {
  showDivs(slideIndex += n,true);
}

function initDivs(){
  showDivs(1,false);
}

function showDivs(n,isNotOnLoad) {
  var i;
  var x = document.querySelectorAll(".imgslide");
  var tot=x.length;
  if (n > x.length) {slideIndex = 1;}
  if (n < 1) {slideIndex = x.length;}
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";
  }
  x[slideIndex-1].style.display = "block";
  if(isNotOnLoad){
    x[slideIndex-1].focus();
  }
  var g=document.getElementById("number");
  g.innerHTML="".concat(slideIndex,"/",tot);
}
