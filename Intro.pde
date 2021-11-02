int introCount = 8;//인트로 이미지 개수
int introImageIndex = 0;//인트로 인덱스

//배열
PImage[] introImages = new PImage[introCount];

//스킵 버튼
int introButtonX = 1800;
int introButtonY = 50;
int introButtonPx = 1640;
int introButtonPy = 50;


void setupIntro() {
  size(1920, 1080);

  introImages = new PImage[introCount];
  for (int i = 0; i < introImages.length; i++) {
    introImages[i] = loadImage(i + "intro.jpg");
  }
}

void drawIntro() {
  background(255);

  image(introImages[introImageIndex], 0, 0, 1920, 1080);
  
  image(skip, introButtonPx, introButtonPy);
}
