

#include "Wire.h"
extern "C" { 
#include "utility/twi.h"  // from Wire library, so we can do bus scanning
}
#include "Adafruit_VL53L0X.h"
#include <Adafruit_MCP4725.h>
Adafruit_MCP4725 dac_in1, dac_out1,dac_in2, dac_out2,dac_in3, dac_out3;


#define TCAADDR 0x70

int max1 = 10000;
int phase = 180;
int pam_phase2 = 120;
int pam_phase3 = 240;
int dac_voltage_in = 4095;
int dac_voltage_out = 4095; //3000 not bad
double air_delay = 2;
int min_volt_out = 0;
int min_volt_in = 2900;

void tcaselect(uint8_t i) {
  if (i > 7) return;
 
  Wire.beginTransmission(TCAADDR);
  Wire.write(1 << i);
  Wire.endTransmission();  
}
// standard Arduino setup()
void setup()
{
    while (!Serial);
    delay(1000);
    Wire.begin();
    Serial.begin(9600);

    Serial.print("Start.");
    

    tcaselect(1);
    dac_in1.begin(0x60);
    dac_out1.begin(0x61);
    
    tcaselect(2);
    dac_in2.begin(0x61);
    dac_out2.begin(0x60);

    tcaselect(7);
    dac_in3.begin(0x61);
    dac_out3.begin(0x60);
    
    dac_in1.setVoltage(0 , true);
    dac_out1.setVoltage(0 , true);

    dac_in2.setVoltage(0 , true);
    dac_out2.setVoltage(0 , true);

    dac_in3.setVoltage(0 , true);
    dac_out3.setVoltage(0 , true);
  
    
    Serial.println(" End setup");
    delay(2000);
    Serial.println("dac_voltage_in: ");
    Serial.print(dac_voltage_in);
    Serial.print(" dac_voltage_out: ");
    Serial.print( dac_voltage_out);
    Serial.print(" air delay: ");
    Serial.print(air_delay);
    Serial.print( " min_volt_in: ");
    Serial.print(min_volt_in);
    Serial.print(" min_volt_out: ");
    Serial.print(min_volt_out);
     

}


