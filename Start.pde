//변수//

int startButtonX = 690;
int startButtonY = 810;

int startSearchButtonX = 990;
int startSearchButtonY = 810;

//음악
int StartSoundIndex = 0;//대분류
int userSoundIndex = 0;

//이미지
PImage startbackground;
PImage start;
PImage search;

///-----------------메인화면 설정-----------------////
void setupStart(){
  startbackground = loadImage("Start.png");//시작화면
  start = loadImage("startButton.png");
  search = loadImage("searchButton.png");
}

///-----------------메인화면 실행-----------------////
void drawStart(){
  image(startbackground,0,0, width, height);
  image(start, startButtonX, startButtonY); //시작 버튼
  image(search, startSearchButtonX, startSearchButtonY); //검색 버튼
  
  
  //음악재생(bgm)
  
  //사용자가 지정한 음계 차례로 재생
  frameRate(3.6);
  if(StartSoundIndex < userIndex){
    if(userSoundIndex < 64){
      playS(user[StartSoundIndex].userSound[userSoundIndex]);
      playD(user[StartSoundIndex].userDrum[userSoundIndex % 8]);
      playSS(subMusic[subOrder[user[StartSoundIndex].userSub - 1][userSoundIndex / 8]][userSoundIndex % 8]);
      userSoundIndex += 1;
    } else {
      userSoundIndex = 0;
      StartSoundIndex += 1;
    }
  } else {
    StartSoundIndex = 0;
  }
  
  fill(255);
  textFont(mono);
  textSize(20);
  text("This song is made by: " + user[StartSoundIndex].name, 30, 30);
  
  //초기화----------------------------------------------------------------------------------------------!!!!!!!!!!!!
  
  //인트로
  introImageIndex = 0;//인트로 인덱스
  
  //이름입력
  state = 0; 
  result = "";
  
  //아우트로
  outroImageIndex = 0;//아우트로 인덱스
  
  //1라운드
  score = 0;
  posDX = 0;
  posDY = 0;
  dirDY = 0;
  basketPos = 0;
  life = 3;
  basketWidth = 240;
  basketHeight = 108;
  
  for (int i = 0; i < rabbitImg1.length; i++) {
    rabbitImg1[i] = loadImage(i + "_img.png");
  }

  for (int i = 0; i < r.length; i++) {
    r[i] = new RabbitR1();
  }
  
  //2라운드
  count = 0;//마우스버튼 누른 횟수
  cMoveCount = 0;//구름 이동 횟수
  cloudFull = false;//화면 내 구름이 꽉찼는지 확인
  rabbitSeatCount = 16;

  dir = 0; //활 회전 각도
  ang = dir - 135; //화살 회전 각도
  rabix = 0;
  rabiy = 0;//화살 x, y좌표
  
  //토끼 오브젝트 생성
  for(int i = 0; i < rabbits.length; i++){
    rabbits[i] = new Rabbit(i,musicR1[i], 1050 + i * 100, true);//인덱스,사운드,posx,활동여부
  }
  
  //구름 오브젝트 생성
  for(int i = 0; i < clouds.length; i++){
    clouds[i] = new Cloud(100 + i * 480, (int) random(250,450));//posx, posy
  }
  
  //사운드
  //음계 초기화
  for(int i = 0; i < basketRabbit; i++){
    musicR1[i] = -1;
  }
  for(int i = 0; i < 16; i++){
    for(int j = 0; j < 4; j++){
      musicR2[i][j] = -1;
    }
  }
  
  //검색
  //searchResult = "";
  //resultOk = false;
  //resultIndex = 0;
  
  
}
