int GetHS()
{
  InputStream input = createInput("score.dat");
  if (input == null)
  {
    println("File doesn't exist");
    PrintWriter output = createWriter("score.dat");
    output.print(str(0));
    //output.print(TAB);
    HScore = 0;
    output.flush();
    output.close();
    return 0;
  }
  try
  {
    input.close();
  }
  catch (IOException e)
  {
    e.printStackTrace();
  }
    
  BufferedReader reader = createReader("score.dat"); 
  String content = "";
  try
  {
    content = reader.readLine();
  }
  catch (IOException e)
  {
    e.printStackTrace();
    content = null;
  }
  return decodeHS(content);
}

int decodeHS(String n)
{
  println("String = ", n);
  int result = 0, power = 1;
  for (int i = n.length() - 1; i >= 0; i--)
  {
    println("Char[", i, "] = ", n.charAt(i));
    println("Power = ", power);
    println("Result = ", result);
    result += power*(n.charAt(i)-48);
    power *= 10;
  }
  println("Result = ", result, ENTER);
  //result = Integer.parseInt(n);
  return result;
}

void SetHS()
{
  println("HighScore = ", HScore);
  PrintWriter output = createWriter("score.dat");
  output.print(encodeHS(HScore));
  output.flush();
  output.close();
}

String encodeHS(int n)
{
  return str(n);
}

void CheckHS()
{
  if (HScore < Score)
  {
    HScore = Score;
  }
}

void HS_bar()
{
  text("Highscore: "+HScore, width-130,30);
  text("Score: "+Score, width-130,50);
}