import processing.sound.*;

//----변수----//
int scene = 0; //씬

boolean dupleName = false;

//이미지
PImage clear;
PImage gameOver;

//////------------------------기본설정---------------------------//////
void setup(){
  size(1920,1080);
  
  clear = loadImage("clear.png");//클리어 글자
  gameOver = loadImage("gameOver.png");//게임오버 글자
  
  setupUser();
  
  setupStart();
  setupRound1();
  setupRound2();
  setupSound();
  setupIntro();
  setupOutro();
  setupName();
  setupSearch();
  setupEx1();
  setupEx2();

}

//////-------------------------------실행-------------------------------//////

void draw(){
  switch(scene){
    case 0:
      drawStart();//메인화면
      break;
    case 1:
      drawRound1();//1라운드
      break;
    case 2:
      drawRound2();//2라운드
      break;
    case 3:
      drawSound();//사운드 제작 파트
      break; 
    case 4:
      drawIntro();//인트로 넣을 예정
      break;
    case 5:
      drawOutro();//아웃트로 넣을 예정
      break;
    case 6:
      drawName();//이름 입력 파트
      break;
    case 7:
      drawSearch();//음악 검색
      break;
    case 8:
      drawEx1();//1라운드 설명
      break;
    case 9:
      drawEx2();//2라운드 설명
      break;
  }
}

//////////////////////////////함수들////////////////////////////////////

//해당하는 구역에 마우스가 있는지 확인하는 함수
boolean inButtonR(int x, int y, int px, int py){
  if(mouseX >= px && mouseX <= px + x && mouseY >= py && mouseY <= py + y){
    return true;
  }else{
    return false;
  }
}

///////////----------------------키--------------------////////////
void keyPressed(){
  // 음악 한번에 끄기
  if (keyCode == DOWN){ 
    stopSound();
    redraw();
    delay(2000);
  }

  
  //씬6-이름입력
  if(scene == 6){
    if (key==ENTER||key==RETURN) {
      dupleName = false;
      for(int i = 0; i <= userIndex; i++){
        if(result.equals(user[i].name) == true){
          dupleName = true;
        }
      }
      if(dupleName == false){
        user[userIndex].name = result; //유저값에 이름 저장
        println("이름입력: " + user[userIndex].name);
        scene = 4; //intro로 이동
      } else {
        result = "";
      }
    } else if (key == BACKSPACE) {
      result = result.substring(0, max(0, result.length() - 1)); //한 글자 지우기
    }
    else
    result = result + key;
  }
  //씬7-음악검색
  if(scene == 7){
    if (key==ENTER||key==RETURN) {
      //음악 검색됨
    } else if (key == BACKSPACE) {
      searchResult = searchResult.substring(0, max(0, searchResult.length() - 1));
    }
    else {
    searchResult = searchResult + key;
    }
  }
}

//////////////---------------------마우스------------------///////////////////

