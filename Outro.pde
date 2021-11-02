int outroCount = 4;//아우트로 이미지 개수
int outroImageIndex = 0;//아우트로 인덱스

PImage[] outroImages;

int outroButtonX = 212;
int outroButtonY = 78;
int outroButtonPx = 1645;
int outroButtonPy = 940;

int playIndex = 0;

void setupOutro() {
  size(1920, 1080);

  outroImages = new PImage[outroCount];
  for (int i = 0; i < outroImages.length; i++) {
    outroImages[i] = loadImage(i + "outro.jpg");
  }
}

void drawOutro() {
  background(255);

  image(outroImages[outroImageIndex], 0, 0, width, height);
  image(skip, outroButtonPx, outroButtonPy);
  
  frameRate(3.6);
    if(playIndex < 64){
      playS(user[userIndex - 1].userSound[playIndex]);
      playD(user[userIndex - 1].userDrum[playIndex % 8]);
      playSS(subMusic[subOrder[user[userIndex - 1].userSub - 1][playIndex / 8]][playIndex % 8]);
      playIndex += 1;
    } else {
      playIndex = 0;
    }
}
