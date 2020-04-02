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
int angleXZ, angleZY;

void setup(void){
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

int centerElipsePos(int x){
  int x2 = pow(x, 2);
  int result = (int) sqrt((225000000-10000*x2)/(22500));
  return result;
}
int centerElipseNeg(int x){
  int x2 = pow(x, 2);
  int result = (int) -sqrt((225000000-10000*x2)/(22500));
  return result;
}

int firstElipsePos(int x){
  int x2 = pow(x, 2);
  int result = (int) sqrt((158760000-8100*x2)/(19600));
  return result;
}
int firstElipseNeg(int x){
  int x2 = pow(x, 2);
  int result = (int) -sqrt((158760000-8100*x2)/(19600));
  return result;
}
//---------------------------------------------------------------------
int zElipsePos(int x){
  int x2 = pow(x, 2);
  int result = (int) sqrt((14062500-625*x2)/(22500));
  return result;
}
int zElipseNeg(int x){
  int x2 = pow(x, 2);
  int result = (int) -sqrt((14062500-625*x2)/(22500));
  return result;
}
int zFirstElipsePos(int x){
  int x2 = pow(x, 2);
  int result = (int) sqrt((4410000-225*x2)/(19600));
  return result;
}
int zFirstElipseNeg(int x){
  int x2 = pow(x, 2);
  int result = (int) -sqrt((4410000-225*x2)/(19600));
  return result;
}
//---------------------------------------------------------------------


int contQuad = -150;
bool positiveElipse = true;
int contElipse = 0;
int contAngleXZ = 0;
int contAngleZY = 0;

void loop(void){
   if(contAngleXZ < 5){
     angleXZ = contAngleXZ;
     contAngleXZ++;
   }else{
     angleXZ = contAngleXZ;
     contAngleXZ = 0;
   }
   if(contAngleZY < 16){
     angleZY = contAngleZY; 
     contAngleZY++;
   }else{
     angleZY = contAngleZY; 
     contAngleZY = 0;
   }
   
   switch(contElipse){
       case 0:
        if((contQuad <= 150) && (positiveElipse == true)){
            x = contQuad;
            y = centerElipsePos(contQuad);
            z = zElipsePos(contQuad);
            contQuad = contQuad + 30;
            if(contQuad == 150){
                positiveElipse = false;
            }
        }else{
            x = contQuad;
            y = centerElipseNeg(x);
            z =  zElipseNeg(contQuad);
            contQuad = contQuad - 30;
            if(contQuad == -150){
                positiveElipse = true;
                contElipse++;
                contQuad = -140;
            }
        }
        break;
        case 1:
        if((contQuad <= 140) && (positiveElipse == true)){
            if(contQuad > 0){
              x = contQuad;
              y = firstElipsePos(contQuad);
              z = zFirstElipsePos(contQuad);
            }else{
              x = contQuad ;
              y = firstElipsePos(x);
              z = zFirstElipsePos(contQuad);
            }
            contQuad = contQuad + 28;
            if(contQuad == 140){
                positiveElipse = false;
            }
        }else{
            x = contQuad;
            y = firstElipseNeg(x);
            z = zFirstElipseNeg(contQuad);
            contQuad = contQuad - 28;
            if(contQuad == -140){
                positiveElipse = true;
                contElipse--;
                contQuad = -150;
            }
        }
        break;
   }
  g = random(0,9);
  hz = random(13, 15);
  /*
  display the result
  */

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
//        str += "|";
//        str += contAngleXZ;
//        str += "|";
//        str += contAngleZY;
        
        Serial.print("The current str is: ");
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
  
  delay(200);
}