void loop() 
 {

    // for (int counter = 0; counter < 5000000 ; counter++)
    // {

    //   tcaselect(1);
    //   dac_out1.setVoltage(4000, false);
    //   dac_in1.setVoltage(0, false);
      
      
    //   tcaselect(2);
    //   dac_out2.setVoltage(4000, false);
    //   dac_in2.setVoltage(0, false);

    //   tcaselect(7);    
    //   dac_out3.setVoltage(4000, false);
    //   dac_in3.setVoltage(0, false);

    //   // Serial.println(counter);
    //   // Serial.print(" Exhausting");

    // }

    for (int counter = 0; counter < 2000 ; counter++)
    {

      tcaselect(1);
      dac_out1.setVoltage(0, false);
      dac_in1.setVoltage(4095, false);
      
      
      tcaselect(2);
      dac_out2.setVoltage(0, false);
      dac_in2.setVoltage(4095, false);

      tcaselect(7);    
      dac_out3.setVoltage(0, false);
      dac_in3.setVoltage(4095, false);
      
      int UniSensorValue = analogRead(A0);
      int ClampSensorValue = analogRead(A1);
      int UniAngle = 244 - map(UniSensorValue, 0, 1023, 0, 333.3) ;
      int ClampAngle = 209 - map(ClampSensorValue, 0, 1023, 0, 340) + 4;

      Serial.print(counter);
      Serial.print(" , ");
      Serial.print(UniAngle);
      Serial.print(" , ");
      Serial.println(ClampAngle);
      

      // Serial.println(counter);
      // Serial.print(" Leak Check");
 
    }


  
  //  for (int counter = 0; counter < 1000 ; counter++)
  //   {

  //     tcaselect(1);
  //     dac_out1.setVoltage(0, false);
  //     dac_in1.setVoltage(4000, false);
      
      
  //     tcaselect(2);
  //     dac_out2.setVoltage(0, false);
  //     dac_in2.setVoltage(4095, false);

  //     tcaselect(7);    
  //     dac_in3.setVoltage(max(min_volt_in,dac_voltage_in*sin(0.01745*(air_delay*counter+pam_phase3))), false);
  //     dac_out3.setVoltage(max(min_volt_out,dac_voltage_out*sin(0.01745*(air_delay*counter+phase+pam_phase3))), false);

  //     Serial.println(counter);
  //     Serial.print(" Nodding");

  //   }
    
    
for (int counter = 0; counter < max1 ; counter++)
    {
      
      tcaselect(1); 
      dac_in1.setVoltage(max(min_volt_in,dac_voltage_in*sin(0.01745*(air_delay*counter))), false);
      dac_out1.setVoltage(max(min_volt_out,dac_voltage_out*sin(0.01745*(air_delay*counter+phase))), false);
      // dac_out1.setVoltage(0, false);
      // dac_in1.setVoltage(4000, false);

      tcaselect(2);   
      dac_in2.setVoltage(max(min_volt_in,dac_voltage_in*sin(0.01745*(air_delay*counter+pam_phase2))), false);
      dac_out2.setVoltage(max(min_volt_out,dac_voltage_out*sin(0.01745*((air_delay*counter+phase+pam_phase2)))), false);
    
      tcaselect(7); 
      dac_in3.setVoltage(max(min_volt_in,dac_voltage_in*sin(0.01745*(air_delay*counter+pam_phase3))), false);
      dac_out3.setVoltage(max(min_volt_out,dac_voltage_out*sin(0.01745*(air_delay*counter+phase+pam_phase3))), false);
      // dac_out3.setVoltage(0, false);
      // dac_in3.setVoltage(4000, false);
      int UniSensorValue = analogRead(A0);
      int ClampSensorValue = analogRead(A1);
      int UniAngle = 244 - map(UniSensorValue, 0, 1023, 0, 333.3) + 5 ;
      int ClampAngle = 209 - map(ClampSensorValue, 0, 1023, 0, 340) - 4;
      int t = millis();
      Serial.print(t);
      Serial.print(" , ");
      Serial.print(UniAngle);
      Serial.print(" , ");
      Serial.println(ClampAngle);
    }


  // Serial.println("Which PAM would you like to choose");

  // while (Serial.available() == 0) {
  

  // int pamChoice = Serial.parseInt();

  // switch (pamChoice) {
  //   case 1:
  //     Serial.println("What pressure input would you like for PAM 1 ");
  //     while (Serial.available() == 0) {
  //     int pressure1 = Serial.parseInt();
  //     tcaselect(1); 
  //     dac_in1.setVoltage(pressure1, false);
  //     dac_out1.setVoltage(0, false);
  //     Serial.println("PAM 1 Pressure: ");
  //     Serial.print(pressure1);
  //     break;
  //     }
      

  //   case 2:
  //     Serial.println("What pressure input would you like for PAM 2 ");
  //     while (Serial.available() == 0) {
  //     }
  //     delay(1000);
  //     int pressure2 = Serial.parseInt();
  //     tcaselect(2); 
  //     dac_in1.setVoltage(pressure2, false);
  //     dac_out1.setVoltage(0, false);
  //     delay(7000);
  //     break;

  //   case 3:
  //     Serial.println("What pressure input would you like for PAM 3 ");
  //     while (Serial.available() == 0) {
  //     }
  //     int pressure3 = Serial.parseInt();
  //     tcaselect(7); 
  //     dac_in1.setVoltage(pressure3, false);
  //     dac_out1.setVoltage(0, false);
  //     delay(7000);
  //     break;

  //   default:
  //     Serial.println("Please choose a valid selection");
  // }

  // }
delay(400);
   
    
 
}