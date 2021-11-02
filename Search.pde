//-------변수-----------//

String searchResult = "";

//검색 버튼
int searchX = 1341;
int searchY = 623;
int searchSx = 144;//여기서만 sx
int searchSy = 62;

//검색결과 재생 버튼
int searchPlayX = 115;
int searchPlayY = 74;
int searchPlayPx = 1500;
int searchPlayPy = 240;

boolean playSearched = false;
int playSearchedIndex = 0;

boolean resultOk = false;
boolean resultPlayOk = false;
int resultIndex = 0;

//뒤로가기 버튼
int backButtonX = 213;
int backButtonY = 78;
int backButtonPx = 50;
int backButtonPy = 50;

//이미지
PImage searchbackground;
PImage searchButton;//검색버튼
PImage backButton;//뒤로가기 버튼
PImage playButton;
PImage pauseButton;

void setupSearch(){
  searchbackground = loadImage("searchbg.png");
  searchButton = loadImage("searchSButton.png");
  backButton = loadImage("backbutton.png");
  playButton = loadImage("playbutton2.png");
  pauseButton = loadImage("pausebutton2.png");
}

//---------검색 씬 실행---------------//
void drawSearch(){
  background(searchbackground);
  
  //검색 버튼
  image(searchButton,searchX, searchY);
  
  //뒤로가기 버튼
  image(backButton, backButtonPx, backButtonPy);

  //이름입력 텍스트
  fill(0);
  textFont(mono);
  textSize(32);
  text (searchResult + blinkChar(), searchX - 620, searchY + 50);
  
  //검색결과
  if(resultOk == true){
    text ("Name: " + user[resultIndex].name, 1145, 318); //검색결과
    //음악재생 버튼 만들기
    if(resultPlayOk == false){
      image(playButton, searchPlayPx, searchPlayPy);
    } else {
      image(pauseButton, searchPlayPx, searchPlayPy);
    }
    
  } else {
    text("No found", 1155, 318); //검색결과
  }
  
  if(playSearched){
    //사용자가 지정한 음계 차례로 재생
    frameRate(3.6);
    if(playSearchedIndex < 64){
      playS(user[resultIndex].userSound[playSearchedIndex]);
      playD(user[resultIndex].userDrum[playSearchedIndex % 8]);
      playSS(subMusic[subOrder[user[resultIndex].userSub - 1][playSearchedIndex / 8]][playSearchedIndex % 8]);
      playSearchedIndex += 1;
    } else {
      playSearchedIndex = 0;
    }
  }
  
}
