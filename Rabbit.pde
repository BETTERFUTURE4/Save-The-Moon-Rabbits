//////round 2 토끼 클래스//////

int basketRabbit = 100; // 바구니에 받을 토끼 수---------------------------------------------------------------------------------------------------------
int cloudJumpIndex = -1;
int cloudj, cloudz;
boolean cloudB = false;


Rabbit[] rabbits = new Rabbit[basketRabbit];//토끼 클래스 리스트 생성

class Rabbit{
  boolean active = true; //고정/비고정 여부
  int index;//오브젝트 인덱스 저장
  int s = -1;
  float posx, ax, ay, clx, cly; //기본 x,y좌표 와, 화살 쏜 뒤 첫 x,y 각도와, 구름에 앉을 때의 x,y좌표
  float posy = 970;
  
  float speed = 0;//화살 포물선 스피드
  
  //오브젝트 변수 할당//
  Rabbit(int _index, int _sound, int _posx, boolean _active){
    this.index = _index;
    this.s = _sound;
    this.posx = _posx;
    this.active = _active;
  }
  //--------//
  
  //////함수들//////
  
  //////토끼 실행 함수//////
  void draw(){
    
    if(posy < height - 21){
      image(rabbitimg2[s],posx - 40,posy - 52, 80,104);
    }
    
    cloudSet();
    
    if(index <= count && posy < height - 20 && active == true && cloudFull == false){
      fly();
    }
    if (active == false){
      posx = clx;
      posy = cly;
    }
  }
  
  //토끼를 구름에 고정하는 함수(구름에 토끼 닿았는지 확인하는 함수)
  void cloudSet(){
    
    if(cloudB == true && cloudJumpIndex != -1){
      if(cloudJumpIndex <= 1){
        posy += - 20;
        clouds[cloudj].seat[cloudz] += -20;
        cloudJumpIndex += 1;
        println("go");
      } else if(cloudJumpIndex < 3){
        posy += 20;
        clouds[cloudj].seat[cloudz] += 20;
        cloudJumpIndex += 1;
      } else if(cloudJumpIndex == 3){
        posy += 20;
        clouds[cloudj].seat[cloudz] += 20;
        cloudJumpIndex = -1;
      }
    }
    
    for(int j = (cMoveCount * 4); j < (cMoveCount * 4) + 4; j++){ //화면에 나타나는 구름들에서
      //특정 구름과 접촉했을 때
      if(posy >= clouds[j].posy && posy <= clouds[j].posy + 189 && posx >= clouds[j].posx && posx < clouds[j].posx + 340){
        for(int z = 0; z < clouds[j].seat.length; z++){ //구름에서 부딪친 좌석들에서
          //특정 구름 내 좌석에 부딪치면
          if(posx >= clouds[j].seat[z] && posx <= clouds[j].seat[z] + 120 && musicR2[j][z] == -1 && active == true){
            active = false;
            //float xd = posx - clouds[j].seat[z] + 60;
            //float yd = posy - clouds[j].posy + 75;
            
            //posx += - xd / 2;
            //posy += - yd / 2;
            //delay(20);
            //posx += - xd / 2;
            //posy += - yd / 2;
            //delay(20);
            
            this.clx = clouds[j].seat[z] + 60;
            this.cly = clouds[j].posy + 75;
            musicR2[j][z] = this.s;
            musicj = j;
            musicz = z;
            sound[s].play();
            finalMusic[j * 4 + z] = this.s;
            
            cloudj = j;
            cloudz = z;
            
            cloudJumpIndex = 0;
            cloudB = true;
            
          }
        }
      }
    }
  }
      
  //화살 날아가기 함수
  void fly(){
      posx += -ax * 0.17;
      posy += -ay * 0.17 + speed;
      speed += 0.05;
      
      //화면 모서리에 닿았을 때 튕겨지기
      if(posx <= 0 || posx >= width){
        ax = -ax;
      }
      if(posy <= 0 || posy >= height){
        ay = -ay;
        speed = -speed;
      }
  }
  
  //토끼 한 칸 씩 이동하는 함수
  void sidewalk(){
    if(posx >= 800){
      posx += -100;
    }
  }
  
  //토끼 한 칸 씩 이동하는 함수
  void backWalk(){
    posx += 100;
  }
  
  //------//
}
