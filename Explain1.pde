int ex1Count = 3;//이미지 개수
int ex1ImageIndex = 0;//인덱스

//배열
PImage[] ex1Images = new PImage[ex1Count];
PImage skip;


//스킵 버튼
int ex1ButtonX = 212;
int ex1ButtonY = 78;
int ex1ButtonPx = 1600;
int ex1ButtonPy = 900;

//----------------------------------------------
void setupEx1() {
  size(1920, 1080);

  ex1Images = new PImage[ex1Count];
  ex1Images[0] = loadImage(0 + "ex1.png");
  ex1Images[1] = loadImage(1 + "ex1.png");
  ex1Images[2] = loadImage(2 + "ex1.png");
  skip = loadImage("skip.png");
}

//----------------------------------------------
void drawEx1() {
  //배경
  println("ex1 :" + ex1ImageIndex);/////////////////////////
  background(ex1Images[ex1ImageIndex]);
  //스킵 버튼
  image(skip, ex1ButtonPx, ex1ButtonPy);
}
