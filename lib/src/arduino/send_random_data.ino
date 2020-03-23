#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>

BLEServer* pServer = NULL;
BLECharacteristic* pCharacteristic = NULL;
bool deviceConnected = false;
bool oldDeviceConnected = false;


#define SERVICE_UUID        "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
#define CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"


class MyServerCallbacks: public BLEServerCallbacks {
    void onConnect(BLEServer* pServer) {
      deviceConnected = true;
      BLEDevice::startAdvertising();
    };

    void onDisconnect(BLEServer* pServer) {
      deviceConnected = false;
    }
};


/*
I/O define
*/
const int iled = 12;                                            //drive the led of sensor
const int vout = 36;                                            //analog input

/*
variable
*/
int x, y, z, g, hz;


void setup(void)
{
  pinMode(iled, OUTPUT);
  digitalWrite(iled, LOW);                                     //iled default closed
  
  Serial.begin(115200);                                         //send and receive at 115200 baud
  Serial.print("*********************************** WaveShare ***********************************\n");

  // Create the BLE Device
  BLEDevice::init("ESP32_SISMIC");

  // Create the BLE Server
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  // Create the BLE Service
  BLEService *pService = pServer->createService(SERVICE_UUID);

  // Create a BLE Characteristic
  pCharacteristic = pService->createCharacteristic(
                      CHARACTERISTIC_UUID,
                      BLECharacteristic::PROPERTY_READ   |
                      BLECharacteristic::PROPERTY_WRITE  |
                      BLECharacteristic::PROPERTY_NOTIFY |
                      BLECharacteristic::PROPERTY_INDICATE
                    );

  // https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.descriptor.gatt.client_characteristic_configuration.xml
  // Create a BLE Descriptor
  pCharacteristic->addDescriptor(new BLE2902());

  // Start the service
  pService->start();

  // Start advertising
  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->setScanResponse(false);
  pAdvertising->setMinPreferred(0x0);  // set value to 0x00 to not advertise this parameter
  BLEDevice::startAdvertising();
  Serial.println("Waiting a client connection to notify...");
}

 
int contQuad = 1;
void loop(void){  
  
  /*
  get adcvalue
  */
  digitalWrite(iled, HIGH);
  delayMicroseconds(280);
  digitalWrite(iled, LOW);
  
  switch (contQuad){
    case 1:
        x = random(-5,5);
        y = random(45,55);
        contQuad++;
        break;
    case 2:
        x = random(5,15);
        y = random(35,45);
        contQuad++;
        break;
    case 3:
        x = random(15,25);
        y = random(25,35);
        contQuad++;
        break;
    case 4:
        x = random(25,35);
        y = random(15,25);
        contQuad++;
        break;
    case 5:
        x = random(35,45);
        y = random(5,15);
        contQuad++;
        break;
    case 6:
        x = random(45,55);
        y = random(-5,5);
        contQuad++;
        break;
    case 7:
        x = random(35,45);
        y = -random(5,15);
        contQuad++;
        break;
    case 8:
        x = random(25,35);
        y = -random(15,25);
        contQuad++;
        break;
    case 9:
        x = random(15,25);
        y = -random(25,35);
        contQuad++;
        break;
    case 10:
        x = random(5,15);
        y = -random(35,45);
        contQuad++;
        break;
    case 11:
        x = random(-5,5);
        y = -random(45,55);
        contQuad++;
        break;
    case 12:
        x = -random(5,15);
        y = -random(35,45);
        contQuad++;
        break;
    case 13:
        x = -random(15,25);
        y = -random(25,35);
        contQuad++;
        break;
    case 14:
        x = -random(25,35);
        y = -random(15,25);
        contQuad++;
        break;
    case 15:
        x = -random(35,45);
        y = -random(5,15);
        contQuad++;
        break;
    case 16:
        x = -random(45,55);
        y = random(-5,5);
        contQuad++;
        break;
    case 17:
        x = -random(35,45);
        y = random(5,15);
        contQuad++;
        break;
    case 18:
        x = -random(25,35);
        y = random(15,25);
        contQuad++;
        break;
    case 19:
        x = -random(15,25);
        y = random(25,35);
        contQuad++;
        break;
    case 20:
        x = -random(5,15);
        y = random(35,45);
        contQuad = 1;
        break;
  };
  
  z = random(10,20);
  g =random(0,9);
  hz = random(5,15);

  /*
  display the result
  */
  Serial.print("\n");
  Serial.print("The current data is: ");
  Serial.print("x: ");
  Serial.print(x);
  Serial.print("\n");
   Serial.print("y: ");
  Serial.print(y);
  Serial.print("\n");
  Serial.print("z: ");
  Serial.print(z);
  Serial.print("\n");
  Serial.print("g: ");
  Serial.print(g);
  Serial.print("\n");
  Serial.print("hz: ");
  Serial.print(hz);
  Serial.print("\n");  


  // notify changed value
    if (deviceConnected) {
        String str = "";
        str += x;
        str += "|";
        str += y;
        str += "|";
        str += z;
        str += "|";
        str += "2.";
        str += g;
        str += "|";
        str += hz;

        Serial.print("The current str is: ");
        Serial.print("\n");
        Serial.print(str);
        
        pCharacteristic->setValue((char*)str.c_str());
        pCharacteristic->notify();
    }
    // disconnecting
    if (!deviceConnected && oldDeviceConnected) {
        delay(500); // give the bluetooth stack the chance to get things ready
        pServer->startAdvertising(); // restart advertising
        Serial.println("start advertising");
        oldDeviceConnected = deviceConnected;
    }
    // connecting
    if (deviceConnected && !oldDeviceConnected) {
        // do stuff here on connecting
        oldDeviceConnected = deviceConnected;
    }
  
  delay(800);
}