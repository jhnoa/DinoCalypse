void updateButton()
{
  if (current_menu == 0)
  {
    if (overButton(230, 300, 120, 40))
    {
      over_button = 1;
    }
    else if (overButton(230, 360, 120, 40))
    {
      over_button = 2;
    }
    else if (overButton(230, 420, 120, 40))
    {
      over_button = 3;
    }
    else
    {
      over_button = 0;
    }
  }
  else if (current_menu == 2)
  {
    if (overButton(230, 300, 120, 40))
    {
      over_button = 1;
    }
    else if (overButton(230, 360, 120, 40))
    {
      over_button = 2;
    }
    else if (overButton(230, 420, 120, 40))
    {
      over_button = 3;
    }
    else if (overButton(230, 480, 120, 40))
    {
      over_button = 4;
    }
    else
    {
      over_button = 0;
    }
  }
  else if (current_menu == 3)
  {
    if (overButton(70, 30, 120, 40))
    {
      over_button = 1;
    }
    else
    {
      over_button = 0;
    }
  }
}

void mousePressed() 
{
  if (current_menu == 0)
  {
    switch(over_button)
    {
      // start game
      case 1:
        newGame();
        current_menu = 1;
        over_button = 0;
        break;
      // credits screen
      case 2:
        current_menu = 3;
        over_button = 0;
        break;
      // exit game
      case 3:
        exit();
      default:
        break;
    }
  }
  else if (current_menu == 2)
  {
    switch(over_button)
    {
      // continue game or restart game
      // since I don't know how to save the state of the game when pausing
      case 1:
        newGame();
        current_menu = 1;
        over_button = 0;
        break;
      // credits
      case 2:
        current_menu = 3;
        over_button = 0;
        break;
      // return to main menu
      case 3:
        current_menu = 0;
        over_button = 0;
        break;
      // exit game
      case 4:
        exit();
      default:
        break;
    }
  }
  else if (current_menu == 3)
  {
    // return to main menu
    if (over_button == 1)
    {
      current_menu = 0;
      over_button = 0;
    }
  }
}

boolean overButton(int x, int y, int w, int h)
{
  if (mouseX >= x-w/2 && mouseX <= x+w/2 && 
      mouseY >= y-h/2 && mouseY <= y+h/2)
  {
    return true;
  }
  else
  {
    return false;
  }
}