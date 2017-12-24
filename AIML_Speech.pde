

import websockets.*;
import guru.ttslib.*;
import codeanticode.eliza.*;

//import java.lang.*;




Eliza eliza;
TTS tts;
String text = "Input";
String Response = "Response";

WebsocketServer socket;
WebsocketServer AimlSocket;

//CharSequence splitter = "äiml:";

void setup() {
   PFont font = loadFont("SegoeUI-Light-48.vlw");
   textFont(font);
  //link("https://codepen.io/getflourish/pen/NpBGqe?editors=1111"); //original fallbacl
  //link("https://codepen.io/anon/pen/JyMGEW?editors=1111");  //new modified WIP
  fullScreen();
  smooth();
  //frame.setAlwaysOnTop(true);
  socket = new WebsocketServer(this, 1337, "/p5websocket");
  AimlSocket = new WebsocketServer(this, 1338, "/AimlwebSocket");
  
  
  link("https://codepen.io/anon/pen/RZqMjV?editors=1111");
  //launch("C:/Users/Dee/Desktop/ROVING ROBOT/AIML_Speech/Websocket_AIML.exe");
  //launch("C:/Program Files (x86)/Google/Chrome/Application/chrome.exe");
  drawClaraUI();
  
  
  // When Eliza is initialized, a default script built into the
  // library is loaded.
  eliza = new Eliza(this);
  System.setProperty("mbrola.base","C:/Program Files (x86)/Mbrola Tools");
  tts = new TTS("mbrola_us1");
  tts.setPitch(180); // set the base frequency to 1000 hertz
  tts.setPitchShift(1); // how much should the pich change over time?
  tts.setPitchRange(22); // in this example the pitch will vary between 1000 and 1100 hertz
    


  tts.speak("Welcome User!");
}


void draw() { 
  drawClaraUI(); //draw the ui 
  
}

void webSocketServerEvent(String msg) {
  if(msg.contains("aiml:")){
     Response = msg.replace("aiml:","");
    println("aiml result: "+ Response);  
     tts.speak(Response);
   }
  
  else if (msg.contains("speech:")){
   
  text = msg.replace("speech:","");
  
  //text = msg;
 
    println(text);
  ///switch statement for custom commands////////
  switch(text.replaceFirst("^\\s*", "").toLowerCase()){
     case "display":
     Response = "displaying settings whatever";   
     tts.speak(Response);
     break;
     
     
     
     case "what is in my hand":
     Response = "I dont know , I cant see at the moment!";
     tts.speak(Response);
     break;
     
     default:
     //Response = eliza.processInput(msg);
     AimlSocket.sendMessage(text);     
     break;
  }
  //// end of switch//////////////////////////
    
    
  } 
}


void drawClaraUI(){
  
  background(#007FEA);
  fill(255);
  line(0,height/2, width, height/2);  
  fill(255);  // Set fill to white
  ellipse(width/2,height/2, 100, 100);  // Draw white ellipse using RADIUS mode
  fill(0);  // Set fill to gray
  ellipse(width/2, height/2, 80,80);

  fill(#FFFFFF);
  textSize(50);
  textAlign(CENTER, TOP);
  text(text, 0, 100, width, height); 
  fill(#000000);
  textAlign(CENTER, BOTTOM);
  text(Response, 0, -100, width, height); 
}