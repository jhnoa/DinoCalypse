import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

final int screenX = 600;
final int screenY = 800;
boolean debug = true;

int current_menu = -1;
// MENU LIST
// 0 = main menu
// 1 = game underway
// 2 = paused game
// 3 = credits

int over_button = -1;
int quick_pause;
boolean end_game = false;

void setup()
{
  size(480, 640);
  bg = loadImage("VOLCANO1.jpg");
  frameRate(60);
  init();
  newGame();
  bgm1();
}

void draw()
{
  image(bg, 0,0,width,height);
  updateButton();
  if(showFPS == true)
  {
    text("FPS:"+frameRate, 4, height - 8);
  }
  if (current_menu == 0)
  {
    textAlign(CENTER);
    // to be replaced with some sort of logo
    fill(black);
    text("DinoCalypse", width/2, 240, 120, 40);
    
    // button rectangles
    if (over_button == 1)
    {
      fill(white);
    }
    else
    {
      fill(green);
    }
    rect(width/2, 300, 120, 40);
    
    if (over_button == 2)
    {
      fill(white);
    }
    else
    {
      fill(blue);
    }
    rect(width/2, 360, 120, 40);
    
    if (over_button == 3)
    {
      fill(white);
    }
    else
    {
      fill(red);
    }
    rect(width/2, 420, 120, 40);
    
    // button text
    fill(black);
    text("Start Game", width/2, 310, 120, 40);
    text("About Game", width/2, 370, 120, 40);
    text("Exit Game", width/2, 430, 120, 40);
    textAlign(LEFT);
  }
  else if (current_menu == 1)
  {
    
    if (end_game)
    {
      /*
      if (quick_pause > 0)
      {
        quick_pause -= 1;
      }
      else
      {
        current_menu = 0;
        end_game = false;
      }*/
      int x = 0;
      Dino.update();
      for(int i = 0; i < sumMeteor; i++)
      {
        if(Meteor[i].boom_indicator == 0)Meteor[i].boom();
        Meteor[i].update();
        if(Meteor[i].x > width && Meteor[i].y>height) x += 1;
      }
      if(x == sumMeteor)
      {
        SetHS();
        newGame();
        end_game = false;
        bgm1();
        
        current_menu = 2;
      }
    }
    else
    {
      Dino.update();
      //shape(Dino.D, Dino.posX, Dino.posY);
      for(int i = 0; i < sumMeteor; i++)
      {
        Meteor[i].update();
        if(Meteor[i].y > height || Meteor[i].x > width || Meteor[i].x < 0)
        {
          Meteor[i] = new meteor(seed,nMeteor);
          seed = Meteor[i].nextSeed();
          nMeteor++;
        }
        if (collision(Meteor[i]) && Meteor[i].boom_indicator == 0)
        {
          Meteor[i].boom();
          //quick_pause = 90;
          
          // we should not stop the game immediately
          // the big meteor will not get to explode if it stops
          // replace asap
          if(health == 0)
          {
            //stop();
            end_game = true;
          }
        }
      }
      
      nScore++;
      if(nScore >= frameRate)
      {
        nScore = 0;
        Score++;
        CheckHS();
      }
    }
    HP_bar();
    HS_bar();
  }
  else if (current_menu == 2)
  {
    textAlign(CENTER);
    fill(black);
    text("GAME OVER", 240, 240, 120, 40);
    
    // button rectangles
    if (over_button == 1)
    {
      fill(white);
    }
    else
    {
      fill(green);
    }
    rect(width/2, 300, 120, 40);
    
    if (over_button == 2)
    {
      fill(white);
    }
    else
    {
      fill(blue);
    }
    rect(width/2, 360, 120, 40);
    
    if (over_button == 3)
    {
      fill(white);
    }
    else
    {
      fill(yellow);
    }
    rect(width/2, 420, 120, 40);
    
    if (over_button == 4)
    {
      fill(white);
    }
    else
    {
      fill(red);
    }
    rect(width/2, 480, 120, 40);
    
    // button text
    fill(black);
    text("Restart Game", width/2, 310, 120, 40);
    text("About Game", width/2, 370, 120, 40);
    text("Return to Main Menu", width/2, 425, 120, 40);
    text("Exit Game", width/2, 490, 120, 40);
    textAlign(LEFT);
  }
  else if (current_menu == 3)
  {
    textAlign(CENTER);
    if (over_button == 1)
    {
      fill(white);
    }
    else
    {
      fill(blue);
    }
    rect(70, 30, 120, 40);
    
    fill(255, 255, 255, 245);
    rect(width/2, height/2, width-200, height-160);
    
    fill(black);
    text("Return to Main Menu", 70, 35, 120, 40);
    
    text("HOW TO PLAY", width/2, 110, 120, 40);
    text("Hanya satu tombol: SPACE bar", width/2, 140, width-200, 40);
    text("Pencet untuk ganti arah", width/2, 160, width-200, 40);
    text("Tahan untuk berhenti", width/2, 180, width-200, 40);
    text("Hindari semua meteor", width/2, 200, width-200, 40);
    text("Selamat bermain", width/2, 220, width-200, 40);
    
    text("CREDITS", width/2, 260, 120, 40);
    text("Project Manager Arthur Nathaniel", width/2, 290, 160, 40);
    text("Lead Programmer Johan Siautama Evan Robinson", width/2, 350, 140, 60);
    text("Lead Design David Soborono Felicia", width/2, 420, 120, 60);
    text("Sound Engineer Billy", width/2, 480, 140, 40);
    text("Special thanks to Fergie Lau", width/2, 530, 130, 40);
    textAlign(LEFT);
  }
  
  if(debug)
  {
    println(frameRate);
  }
  fill(blue);
}

void keyPressed()
{
  if (key == ' ')
  {
    Dino.speed = 0;
  }
}

void keyReleased()
{
  if (key == ' ')
  {
    Dino.speed = 4;
    Dino.heading = 1 - Dino.heading;
  }
}

boolean collision(meteor col)
{
  PVector a,b;
  a = Dino.D.getVertex(9);
  
  for(int i = 0; i < 10; i++)
  {
    b = Dino.D.getVertex(i);
    if(Dino.heading == 1)
    {
      if(getDistance(Dino.posX-a.x,Dino.posY+a.y,Dino.posX-b.x,Dino.posY+b.y,col.x,col.y) < col.r)
      {
        return true;
      }
    }
    else
    {
      if(getDistance(Dino.posX+a.x,Dino.posY+a.y,Dino.posX+b.x,Dino.posY+b.y,col.x,col.y) < col.r)
      {
        return true;
      }
    }
    a = b;
  }
  return false;
}