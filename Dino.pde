class dino {
  PImage pic;
  PShape D;
  final int lebar = 50;
  final int tinggi = 120;
  int posX = 0;
  int posY = 0;
  
  int speed = 4;
  int heading = 1;// 1 = right, 0 = left
  
  int step = 0;
  int stepN = 0;
  
  dino()
  {
    posX = 50;
    posY = 550;
    speed = 4;
    D = createShape();
    D.beginShape();
    D.fill(100,40,20,50);
    D.vertex(-15.64,-50.048);
    D.vertex(10.608,-1.36);
    D.vertex(53.176,10.472);
    D.vertex(25.976,27.608);
    D.vertex(25.976,54.4);
    D.vertex(-33.456,54.4);
    D.vertex(-33.456,5.44);
    D.vertex(-60.248,-15.776);
    D.vertex(-60.248,-33.864);
    D.vertex(-34,-50.048);
    D.endShape(CLOSE);
  }
  
  void update()
  {
    if(end_game)
    {
      stepN++;
      if(stepN > 6)
      {
        stepN = 0;
        step++;
        if(step == 4) step = 0;
  
      }
      pushMatrix();
      if(heading == 1)
      {
        scale(-1,1);
        image(imgD[step], -posX-(imgD[step].width)/2, posY-(imgD[step].height)/2, imgD[step].width, imgD[step].height);
      }
      else
      {
        image(imgD[step], posX-(imgD[step].width)/2, posY-(imgD[step].height)/2, imgD[step].width, imgD[step].height);
      }
      popMatrix();
    }
    else
    {
      if(heading == 1) posX += speed;
      else posX -=speed;
      if(posX < 50) heading = 1;
      else if(posX > 430) heading = 0;
      fill(green);
      stepN++;
      if(stepN > 6)
      {
        stepN = 0;
        step++;
        if(step == 4) step = 0;
  
      }
      pushMatrix();
      if(heading == 1)
      {
        scale(-1,1);
        image(imgD[step], -posX-(imgD[step].width)/2, posY-(imgD[step].height)/2, imgD[step].width, imgD[step].height);
      }
      else
      {
        image(imgD[step], posX-(imgD[step].width)/2, posY-(imgD[step].height)/2, imgD[step].width, imgD[step].height);
      }
      popMatrix();
    }
  }
  
}