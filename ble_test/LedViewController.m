//
//  LedViewController.m
//  ble_test
//
//  Created by KyungWooMin on 2015. 12. 9..
//  Copyright © 2015년 KyungWooMin. All rights reserved.
//

#import "LedViewController.h"
#import <stdlib.h>

@interface LedViewController ()

@end

@implementation LedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.discoveredPerihpheral = [[MyConstants sharedInstance] getPeripheral];
    [self findLedServiceFromDevice];
    self.SeekBarDataArray = [[NSMutableArray alloc] initWithCapacity:4];
    
    
    
 }

-(void)viewDidDisappear:(BOOL)animated
{
        [super viewDidAppear:animated];
    
   
}
- (IBAction)RedSliderValueChanged:(id)sender {
    
    RedValue = (int) self.RedSlider.value;
    
   // NSLog(@" a = %d", a);
    
    //yte byteArray[4];
    byteArray[0] = (Byte) (MotorSpeedValue >> 0 & 0xff);
    byteArray[1] = (Byte) (BlueValue >> 0 & 0xff);
    byteArray[2] = (Byte) (GreenValue >> 0 & 0xff);
    byteArray[3] = (Byte) (RedValue >> (0 & 0xff));

    
    NSData *data = [NSData dataWithBytes:(const void*)byteArray length:4]; //   self.SeekBarDataArray[0] = [NSNumber numberWithInt:byteArray];
    
    [self.discoveredPerihpheral writeValue:data forCharacteristic:[[MyConstants sharedInstance] getLedCharacteristic] type:CBCharacteristicWriteWithResponse];
    
}

- (void) findLedServiceFromDevice{
    
    
    for(CBService *service in self.discoveredPerihpheral.services)
    {
        
        NSString *DiscoveredResult = [NSString stringWithFormat:@"Discovered service %@\n", service];
        
        NSLog(@"%@",DiscoveredResult);
      //  self.txtView.text = string;
      
        //  NSLog(@"Discovered service %@", service);
        [self.discoveredPerihpheral discoverCharacteristics:@[[CBUUID UUIDWithString:@"0xFFFB"]] forService:service];  //0000fffe-0000-1000-8000-00805f9b34fb
        
    }

}
- (IBAction)GreenSliderValueChanged:(id)sender {
    GreenValue = (int) self.GreenSlider.value;
    byteArray[0] = (Byte) (MotorSpeedValue >> 0 & 0xff);
    byteArray[1] = (Byte) (BlueValue >> 0 & 0xff);
    byteArray[2] = (Byte) (GreenValue >> 0 & 0xff);
    byteArray[3] = (Byte) (RedValue >> (0 & 0xff));
    
    
    NSData *data = [NSData dataWithBytes:(const void*)byteArray length:4]; //   self.SeekBarDataArray[0] = [NSNumber numberWithInt:byteArray];
    
    [self.discoveredPerihpheral writeValue:data forCharacteristic:[[MyConstants sharedInstance] getLedCharacteristic] type:CBCharacteristicWriteWithResponse];
    
}

- (IBAction)BlueSliderValueChanged:(id)sender {
    BlueValue = (int) self.BlueSlider.value;
    byteArray[0] = (Byte) (MotorSpeedValue >> 0 & 0xff);
    byteArray[1] = (Byte) (BlueValue >> 0 & 0xff);
    byteArray[2] = (Byte) (GreenValue >> 0 & 0xff);
    byteArray[3] = (Byte) (RedValue >> (0 & 0xff));
    
    
    NSData *data = [NSData dataWithBytes:(const void*)byteArray length:4]; //   self.SeekBarDataArray[0] = [NSNumber numberWithInt:byteArray];
    
    [self.discoveredPerihpheral writeValue:data forCharacteristic:[[MyConstants sharedInstance] getLedCharacteristic] type:CBCharacteristicWriteWithResponse];
    
    
}
- (IBAction)MotorSliderValueChanged:(id)sender {
    
    MotorSpeedValue = (int) self.MotorSlider.value;
    byteArray[0] = (Byte) (MotorSpeedValue >> 0 & 0xff);
    byteArray[1] = (Byte) (BlueValue >> 0 & 0xff);
    byteArray[2] = (Byte) (GreenValue >> 0 & 0xff);
    byteArray[3] = (Byte) (RedValue >> (0 & 0xff));
    
    
    NSData *data = [NSData dataWithBytes:(const void*)byteArray length:4]; //   self.SeekBarDataArray[0] = [NSNumber numberWithInt:byteArray];
    
    [self.discoveredPerihpheral writeValue:data forCharacteristic:[[MyConstants sharedInstance] getLedCharacteristic] type:CBCharacteristicWriteWithResponse];
    

}

-(void)WriteToDevice
{
    
}

- (void)dealloc {
    [_RedSlider release];
    [_GreenSlider release];
    [_BlueSlider release];
    [super dealloc];
}
@end
