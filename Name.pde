//-------변수-----------//
int state; 
String result;
String info;
PImage namebackground;

//--------------이름입력 씬 설정-----------------//
void setupName(){
  namebackground = loadImage("background_all.png");
  state = 0; 
  result = "";
  info = "Put Your Name And Press Enter \n";
}
//--------------이름입력 씬 실행-----------------//
void drawName(){
  background(namebackground); 
  colorMode(RGB, 256);
  frameRate(60);
  
  fill(255);
  textSize(64);
  textFont(mono);
  text (info + result + blinkChar(), 560, 500);
  
  if(dupleName) {
    textSize(30);
    text("The same name already exists. Please enter the other name",500,700); 
  }
}

String blinkChar() {
return (frameCount>>3 & 1) == 0 ? "_" : "";
}
