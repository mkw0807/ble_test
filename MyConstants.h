//
//  MyConstants.h
//  ble_test
//
//  Created by KyungWooMin on 2015. 11. 30..
//  Copyright © 2015년 KyungWooMin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface MyConstants : NSObject

extern NSString * const MyTempSymbol;
extern NSString * const MyLightSymbol;
extern float TimeInterval;
extern uint32_t endRangeCount;
extern uint32_t startRangeCount;

@property float XRange;
@property float yData;
@property (strong, nonatomic) CBPeripheral *discoveredPeripheral;
@property (strong, nonatomic) CBCharacteristic *discoveredCharacteristicSensor;
@property (strong, nonatomic) CBCharacteristic *discoveredCharacteristicLED;
@property float LightValue;
+ (MyConstants *)sharedInstance;

- (float)getXRange;
- (float)getYData;

- (float)getLightValueData;

- (void) setXRange:(int)incresedXRangeValue;

- (void) setYDataValue:(float )senserData;
- (void) setLigthValueData:(float )LightsensorData;
- (void) setPeripheral:(CBPeripheral *)discoveredPeripheral;
- (CBPeripheral *) getPeripheral;
- (void) setLedCharacteristic:(CBCharacteristic *)discoveredCharacteristic;
- (CBCharacteristic *) getLedCharacteristic;
- (void) setSensorCharacteristic:(CBCharacteristic *) discoveredCharacteristic;
- (CBCharacteristic *) getSensorCharacteristic;

@end
