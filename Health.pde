int health = 5;
int hpBar_x = 30;
PImage hpBar;
void ouch()
{
  health -= 1;
}
void HP_bar()
{
  for(int i = 0; i < health; i++)
  {
    if(health > 5) break;
    image(hpBar, 20 + i*hpBar_x, 20, hpBar_x, 30);
  }
  text("HP: " + health, 20, 60);
}