// COLOR
color black = color(0);
color white = color(255);
color green = color(0,255,0);
color blue = color(0,0,255);
color red = color(255,0,0);
color yellow = color(255, 255, 0);

// Score
int HScore = 0;
int Score = 0;
int nScore = 0;

// Settings
boolean showFPS = true;
int seed = 0;
int nMeteor = 0;
int sumMeteor = 5;
PImage bg;
PFont bold;

// Units
dino Dino;
meteor Meteor[];
PImage img[];//meteor
PImage imgD[];//DINO

// BGM
Minim minim;
AudioPlayer player,player1;

void init()
{
  image(bg,0,0);
  ellipseMode(CENTER);
  rectMode(CENTER);
  bold = loadFont("JavaneseText-16.vlw");
  textFont(bold, 16);
  fill(120,232,31);
  img = new PImage[10];
  img[0] = loadImage("METEOR-1.png");
  img[1] = loadImage("METEOR-2.png");
  img[2] = loadImage("METEOR-3.png");
  img[3] = loadImage("METEOR-4.png");
  img[4] = loadImage("METEOR-5.png");
  img[5] = loadImage("LEDAKAN4.png");
  img[6] = loadImage("LEDAKAN3.png");
  img[7] = loadImage("LEDAKAN2.png");
  img[8] = loadImage("LEDAKAN1.png");
  img[9] = loadImage("DEBULEDAKAN.ai.png");
  hpBar = loadImage("gradient.jpg");
  imgD = new PImage[4];
  imgD[0] = loadImage("1a.png");
  imgD[1] = loadImage("3a.png");
  imgD[2] = loadImage("2a.png");
  imgD[3] = loadImage("4a.png");
  current_menu = 0;
  
  minim = new Minim(this);
  player = minim.loadFile("Clash Defiant.mp3",2048);
  player1 = minim.loadFile("Killers.mp3",2048);
  bgm1Stop();
  bgm2Stop();
}

void newGame()
{
  nScore = 0;
  Score = 0;
  HScore = GetHS();
  seed = 0;
  health = 5;
  nMeteor = 0;
  Dino = new dino();
  Meteor = new meteor[sumMeteor];
  for(int i = 0; i < sumMeteor; i++)
  {
    Meteor[i] = new meteor(seed, nMeteor);
    seed = Meteor[i].nextSeed();
    nMeteor++;
  }
  bgm2();
}

void bgm1()
{
  
  player.rewind();
  player.unmute();
  player.loop();
  player.play();
  bgm2Stop();
}

void bgm1Stop()
{
  player.pause();
  player.mute();
}

void bgm2()
{
  
  player1.rewind();
  player1.unmute();
  player1.loop();
  player1.play();
  bgm1Stop();
}

void bgm2Stop()
{
  player1.pause();
  player1.mute();
}

// SOURCE: https://processing.org/discourse/beta/num_1276644884.html
float getDistance( float x1, float y1, float x2, float y2, float x, float y ){
  PVector result = new PVector(); 
  
  float dx = x2 - x1; 
  float dy = y2 - y1; 
  float d = sqrt( dx*dx + dy*dy ); 
  float ca = dx/d; // cosine
  float sa = dy/d; // sine 
  
  float mX = (-x1+x)*ca + (-y1+y)*sa; 
  
  if( mX <= 0 ){
    result.x = x1; 
    result.y = y1; 
  }
  else if( mX >= d ){
    result.x = x2; 
    result.y = y2; 
  }
  else{
    result.x = x1 + mX*ca; 
    result.y = y1 + mX*sa; 
  }
  
  dx = x - result.x; 
  dy = y - result.y; 
  result.z = sqrt( dx*dx + dy*dy ); 
  
  return result.z;   
}





/* BACKUP SECTION
boolean collision(meteor col)
{
  // top and bottom edges of rect
  if (col.y+col.r >= Dino.posY-Dino.tinggi/2 && col.y-col.r <= Dino.posY+Dino.tinggi/2 && Dino.posX-Dino.lebar/2 <= col.x && col.x <= Dino.posX+Dino.lebar/2)
  {
    //print("a");
    return true;
  }
  // left and right edges of rect
  else if (col.x+col.r >= Dino.posX-Dino.lebar/2 && col.x-col.r <= Dino.posX+Dino.lebar/2 && Dino.posY-Dino.tinggi/2 <= col.y && col.y <= Dino.posY+Dino.tinggi/2)
  {
    //print("b");
    return true;
  }
  // top-left corner of rect
  else if (dist(col.x, col.y, Dino.posX-Dino.lebar/2, Dino.posY-Dino.tinggi/2) <= col.r)
  {
    //print("c");
    return true;
  }
  // top-right corner of rect
  else if (dist(col.x, col.y, Dino.posX+Dino.lebar/2, Dino.posY-Dino.tinggi/2) <= col.r)
  {
    //print("d");
    return true;
  }
  // bottom-left corner of rect
  else if (dist(col.x, col.y, Dino.posX-Dino.lebar/2, Dino.posY+Dino.tinggi/2) <= col.r)
  {
    //print("e");
    return true;
  }
  // bottom-right corner of rect
  else if (dist(col.x, col.y, Dino.posX+Dino.lebar/2, Dino.posY+Dino.tinggi/2) <= col.r)
  {
    //print("f");
    return true;
  }
  return false;
}
*/