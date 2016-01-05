//
//  MyConstants.m
//  ble_test
//
//  Created by KyungWooMin on 2015. 11. 30..
//  Copyright © 2015년 KyungWooMin. All rights reserved.
//

#import "MyConstants.h"
@interface MyConstants()

@end

@implementation MyConstants
   

#pragma mark - Class methods                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                

+ (MyConstants *)sharedInstance
{
    static MyConstants *sharedInstance;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    
    });
    
    return sharedInstance;
}

NSString * const MyTempSymbol = @"Temperture";
NSString * const MyLightSymbol = @"Light";
float TimeInterval = 0.1f;

uint32_t endRangeCount = 50;
uint32_t startRangeCount = 0;
#pragma mark - API methods

-(float)getXRange
{
    return self.XRange;
}

-(float)getYData
{
    return self.yData;
}

-(float)getLightValueData
{
    return self.LightValue;
}


-(void) setXRange:(NSDecimalNumber *)incresedXRangeValue
{
    self.xRange = incresedXRangeValue;
}

-(void) setYDataValue:(float )senserData
{
    self.yData = senserData;
}

-(void) setLigthValueData:(float)LightsensorData{
    
    self.LightValue = LightsensorData;
}

-(void) setPeripheral:(CBPeripheral *)Peripheral{
    self.discoveredPeripheral = Peripheral;
}

-(CBPeripheral*) getPeripheral{

    if(self.discoveredPeripheral == nil)
    {
        return nil;
    }
    return self.discoveredPeripheral;
}

-(void) setLedCharacteristic:(CBCharacteristic *)discoveredCharacteristic{
    self.discoveredCharacteristicLED = discoveredCharacteristic;
}

-(CBCharacteristic *) getLedCharacteristic{
    
    if(self.discoveredCharacteristicLED == nil)
    {
        return nil;
    }
    
    return self. discoveredCharacteristicLED;
}

- (void) setSensorCharacteristic:(CBCharacteristic *)discoveredCharacteristic{
    self.discoveredCharacteristicSensor = discoveredCharacteristic;
}

- (CBCharacteristic *) getSensorCharacteristic{
    
    if (self.discoveredCharacteristicSensor == nil)
    {
        return nil;
    }
    
    return self.discoveredCharacteristicSensor;
}



@end
