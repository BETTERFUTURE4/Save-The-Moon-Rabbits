//////round 2 구름 클래스//////
Cloud[] clouds = new Cloud[16];////구름 클래스 리스트 생성

class Cloud{
  float posx, posy;
  float[] seat = new float[4]; //내부 토끼 위치 x좌표 지정
  
  //오브젝트 변수값 할당
  Cloud( float _x, float _y) {
    this.posx = _x;
    this.posy = _y;
  }
  //--------//
  
  //////구름 실행 함수//////
  void draw(){
    image(cloudimg,posx,posy, 340,189);
    
    seat[0] = posx + 15;
    for(int i = 1; i < seat.length; i++){
      seat[i] = seat[i - 1] + 70;
    }
    
  }
  //--------//
  
}
