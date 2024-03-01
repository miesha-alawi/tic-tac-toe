String[][] board = {
{"","","",},
{"","","",},
{"","","",}
};

String human = "X";
String ai = "O";
String currentPlayer;


void setup()
{
  size(640,640);
  frameRate(1);
  textSize(128);
  noFill();
  stroke(0);
  strokeWeight(4);
  currentPlayer = human;
}

boolean equals3(String a, String b, String c)
{
  return (a==b && b==c && a != "");
}

void clearBoard()
{
 for(Integer i = 0; i < 3; i++)
  {
    for(Integer j = 0; j < 3; j++)
    {
      board[i][j] = "";
    }
  }
}

void checkWinner()
{
  String winner = null;
  //horizontal
  for(int i = 0; i < 3; i++)
  {
    if(equals3(board[i][0],board[i][1],board[i][2]))
    {
        winner = board[i][0];
    }
  }
  //vertical
  for(int i = 0; i < 3; i++)
  {
    if(equals3(board[0][i],board[1][i],board[2][i]))
    {
        winner = board[0][i];
    }
  }
  //diagonal
  if(equals3(board[0][0],board[1][1],board[2][2]))
  {
      winner = board[0][0];
  }
  if(equals3(board[2][0],board[1][1],board[0][2]))
  {
      winner = board[2][0];
  }
  
  
  if(winner == null)
  {
    //tie
    System.out.println("tie");
  }
  else
  {
    //log winner! and clear board for new game
    System.out.println(winner);
    clearBoard();
  }
}

void nextTurn() {
  //check availability
  ArrayList<String> available = new ArrayList<String>();
  for(Integer i = 0; i < 3; i++)
  {
    for(Integer j = 0; j < 3; j++)
    {
      if(board[i][j] == "")
      {
        available.add(i.toString() + ":" + j.toString());
      }
    }
  }
  if(available.size() != 0)
  {
  //pick a random spot in available
  int rand = (int)random(available.size());
  String coords = available.get(rand);
  int i = Integer.parseInt(coords.split(":")[0]);
  int j = Integer.parseInt(coords.split(":")[1]);
  //assign spot in board to ai
  board[i][j] = ai;
  //remove spot from available
  available.remove(rand);
  //switch currentplayer
  currentPlayer = human;
  }
}

void mousePressed() {
  if(currentPlayer == human)
  {
    int w =  width/3;
    int h = height/3;
    //human make turn
    int i = (int)(mouseX / w);
    int j = (int)(mouseY / h);
    //if valid turn
    if(board[i][j] == "")
    {
      board[i][j] = human;
      currentPlayer = ai;
      nextTurn();
    }
  }
}

void draw()
{
  background(255);
  int w =  width/3;
  int h = height/3;
  //game board
  line(w,0,w,height);
  line(w*2,0,w*2,height);
  line(0,h,width,h);
  line(0,h*2,width,h*2);
  
  //player moves drawing
  for(int j = 0; j < 3; j++)
  {
    for(int i = 0; i < 3; i++)
    {
      int x = w*i + w/2;
      int y = h*j + h/2;
      String spot = board[i][j];
      if(spot == ai)
      {
        ellipse(x,y,w/2,w/2); //"O"
      }
      else if(spot == human)
      {
        int xr =  w/4;
        line(x-xr,y-xr,x+xr,y+xr);
        line(x+xr,y-xr,x-xr,y+xr); //"X"
      }
    }
  }
  checkWinner();
}
