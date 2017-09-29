import processing.serial.*;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.awt.event.InputEvent;

Serial myPort;
int SerialData;
int stage = 0;

Robot robot;
int[] sensor = {0, 0};


void setup() {

  println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.bufferUntil ('\n');
  try {
    robot = new Robot();
  }
  catch (AWTException e) {
    e.printStackTrace();
    exit();
  }
}

void draw() {
  while (myPort.available()>0) {
    SerialData=myPort.read();
    //int myByte = myPort.read();
    println(SerialData);
  }

  if (SerialData<10) {  
    if (stage!=3) {
      robot.mousePress(InputEvent.BUTTON1_MASK);
      robot.mouseRelease(InputEvent.BUTTON1_MASK);
      //robot.delay(500);
      robot.mousePress(InputEvent.BUTTON1_MASK);
      robot.mouseRelease(InputEvent.BUTTON1_MASK);
      robot.delay(1000);
      stage = 3;
    }
    //robot.keyPress(KeyEvent.VK_A);
    //robot.delay(100);
    //robot.keyRelease(KeyEvent.VK_A);
  } else if (SerialData<16) {
    if (stage!=2) {
      robot.mousePress(InputEvent.BUTTON1_MASK);
      robot.mouseRelease(InputEvent.BUTTON1_MASK);
      robot.delay(1000);
      stage = 2;
    }
    //robot.mousePress(InputEvent.BUTTON1_MASK);
    //robot.mouseRelease(InputEvent.BUTTON1_MASK); 
    //robot.delay(1000);
  } else {  
    if (stage!=1) {
      //robot.mousePress(InputEvent.BUTTON1_MASK);
      robot.mouseRelease(InputEvent.BUTTON1_MASK);
      robot.delay(1000);
      stage = 1;
    }
  }
}

void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  inString = trim(inString);
  if (inString != null) {
    String[] parsedSerial = split(inString, ',');
    for (int x = 0; x < 2; x=x+1) {
      sensor[x] = parseInt(parsedSerial[x]);
    }
  }
}