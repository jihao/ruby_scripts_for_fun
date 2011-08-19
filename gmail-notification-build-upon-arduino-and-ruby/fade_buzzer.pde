int brightness = 0;    // how bright the LED is
int fadeAmount = 5;    // how many points to fade the LED by
int ledPin=9;
int serialLedPin=10;
int buzzerPin=6;
int incomingByte;      // a variable to read incoming serial data into
void setup()  { 
  Serial.begin(9600);
  // declare pin 9 to be an output:
  pinMode(ledPin, OUTPUT);
  pinMode(serialLedPin, OUTPUT);
  pinMode(buzzerPin,OUTPUT);//设置数字IO脚模式，OUTPUT为输出
} 
void beep()
{
  unsigned char i,j;//定义变量
  for(i=0;i<80;i++)//输出一个频率的声音
  {
    analogWrite(buzzerPin,i);//发声音
    delay(1);//延时1ms
    analogWrite(buzzerPin,LOW);//不发声音
    delay(1);//延时ms
  }
}
void beep5times()
{
   for(int i=0;i<5;i++)
   {
     beep();
     delay(1000);             
   }
}
void checkSerialInput() {
  // see if there's incoming serial data:
  if (Serial.available() > 0) {
    // read the oldest byte in the serial buffer:
    incomingByte = Serial.read();
    Serial.write(incomingByte);
    // if it's a capital H (ASCII 72), turn on the LED:
    if (incomingByte == 'H') {
      digitalWrite(serialLedPin, HIGH);
      beep5times();
    } 
    // if it's an L (ASCII 76) turn off the LED:
    if (incomingByte == 'L') {
      digitalWrite(serialLedPin, LOW);
    }
  }
}
void loop()  { 
  // set the brightness of pin 9:
  analogWrite(ledPin, brightness);    
  // check any input from serial in
  checkSerialInput();
  
  // change the brightness for next time through the loop:
  brightness = brightness + fadeAmount;

  // reverse the direction of the fading at the ends of the fade: 
  if (brightness == 0 || brightness == 255) {
    fadeAmount = -fadeAmount ; 
    
  }     
  // wait for 30 milliseconds to see the dimming effect    
  delay(30);                            
}

