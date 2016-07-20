class meteor
{
  int r;
  float x = 0;
  float y = 0;
  
  int boom_indicator = 0;
  float BOOMX = 0;
  float BOOMY = 0;
  
  int seedA = 53;  //Seed multiplayer
  int seedB = 131; //Seed adder
  int seedP = 0;   //Seed previous
  int seedC = 0;   //Seed current
  
  float speed = 0;
  int end_posY = height;
  int step = 0;
  int stepN = 0;
  
  int segment = 0;
  float angle = 0;
  boolean prob_big = false;
  
  boolean debug = false;
  
  meteor(int seed, float n)
  {
    seedP = seed;
    speed = 5 + n/100;
    //seed-current
    seedC = seedA*seedP + seedB;
    
    //segment
    segment = seedC % 48;
    if (segment > 48)
    {
      segment -= 48;
    }
    else if (segment < 0)
    {
      segment += 48;
    }
    x = segment*10;
    
    //angle
    angle = (seedC % 51);
    if(angle > 51) angle -= 51;
    else if(angle < 0) angle += 51;
    angle = (angle-26)*PI/180;
    
    // prob_big
    prob_big = (seedC % 100) < 10;
    //radius
    if(prob_big)
    {
      r = 40;
      step = 3;
    }
    else
    {
      r = 15;
      step = 0;
    }
    
    if(debug)
    {
      //print statistic
      println("seed    = "+seedC);
      println("speed   = "+speed);
      println("segment = "+segment);
      println("angle   = "+angle);
      println("prob_big= "+prob_big);
      println("-----------------");
    }
  }
  
  int nextSeed()
  {
    return seedC;
  }
  
  
  void update()
  {
    if(boom_indicator == 0)
    {
      y += cos(angle)*speed;
      x += sin(angle)*speed;
      if(stepN > 6)
      {
        //println("a");
        if(prob_big == true)
        {
          step ^= 7;
          //println("B, "+step);
        }
        else 
        {
          step++;
          step = step%3;
          //println("C, "+step);
        }
        stepN = 0;
      }
      image(img[step], x-(img[step].width*0.085)/2, y-(img[step].height*0.085)+r, (img[step].width*0.085), (img[step].height*0.085));
      //ellipse(BB,y,2*r,2*r);
      stepN++;
    }
    else if(boom_indicator == 1)
    {
      if(stepN > 9)
      {
        step++;
        stepN = 0;
      }
      if(step > 9)
      {
        x = width + 100;
        y = height + 100;
        step = 9;
      }
      image(img[step], BOOMX, BOOMY, img[step].width*0.02 + r , img[step].height*0.02 + r);
      
      stepN++;
    }
  }
  
  void boom()
  {
    BOOMX = x-(img[step].width*0.085)/2;
    BOOMY = y-(img[step].height*0.085)+r;
    x = 0;
    y = 0;
    stepN = 0;
    step = 5;
    boom_indicator = 1;
    if(prob_big == true) health = 0;
    else health -= 1;
  }
}