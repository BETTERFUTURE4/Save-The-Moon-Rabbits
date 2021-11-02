//-----음악------//
//이미지//
PImage bgS;//사운드씬 배경

PImage circlePlay;//플레이 버튼
PImage circlePause;//일시정지 버튼
PImage goToNext;//일시정지 버튼

PImage[] sub = new PImage[5];//서브사운드
PImage[] drumButton = new PImage[2];//드럼 버튼

//기본 사운드
SoundFile[] sound = new SoundFile[8];//사운드리스트 생성
int[] finalMusic = new int[]{5,6,7,2,0,5,2,5,3,6,2,5,3,0,0,2,5,6,7,2,0,5,2,5,3,2,1,6,3,0,0,2,5,6,7,2,0,5,2,5,3,6,2,5,3,0,0,2,2,1,2,3,6,7,5,3,2,1,2,3,1,0,0,0};//뮤직 만든 거 리스트 생성

//반주 사운드
SoundFile[] subSound = new SoundFile[16];
int[][] subMusic  = new int[][]{{8,10,12,15,0,12,10,8},{6,8,10,13,0,10,8,6},{4,6,8,11,0,8,6,4},{5,7,9,12,0,9,7,5}};
//0:도미솔도-솔미도
//1:라도미라-미도라
//2;파라도파-라도파
//3:솔시레솔-레시솔
int[][] subOrder = new int[][]{{0,1,2,3,0,1,3,0},{2,3,1,3,2,1,3,0},{0,0,3,0,0,0,3,0},{1,0,2,3,1,2,3,0},{2,1,2,3,2,0,3,0}};//반주 구성


//드럼 사운드
SoundFile[] drum = new SoundFile[2];

int[] drumMusic = new int[]{0,0,0,0,0,0,0,0};

boolean playing = false;//재생여부

//재생버튼 
int circleX = 660;
int circleY = 311;
int circlePx = 650;
int circlePy = 100;

//반주 음 버튼
int subX = 290;
int subY = 290;
int subPx = 250;
int subPy = 600;

int subCount = 1;

int click = 0;
int soundi = 0;

//드럼 버튼
int drumX = 290;
int drumY = 290;
int drumPx = 1350;
int drumPy = 600;

int drumCount = 0;

//사운드 확인 버튼
int goToNextX = 203;
int goToNextY = 97;
int goToNextPx = 1650;
int goToNextPy = 50;


///////////////-------------------설정-------------/////////////

void setupSound(){
  //--이미지--//
  bgS = loadImage("soundBg.png");//2라운드 배경
  //재생
  circlePlay = loadImage("circlePlay.png");//재생버튼
  circlePause = loadImage("circlePause.png");//일시정지 버튼
  
  //서브사운드
  for(int i = 0; i < sub.length; i++){
    sub[i] = loadImage((i+1) + "sub.png");
  }
  
  //드럼 버튼
  drumButton[0] = loadImage("0drum.png");//드럼 재생 버튼
  drumButton[1] = loadImage("1drum.png");//드럼 빼기 버튼
  
  //다음 씬 넘어가는 버튼
  goToNext = loadImage("endingbutton.png");//드럼 재생 버튼
  
  //음계 초기화
  for(int i = 0; i < 16; i++){
    for(int j = 0; j < 4; j++){
      musicR2[i][j] = -1;
    }
  }
  
  //사운드 리스트에 음계 파일 저장
  for(int i = 0; i < sound.length; i++){
    String filename = i + ".wav";
    sound[i] = new SoundFile(this, filename);
  }
  //반주 사운드 리스트에 음계 파일 저장
  for(int i = 0; i < subSound.length; i++){
    String filename = i + "s.wav";
    subSound[i] = new SoundFile(this, filename);
  }
  
  //드럼 사운드 리스트에 음계 파일 저장
  drum[0] = new SoundFile(this, "0.wav");
  drum[1] = new SoundFile(this, "드럼소리.wav");
  
}



///////////////-------------------실행-------------/////////////
void drawSound() {
  colorMode(RGB, 255);
  background(bgS);
  
  //재생 버튼
  if(playing == true && soundi < finalMusic.length){
    image(circlePause,circlePx,circlePy);
    musicPlay();
  } else {
    //재생
    image(circlePlay,circlePx,circlePy);
    frameRate(60);
  }
  
  //반주 버튼
  image(sub[subCount - 1],subPx, subPy);
  //드럼 버튼
  image(drumButton[drumCount],drumPx, drumPy);
  //사운드 확인 버튼
  image(goToNext,goToNextPx, goToNextPy);
}

/////////////---------------함수-------------------/////////////////

//음악 재생 함수
void musicPlay(){
  //사용자가 지정한 음계 차례로 재생
  frameRate(3.6);
  if(soundi < finalMusic.length){
    playS(finalMusic[soundi]);
    playD(drumMusic[soundi % 8]);
    playSS(subMusic[subOrder[subCount - 1][soundi / 8]][soundi % 8]);
    
    soundi += 1;
  }
}

//음계 리스트 속 특정 음계를 플레이하는 함수
void playS(int i){ //주 사운드 재생
  if(sound[i].isPlaying() == false){
    sound[i].amp(0.5);
    sound[i].play();
  }else{
    sound[i].stop();
  }
}

void playSS(int i){ //서브 사운드 재생
  subSound[i].play();
}

void playD(int i){ //드럼 사운드 재생
  if(drum[i].isPlaying() == false){
    drum[i].play();
  }else{
    drum[i].stop();
  }
}

//좀 더 음악처럼 보이게? 하는 함수
void stopSound(){
  //기존에 재생되던 것들 정지시키기)
  for(int i = 0; i < sound.length; i++){
    sound[i].stop();
  }
  for(int i = 0; i < subSound.length; i++){
    subSound[i].stop();
  }
  for(int i = 0; i < drum.length; i++){
    drum[i].stop();
  }
}