void mousePressed(){
  //-----------씬 0(메인화면)
  if(scene == 0) {
    if(inButtonR(startButtonX, startButtonY, 163,163)){ //스타트 버튼 누르면
      scene = 6;//이름입력 씬 이동
    } else if(inButtonR(startSearchButtonX, startSearchButtonY,163,163)){ //검색 버튼 누르면
      scene = 7;//검색 씬 이동
    }
  }
  
  //-----------스탑 버튼(라운드 1,2)
  if((scene == 1 || scene == 2) && inButtonR(95, 76, 1710,78) ){ ////////////////////////숫자 건드리면 안돼요.
    stopSound();
    delay(2000);
    scene = 0;//메인화면으로 이동
  }
  
  //-----------씬 2(2라운드)
  if(scene == 2) {
    if(cMoveCount != 4 && count < 99){
      if(count == 0 || rabbits[count - 1].active == false || rabbits[count - 1].posy >= height - 20){
        //남아있는 토끼들 한 칸씩 이동
        for(int i = count + 1; i < rabbits.length; i++){
          rabbits[i].sidewalk();
        }
        //카운트 +1
        if(count < 99){
          count += 1;
        }
      }
    } else if (count >= 99) {
      scene = 0;//메인메뉴로 이동
    } else if (cMoveCount == 4) {
      stopSound();
      delay(2000);
      scene = 3;//사운드 제작 씬으로 이동
    }
  }
  
  //------------씬 3(사운드)
  //마우스가 재생버튼구역 안에 있으면
  if(scene == 3){
    if(inButtonR(circleX, circleY,circlePx, circlePy)){
      if(playing == false){
        //circleColor = color(0, 0, 0);
        //fill(circleColor);
        //ellipse(circleX, circleY, circleSize, circleSize);
        
        playing = true;
      } else {
        playing = false;
        soundi = 0;
        frameRate(60);
      }
    }
    //마우스가 반주버튼구역에 있으면
    if(inButtonR(subX, subY, subPx, subPy)){
      if(subCount != 5){
        subCount += 1;
      } else {
        subCount = 1;
      }
      sound[subCount].play();
    }
    //마우스가 드럼버튼구역에 있으면
    if(inButtonR(drumX, drumY, drumPx, drumPy)){
      if(drumCount == 0){
        drum[1].play();
        drumCount = 1;
        for(int i = 0; i < drumMusic.length; i++) {
          drumMusic[i] = int(random(2));
        }
      } else {
        drumCount = 0;
        for(int i = 0; i < drumMusic.length; i++) {
          drumMusic[i] = 0;
        }
      }
    }
    //마우스가 사운드 확인버튼구역에 있으면
    if(inButtonR(goToNextX, goToNextY, goToNextPx, goToNextPy)){
      for(int i = 0; i < finalMusic.length; i++){
        user[userIndex].userSound[i] = finalMusic[i];//유저 음악 저장소에 기본음들 저장
        user[userIndex].userDrum[i % 8] = drumMusic[i % 8];//드럼 음 저장
      }
      user[userIndex].userSub = subCount;//반주음 저장

      println(userIndex);
      println("사운드 확인버튼: " + user[userIndex].userSub);
      
      userIndex += 1;//유저 음악 저장완료
      subCount = 1;
      drumCount = 0;
      stopSound();
      delay(1000);
      scene = 5;//아웃트로 로 이동
    }
  }
  //----------씬4(인트로)
  if(scene == 4){
    if (inButtonR(introButtonPx,introButtonPy, 212,78)) {
      
      ex1ImageIndex = -1;//////////////////
      
      scene = 8;//1라운드 설명 시작
    } else {
      introImageIndex += 1;
      if (introImageIndex >= introImages.length) {
        introImageIndex = 0;
        
        ex1ImageIndex = -1;//////////////////
        
        scene = 8;//1라운드 설명 시작
      }
    }
  }
  
  //----------씬5(아우트로)
  if(scene == 5){
    if (inButtonR(outroButtonX,outroButtonY, outroButtonPx, outroButtonPy)) {     
      stopSound();
      scene = 0;//메인화면 돌아가기
    } else {
      outroImageIndex += 1;
      if (outroImageIndex >= outroImages.length) {
        outroImageIndex = outroCount - 1;
        stopSound();
        delay(2000);
        scene = 0;//메인화면 돌아가기
      }
    }
  }
  
  //----------씬7(음악검색)
  if(scene == 7){
    //검색 버튼을 누르면
    if(inButtonR(searchSx, searchSy, searchX, searchY)){
      Boolean searchFind = false;
      if(userIndex != 0){
        println("user: " + user[userIndex - 1].name);
        println("search: " + searchResult);
        for(int i = 0; i < userIndex; i++){
          if (searchResult.equals(user[i].name) == true){ //검색내용과 유저 이름이 일치하면
            //결과, 버튼 생성
            resultOk = true;
            println("resultOk");
            searchFind = true;
            
            //결과값에 해당하는 인덱스 저장
            resultIndex = i;
          }
        }
        //검색결과가 없으면
        if(searchFind == false){
          resultOk = false;
        }
      }
    }
    //뒤로가기 버튼 누르면
    if(inButtonR(backButtonX, backButtonY, backButtonPx, backButtonPy)){
      
      playSearchedIndex = 0;
      resultOk = false;
      playSearched = false;
      resultPlayOk = false;
      searchResult = "";
      
      stopSound();
      delay(2000);
      scene = 0;//메인화면으로 이동
    }
    
    //재생 버튼을 누르면
    if(inButtonR(searchPlayX, searchPlayY, searchPlayPx, searchPlayPy)){
      if(!playSearched){
        playSearched = true;
        
        resultPlayOk = true;
      } else {
        playSearchedIndex = 0;
        playSearched = false;
        
        resultPlayOk = false;
        
      }
    }
  }
  
  //----------씬8(1라운드 설명)
  if(scene == 8){
    stopSound();
    if (inButtonR(ex1ButtonX,ex1ButtonY, ex1ButtonPx, ex1ButtonPy)) {
      scene = 1;//1라운드 시작
    } else {
      ex1ImageIndex += 1;
      if (ex1ImageIndex == ex1Count) {
        ex1ImageIndex = 0;
        scene = 1;//1라운드 시작
      }
    }
  }
  
  //----------씬9(2라운드 설명)
  if(scene == 9){
    if (inButtonR(ex2ButtonX,ex2ButtonY, ex2ButtonPx, ex2ButtonPy)) {
      scene = 2;//1라운드 시작
    } else {
      ex2ImageIndex += 1;
      if (ex2ImageIndex == ex2Count) {
        ex2ImageIndex = 0;
        scene = 2;//1라운드 시작
      }
    }
  }
  
}
