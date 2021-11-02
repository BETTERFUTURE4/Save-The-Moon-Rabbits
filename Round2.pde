//-------변수-----------//
PFont mono;

//이미지//
PImage bow;
PImage cloudimg;
PImage clearbg;
PImage bg2;
PImage[] rabbitimg2 = new PImage[8];

//일반//
int count = 0;//마우스버튼 누른 횟수
int cMoveCount = 0;//구름 이동 횟수
boolean cloudFull = false;//화면 내 구름이 꽉찼는지 확인
int rabbitSeatCount = 16;

//활 관련//
float dir = 0; //활 회전 각도
float ang = dir - 135; //화살 회전 각도
float diag = 150 * sqrt(2);//토끼화살 길이
float rabix, rabiy;//화살 x, y좌표

//배열
int[][] musicR2 = new int[16][4];//(악보)음계 리스트

//기타
int musicj, musicz;//되돌리기 용

//-----------round2 설정-------------//
void setupRound2(){
  mono = createFont("h2sa1b.ttf", 64);
  
  //토끼 이미지 생성
  for(int i = 0; i < rabbitimg2.length; i++){
    rabbitimg2[i] = loadImage(i + "r.png");
    imageMode(CENTER);
  }
  
  bow = loadImage("bow.png");//활 생성
  cloudimg = loadImage("cloud_340_189.png");//구름 생성
  bg2 = loadImage("stage2.png");//2라운드 배경
  clearbg = loadImage("stage2bg.png");
  imageMode(CORNER);//코너를 기준으로 돌게 하기
  
  //토끼 오브젝트 생성
  for(int i = 0; i < rabbits.length; i++){
    rabbits[i] = new Rabbit(i, musicR1[i], 1050 + i * 100, true);//인덱스,사운드,posx,활동여부
  }
  
  //구름 오브젝트 생성
  for(int i = 0; i < clouds.length; i++){
    clouds[i] = new Cloud(100 + i * 480, (int) random(250,450));//posx, posy
  }
}

//-----------round2 실행-------------//
void drawRound2() {
  frameRate(60);
  colorMode(HSB, 100);
  background(bg2);
  
  //구름이 전부 이동했을 때-클리어
  if(cMoveCount == 4){
    image(clearbg, 0,0);
    image(clear, 750, 500);
    
    textFont(mono);
    text((cMoveCount) + " / 4", 100,height - 80);
    
    if(mousePressed){
      cMoveCount = 0;
      scene = 3;//사운드 제작 씬으로 이동
    }
  }

  
  //게임 오버
  if(count >= 99){
    //게임오버 글자 띄우기
    push();
    imageMode(CENTER);
    image(gameOver, width/2, 500);
    pop();
  }
  
  if(cMoveCount != 4 && count < 99){
    textFont(mono);
    text((cMoveCount + 1) + " / 4", 100,height - 80);
    
    //구름들 실행
    for(int i = 0; i < clouds.length; i++){ 
      clouds[i].draw();
    }
    
    //토끼들 실행
    for(int i = 0; i < rabbits.length; i++){ 
      rabbits[i].draw();
      //rabbits[i].cloudSet();//구름에 토끼 닿았는지 확인하는 함수
    }
    
    arrowRotate();//활 회전 함수
    cloudSeat();//구름 자리 확인
  }
  image(stop, 1710, 78);//스톱 버튼
}


//-------------------함수------------------//

//구름, 구름 위 토끼 이동 함수
void cloudSeat(){
  int cloudseat = 0;//구름에 찬 좌석 수
  
  //구름에 찬 좌석 수 세기
  for(int c = cMoveCount * 4; c < cMoveCount * 4 + 4; c++){
    for(int j = 0; j < 4; j++){
      if(musicR2[c][j] != -1){
        cloudseat += 1;
      }
    }
  }
  
  //만약 구름에 16개 좌석이 모두 차면
  if(cloudseat == 16){ ////////////////////////////////////////////////////dlgn 16
    cMoveCount += 1; //구름이동 횟수 추가
    cloudFull = true; //꽉찼다고 표시
    for(int i = 0; i < clouds.length; i++){
      clouds[i].posx += -width;
    }
    
    //토끼들 이동(치우기)
    for(int i = 0; i < rabbits.length; i++){
      if(rabbits[i].active == false){
        rabbits[i].clx += -width;
        rabbits[i].posx += -width;
      }
    }
    cloudFull = false;
  }
}

//활 각도 설정 함수
void arrowRotate(){
  dir = (mouseX * 180 / width) + 135; //활 회전용 각도
  ang = dir - 135;//화살 회전용 각도
  
  //활 회전
  push();
  translate(width/2 + 45, height - 20);
  rotate(radians(dir));
  image(bow,0,0, 150,150);
  pop();
  
  //화살 회전
  rabbits[count].posx = (width / 2 + 45) - cos(radians(ang)) * diag;
  rabbits[count].posy = (height - 20) - sin(radians(ang)) * diag;
  
  //화살 각도 설정&저장
  rabbits[count].ax = cos(radians(ang)) * diag;
  rabbits[count].ay = sin(radians(ang)) * diag;
}
