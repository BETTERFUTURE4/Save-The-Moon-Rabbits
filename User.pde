int userIndex = 0;//유저 인덱스 저장

User[] user = new User[100];//유저 음 저장 클래스 생성

//-----------유저  설정-------------//
void setupUser(){
  for(int i = 0; i < user.length; i++){
    user[i] = new User();
  }
}

//유저 값 저장 클래스
class User{
  int[] userSound = new int[]{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
  int userSub = -1;
  int[] userDrum = new int[]{-1,-1,-1,-1,-1,-1,-1,-1};
  String name = " ";
}
