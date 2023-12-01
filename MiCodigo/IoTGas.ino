#ifdef ESP32
  #include <WiFi.h>
#else
  #include <ESP8266WiFi.h>
#endif
#include <WiFiClientSecure.h>
#include <UniversalTelegramBot.h>
#include <ArduinoJson.h>


// Replace with your network credentials
const char* ssid = "iotdig";
const char* password = "090804Ar";

/*WiFiUDP UDP;
byte mac[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
*/

// Initialize Telegram BOT
#define BOTtoken "6788329134:AAFPsiEUmcok3XHfj54Hnnu2Nz_PWVK0GBs"
#define CHAT_ID "1539391341"

WiFiClientSecure client;
UniversalTelegramBot bot(BOTtoken, client);

// Check pin states every 1 second
int pinCheckInterval = 1000;
unsigned long lastPinCheckTime = 0;
int botRequestDelay = 1000;
unsigned long lastTimeBotRan;

const int pinOut = 2;
bool pinState = HIGH;


// Define the pins connected to the FPGA
const int pin1 = 15;  // Replace with the actual pin number
const int pin2 = 4;  // Replace with the actual pin number

void sendStatusMessage() {
  int state1 = digitalRead(pin1);
  int state2 = digitalRead(pin2);
  

  

  if (state1 == HIGH && state2 == HIGH) {
    bot.sendMessage(CHAT_ID, "Both pins are HIGH", "");
  } else if (state1 == HIGH) {
    bot.sendMessage(CHAT_ID, "Alarma por gas activada, ingrese la contraseña  ", "");
  } else if (state2 == HIGH) {
    bot.sendMessage(CHAT_ID, "Movimiento detectado, alarma disparada, ingrese su contraseña", "");
  } else {
    pinState = HIGH;
    digitalWrite(pinOut, pinState);
    bot.sendMessage(CHAT_ID, "Todo está bien, pai", "");
  }
}


void handleNewMessages(int numNewMessages) {
  Serial.println("handleNewMessages");
  Serial.println(String(numNewMessages));

  for (int i=0; i<numNewMessages; i++) {
    // Chat id of the requester
    String chat_id = String(bot.messages[i].chat_id);
    if (chat_id != CHAT_ID){
      bot.sendMessage(chat_id, "Unauthorized user", "");
      continue;
    }
    
    // Print the received message
    String text = bot.messages[i].text;
    Serial.println(text);

    String from_name = bot.messages[i].from_name;

    if (text == "/start") {
      String welcome = "Bienvenido, " + from_name + ".\n";
      welcome += "Aquí podrás verificar el estado de tu alarma inteligente \n";
      welcome += "Y controlar su estado";
      bot.sendMessage(chat_id, welcome, "");
    }

    if (text == "cubides"){
       String mensajecont ="Contraseña correcta";
       bot.sendMessage(chat_id, mensajecont);
       pinState = LOW;
      digitalWrite(pinOut, pinState);



    }

    
    
   
    
   
  }
}



void setup() {
  Serial.begin(9600);

  pinMode(pin1, INPUT);
  pinMode(pin2, INPUT);
  pinMode(pinOut, OUTPUT);

  // Connect to Wi-Fi
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  #ifdef ESP32
    client.setCACert(TELEGRAM_CERTIFICATE_ROOT); // Add root certificate for api.telegram.org
  #endif

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi..");
  }
   Serial.println(WiFi.localIP());
}

void loop() {
  unsigned long currentMillis = millis();
  digitalWrite(2, HIGH);

  // Check pin states at the specified interval
  if (currentMillis - lastPinCheckTime >= pinCheckInterval) {
    sendStatusMessage();
    lastPinCheckTime = currentMillis;
  }
   
 if (currentMillis > lastTimeBotRan + botRequestDelay)  {
    int numNewMessages = bot.getUpdates(bot.last_message_received + 1);

    while(numNewMessages) {
      Serial.println("got response");
      handleNewMessages(numNewMessages);
      numNewMessages = bot.getUpdates(bot.last_message_received + 1);
    }
    lastTimeBotRan = millis();
  }
   

  // Other continuous tasks can be added here
}

