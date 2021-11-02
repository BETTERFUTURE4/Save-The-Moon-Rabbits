int ex2Count = 2;//이미지 개수
int ex2ImageIndex = 0;//인덱스

//배열
PImage[] ex2Images = new PImage[ex2Count];

//스킵 버튼
int ex2ButtonX = 212;
int ex2ButtonY = 78;
int ex2ButtonPx = 1600;
int ex2ButtonPy = 900;

//----------------------------------------------
void setupEx2() {
  size(1920, 1080);

  ex2Images = new PImage[ex2Count];
  ex2Images[0] = loadImage(0 + "ex2.png");
  ex2Images[1] = loadImage(1 + "ex2.png");
}

//---------------------------------------------
void drawEx2() {
  //배경
  background(ex2Images[ex2ImageIndex]);
  //스킵 버튼
  image(skip, ex2ButtonPx, ex2ButtonPy);
}
