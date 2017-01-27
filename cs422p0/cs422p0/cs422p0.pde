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
PImage img;

// some buttons
int[][] buttons = { {50, 100}, {50, 200}, {50, 300}, {50, 400}, {50, 500}};
int buttonX = 100;
int buttonY = 75;

// no buttons / mode currently selected
int selectedOne = -1;

int pauseTime;
int currentTime;
boolean state= true;
boolean laststate= false;
int save;
PFont f;
int lastState;
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
  img = loadImage("sketch2.gif", "gif");
  img.loadPixels();
  
  f = createFont("Arial",24,true);
  
  loadSounds();
}

/////////////////////////////////////////////////////

void draw() {
  String timeString;
  
  background(0);
  noStroke();
  
  
    currentTime = millis();
    
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
    state= true;
  }
  
  if (selectedOne == 1){
    fill(0,127,0);
    ellipse(450,250,300,300);
    state= true;
  }
  
  if (selectedOne == 2){
    img.resize(300, 300);
    image(img, 300, 100);
    state= true;
  }
  
  // print out the number of seconds the app has been running
  
  textFont(f);
  textSize(36);
  fill(127,127,127);
  textAlign(CENTER);
  
  
  if(selectedOne !=3 && selectedOne != 4 ){
    int temp = 0;
    if(laststate == true){
      temp = currentTime-save;
      laststate = false;
    }

    
    timeString = str(floor((currentTime-temp)/1000));
    text(timeString, 100, 625);
  }
  if(selectedOne == 3){
    pauseTime = millis();
    
  }
  // not working
  /*
  if(selectedOne ==4){
    save = currentTime;
    laststate = true;
  
  }
  */
  

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
