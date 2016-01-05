//
//  LedViewController.h
//  ble_test
//
//  Created by KyungWooMin on 2015. 12. 9..
//  Copyright © 2015년 KyungWooMin. All rights reserved.
//





#import <UIKit/UIKit.h>
#import "MyConstants.h"
#import <CoreBluetooth/CoreBluetooth.h>


@interface LedViewController : UIViewController
{
@private Byte byteArray[4];
@private int RedValue,GreenValue, BlueValue, MotorSpeedValue;
    
}
@property (retain, nonatomic) IBOutlet UISlider *RedSlider;
@property (retain, nonatomic) IBOutlet UISlider *GreenSlider;
@property (retain, nonatomic) IBOutlet UISlider *BlueSlider;
@property (retain, nonatomic) IBOutlet UISlider *MotorSlider;

@property (strong, nonatomic) CBPeripheral *discoveredPerihpheral;
@property (strong, nonatomic) CBCharacteristic *writeCharacteristic;


@property (retain, nonatomic) NSMutableArray *SeekBarDataArray;



@end
