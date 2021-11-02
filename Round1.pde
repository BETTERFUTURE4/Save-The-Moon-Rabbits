//-------변수-----------//

//이미지//
PImage background;
PImage rabbitcount;
PImage life1;
PImage life2;
PImage life3;
PImage stop;
PImage basket;
PImage devilrabbit;
PImage[] rabbitImg1 = new PImage[8];

//일반//
int score = 0;
int life = 3;

//위치 관련//
float posDX, posDY;
float dirDY;

int basketPos;
int basketWidth;
int basketHeight;

int rabbitNum = 480;//------------------------------------------------------------------------------------------그냥토끼 숫자!!!!!!!!!! 래빗넘 이 변수 수정해주세요

//배열
RabbitR1[] r = new RabbitR1[rabbitNum];
Devil[] d = new Devil[20];//악마토끼

int[] musicR1 = new int[basketRabbit];//받은토끼들 음 배열

//-----------round1 설정-------------//
void setupRound1() {
  size(1920, 1080);

  rabbitcount = loadImage("redRabbit.png");
  stop = loadImage("stop.png");
  background = loadImage("stage1bg.png");
  life1 = loadImage("1_life.png");
  life2 = loadImage("2_life.png");
  life3 = loadImage("3_life.png");
  basket = loadImage("basket_240_108.png");
  
  
  rabbitSetup();

  for (int i = 0; i < 20; i++) {
    d[i] = new Devil();
  }

  basketWidth = 240;
  basketHeight = 108;
  
}

//-----------round1 실행-------------//
void drawRound1() {
  frameRate(20);

  image(background, 0, 0, 1920, 1080);
  image(stop, 1710, 78);
  
  if(life >= 3){
    image(life1, 1570, 83, 80, 60);
  } 
  if(life >= 2){
    image(life2, 1470, 83, 80, 60);
  } 
  if(life >= 1){
    image(life3, 1370, 83, 80, 60);
  }
  
  if(score < 100 && life != 0 && rabbitHeightFinish() == false){
    for (int i = 0; i < r.length; i++) {
      r[i].update();
      r[i].draw();
      r[i].scoreupdate();
    }
  
    for (int i = 0; i < d.length; i++) {
      d[i].update();
      d[i].lifeupdate();
      d[i].draw();
    }
    push();
    imageMode(CENTER);
    basketPos = mouseX;
    image(basket, basketPos, height-(basketHeight/2), basketWidth, basketHeight);
    pop();
  }

image(rabbitcount, 60, 935);
  textSize(50);
  fill(255);
  textAlign(LEFT);
  textFont(mono);
  text(score + " / 100", 130, 1010);
  
  //클리어
  if(score == 100){
    //모인 토끼 값을 2라운드에 저장
    for(int i = 0; i < musicR1.length; i++){
      rabbits[i].s = musicR1[i];
    }
    //클리어 글자 띄우기
    image(clear, 750, 500);
    if(mousePressed){
      stopSound();
      score = 0;
      scene = 9;//2라운드 설명으로 이동
    }
  }
  
  //게임오버
  if(life <= 0 || rabbitHeightFinish() == true){
    //게임오버 글자 띄우기
    push();
    imageMode(CENTER);
    image(gameOver, width/2, 500);
    pop();
    
    if(mousePressed){
      stopSound();
      life = 3;
      scene = 0;//처음으로 이동
    }
  }
}
////------토끼들 다 내려왔는지 확인------////
boolean rabbitHeightFinish(){
  int highst = 0;
  for(int i = 0; i < rabbitNum; i++){
    if(r[i].posY > height + 1000){
      highst += 1;
    }
  }
  if(highst == rabbitNum){
    return true;
  } else {
    return false;
  }
}



///-------------------악마 클래스---------------------///
class Devil {
  float posDX, posDY;
  float dirDY;

  Devil() {
    posDX = random(200, 1720);
    posDY = random(-50000, -5000);
    dirDY = 80;
  }

  void update() {
    posDY += dirDY;
  }
  
  void lifeupdate() {
    if (posDY > height-basketHeight && posDY < height) {
      if (posDX > basketPos-basketWidth/2 && posDX < basketPos+basketWidth/2) {
        // life disappear?
        life -= 1;
      }
    }
  }

  void draw() {
    devilrabbit = loadImage("8_img.png");
    image(devilrabbit, posDX, posDY, 80, 104);
  }
}

void rabbitSetup() {
  for (int i = 0; i < rabbitImg1.length; i++) {
    rabbitImg1[i] = loadImage(i + "_img.png");
  }

  for (int i = 0; i < r.length; i++) {
    r[i] = new RabbitR1();
  }
}

//-------------------------1라운드 토끼 클래스----------------------------------//
class RabbitR1 {
  float posX, posY;
  float dirY;
  int xsize = 80;
  int ysize = 104;
  boolean catchR;

  int colorR = (int)random(8);

  RabbitR1() {
    posX = random(200, 1720);
    posY = random(-30000, 0);
    dirY = random(40, 80);/////////////////속도
    catchR = false;//토끼 바구니 들어갔는지 여부
  }

  void update() {
    posY += dirY;
  }

  void scoreupdate() {
    if (posY > height-basketHeight && posY < height) {
      if (posX > basketPos-basketWidth/2 && posX < basketPos+basketWidth/2 && score < 100 && this.catchR == false) {
        musicR1[score] = this.colorR;//음 저장
        score = score + 1;
        playS(colorR);
        //sound[colorR].play();
        println("라운드1: " + user[userIndex].userSub);
        this.catchR = true;
      }
    }
    
  }

  void draw() {
    image(rabbitImg1[colorR], posX, posY, xsize, ysize);
  }
}
