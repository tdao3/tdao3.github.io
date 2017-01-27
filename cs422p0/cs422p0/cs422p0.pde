// GROUP: Tran Dao, Weiheng Ruan, Jason Lee

//////////////////////////////////////////////////////////////////////////////////////////////////////////
// sample simple processing / processing.js file from Andy Johnson - CS 422 - Spring 2017

// one current issue is dealing with sounds between Processing and Processing.js
// without compiler directives its hard to easily comment in and out the two different versions

// the external sound library (Sketch / Import Library / Sound) will work in processing but not in processing.js
// uncomment these two lines to get audio in Processing
//import processing.sound.*;
//SoundFile beepSound;

// here is a processing.js solution from http://aaron-sherwood.com/processingjs/circleSound.html
// uncomment this line to get audio in Processing.js
Audio beepSound = new Audio();

// also note the soundfile needs to be in the data folder for processing and outside that folder for Processing.js
// sounds are also a bit slowerer to start up in Processing.js

// placeholder for future image
PImage img1;
PImage img2;
PImage img3;
PImage img4;
PImage img5;
PImage img6;
PImage img7;
PImage img8;
PImage img9;
PImage img10;
PImage img11;



// some buttons
int[][] buttons = { {50, 100}, {50, 200}, {50, 300},{50, 400},{50, 500}};
int buttonX = 100;
int buttonY = 75;

// no buttons / mode currently selected
int selectedOne = -1;
int imgCount = 0;
int currentTime;
int reset = 0;
int pause = 0;
boolean stop = false;
int pauseSubtractor;
PFont f;

/////////////////////////////////////////////////////

void loadSounds(){
  // beep soundfile shortened from http://soundbible.com/2158-Text-Message-Alert-5.html
  
  //Processing load sound
  //beepSound = new SoundFile(this, "bing.mp3");
  
  // processing.js load sound
  beepSound.setAttribute("src","bing.mp3");
}

void playBeep() {
  // play audio in processing or processing.js
  beepSound.play();
}

/////////////////////////////////////////////////////

void setup() {
  // set the canvas size
  size(960, 800);
  
  // grab an image to use later
  // as with sounds Processing likes files in the data directory, Processing.js outside that directory
  img1 = loadImage("sketch2.gif", "gif");
  img1.loadPixels();
  img2 = loadImage("pic1", "jpg");
  img2.loadPixels();
  img3 = loadImage("pic2", "jpg");
  img3.loadPixels();
  img4 = loadImage("pic3", "jpg");
  img4.loadPixels();
  img5 = loadImage("pic4", "jpg");
  img5.loadPixels();
  img6 = loadImage("pic5", "jpeg");
  img6.loadPixels();
  img7 = loadImage("pic6", "jpg");
  img7.loadPixels();
  img8 = loadImage("pic7", "jpg");
  img8.loadPixels();
  img9 = loadImage("pic8", "jpg");
  img9.loadPixels();
  img10 = loadImage("pic9", "jpg");
  img10.loadPixels();
  img11 = loadImage("pic10", "jpeg");
  img11.loadPixels();
  
  f = createFont("Arial",24,true);
  
  loadSounds();
}

/////////////////////////////////////////////////////

void draw() {
  String timeString;
  
  background(0);
  noStroke();
  
  currentTime = millis() - reset;

  // draw some buttons
  fill(127,127,127);
  for (int loopCounter=0; loopCounter < buttons.length; loopCounter++)
    rect(buttons[loopCounter][0], buttons[loopCounter][1], buttonX, buttonY, 10);
    
  // draw the active button in a different color
  fill(127,127,0);
  if (selectedOne >= 0)
    rect(buttons[selectedOne][0], buttons[selectedOne][1], buttonX, buttonY, 10);
    
    
  // draw the state of the thing that the buttons control
  if (selectedOne == 0){
    fill(127,0,0);
    rect (300, 100, 300, 300);
  }
  
  if (selectedOne == 1){
    fill(0,127,0);
    ellipse(450,250,300,300);
  }
  
  if (selectedOne == 2){
    img1.resize(300, 300);
    image(img1, 300, 100);
    img2.resize(300, 300);
    image(img2, 300, 100);
    img3.resize(300, 300);
    image(img3, 300, 100);
    img4.resize(300, 300);
    image(img4, 300, 100);
    img5.resize(300, 300);
    image(img5, 300, 100);
    img6.resize(300, 300);
    image(img6, 300, 100);
    img7.resize(300, 300);
    image(img7, 300, 100);
    img8.resize(300, 300);
    image(img8, 300, 100);
    img9.resize(300, 300);
    image(img9, 300, 100);
    img10.resize(300, 300);
    image(img10, 300, 100);
    img11.resize(300, 300);
    image(img11, 300, 100);
  }
  if (selectedOne == 3){
    reset = millis();
    pause = 0;
    pauseSubtractor = 0;
  }
  if(selectedOne == 4){
    if(stop == true){
      
    }
    else{
      pause = currentTime - pauseSubtractor ;
      stop = true;
    }
  }
  else{
    if(stop == true){
      pauseSubtractor = currentTime-pause;
    }
    stop = false;
  }

    textFont(f);
    textSize(36);
    fill(127,127,127);
    textAlign(CENTER);
    
    if(selectedOne != 4){
      if(pause != 0){
        //println(pauseSubtractor);
        currentTime = currentTime - pauseSubtractor;
        timeString = str(floor(currentTime/1000));
       
        text(timeString, 100, 625);
      }
      else{
        timeString = str(floor((currentTime)/1000));
        text(timeString, 100, 625);
      }
    }
    else{
       timeString = str(floor(pause/1000));
       text(timeString, 100, 625);
    }
    
  
  // print out the number of seconds the app has been running
  
  
  

}

/////////////////////////////////////////////////////

// if the mouse button is released inside a known button keep track of which button was pressed
// and play a confirmation sound

void mouseReleased() {
  
  for (int loopCounter=0; loopCounter < buttons.length; loopCounter++){
      if ((mouseX > buttons[loopCounter][0]) && (mouseX < buttons[loopCounter][0]+buttonX)
      && (mouseY > buttons[loopCounter][1]) && (mouseY < buttons[loopCounter][1]+buttonY)){
        selectedOne = loopCounter;
        playBeep();
      }
  }
}