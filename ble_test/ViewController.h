                                                                                                              //
//  ViewController.h
//  ble_test
//
//  Created by KyungWooMin on 2015. 11. 3..
//  Copyright © 2015년 KyungWooMin. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import "MyConstants.h"
#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <CBCentralManagerDelegate, CBPeripheralDelegate, NSURLConnectionDataDelegate>

-(void) printText;

- (IBAction)btnSrch;
- (IBAction)btnServer;
- (IBAction)btnGetData;
- (IBAction)btnStopGetData;
- (IBAction)btnDisconnect;
- (IBAction)popupSetting;

+ (ViewController *)sharedInstance;

@property (retain, nonatomic) IBOutlet UIButton *btnFindService;

@property (strong, nonatomic) IBOutlet UILabel *lblState;
@property (strong, nonatomic) IBOutlet UILabel *lblSrch;
@property (strong, nonatomic) IBOutlet UIView *GraphView;

@property (strong, nonatomic) IBOutlet UILabel *lblPeripheral;

@property (strong, nonatomic) IBOutlet UILabel *lblRSSI;

@property (strong, nonatomic) IBOutlet UILabel *lblData;
@property (strong, nonatomic) IBOutlet UITextView *txtView;
@property (strong, nonatomic) IBOutlet UITextView *dataView;

@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic) CBPeripheral *discoveredPeripheral;
@property (strong, nonatomic) CBCharacteristic *discoveredCharacteristicSensor;
@property (strong, nonatomic) CBCharacteristic *discoveredCharacteristicLED;
@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) NSURLConnection *connectionServer;
@property (retain, nonatomic) NSThread *mThread;
@property (retain, nonatomic) NSMutableArray *Temp;
//@property (retain, nonatomic) NSMutableArray *AI00_byte;
//@property (retain, nonatomic) NSMutableArray *AI01_byte;
//@property (retain, nonatomic) NSMutableArray *AI02_byte;

@property NSNumber *dblTemp;
@property double *temp_fix;

-(CBPeripheral *) GetConnectedPeripheral;
-(CBCharacteristic *)GetWriteCharacteristic;

@property BOOL ReadSensorState;
@property BOOL ControlLedState;

@property BOOL states;


-(void) setStateReadSensor:(BOOL) isState;

-(void) setStateControlLed:(BOOL) isState;

-(BOOL) getStateReadSensor;

-(BOOL) getStateControlLed;


@end


///////////////////....