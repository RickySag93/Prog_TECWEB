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
  showDivs(slideIndex += n);
}

function initDivs(){
  showDivs(1);
}

function showDivs(n) {
  var i;
  var x = document.querySelectorAll(".imgslide");
  var y = document.querySelectorAll(".slide_didasc");
  var z = document.querySelectorAll(".imgslide_a");

  var tot=x.length;
  if (n > x.length) {slideIndex = 1;}
  if (n < 1) {slideIndex = x.length;}
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";
     y[i].style.display = "none";
     z[i].style.display = "none";
  }
  x[slideIndex-1].style.display = "block";
  y[slideIndex-1].style.display = "block";
  z[slideIndex-1].style.display = "block";
  var g=document.getElementById("number");
  g.innerHTML="".concat(slideIndex,"/",tot);
}
