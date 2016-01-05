//
//  ViewController.m
//  ble_test
//
//  Created by KyungWooMin on 2015. 11. 3..
//  Copyright © 2015년 KyungWooMin. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()

@end

@implementation ViewController

+ (ViewController *)sharedInstance
{
    static ViewController *sharedInstance;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setBorderColorForTextView];
    [self initLabelText];
    [self initTempValue];
    

    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    _data = [[NSMutableData alloc] init];
    
}


/***********************************************************************************************
 * 함수용도 :
 * 파라미터 :
 *
 **********************************************************************************************/
-(void) initTempValue{
    
//    self.Temp = [[NSArray alloc] initWithObjects:@"1.5614f, 1.5345f, 1.5061f, 1.4759f, 1.4438f, 1.4096f, 1.3821f, 1.3532f, 1.3227f, 1.2906f, 1.2567f, 1.2293f, 1.2006f, 1.1707f, 1.1393f, 1.1071f, 1.0808f, 1.0536f, 1.0252f, 0.9957f, 0.965f, 0.9403f, 0.9149f, 0.8886f, 0.8614f, 0.8333f, 0.8108f, 0.7876f, 0.7637f, 0.7392f, 0.714f, 0.6938f, 0.6731f, 0.652f, 0.6303f, 0.6081f, 0.5903f, 0.5672f, 0.5435f, 0.5192f, 0.5155f, 0.5f, 0.4843f, 0.4683f, 0.4521f, 0.4356f, 0.4223f, 0.4088f, 0.3951f, 0.3813f, 0.3673f, 0.3559f, 0.3445f, 0.3329f, 0.3212f, 0.3094f, 0.2998f, 0.2902f,0.2804f, 0.2706f, 0.2607f, 0.2526f, 0.2445f, 0.2363f, 0.228f, 0.2197f, 0.2129f, 0.2061f, 0.1992f, 0.1992f, 0.1854f, 0.1797f, 0.174f, 0.1682f, 0.1625f, 0.1567f, 0.1519f, 0.1471f, 0.1423f, 0.1375f, 0.1327f, 0.1287f, 0.1247f, 0.1207f, 0.1167f, 0.1127f, 0.1093f, 0.106f, 0.1026f, 0.0992f, 0.0958f", nil];

   
    self.Temp = [[NSMutableArray alloc] initWithCapacity:91];
    
    [self.Temp addObject: [NSNumber numberWithDouble:1.5614f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.5345f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.5061f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.4759f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.4438f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.4096f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.3821f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.3532f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.3227f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.2906f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.2567f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.2293f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.2006f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.1707f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.1393f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.1071f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.0808f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.0536f]];
    [self.Temp addObject: [NSNumber numberWithDouble:1.0252f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.9957f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.965f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.9403f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.9149f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.8886f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.8614f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.8333f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.8108f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.7876f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.7637f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.7392f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.714f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.6938f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.6731f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.652f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.6303f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.6081f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.5903f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.5672f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.5435f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.5192f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.5155f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.5f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.4843f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.4683f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.4521f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.4356f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.4223f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.4088f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.3951f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.3813f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.3673f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.3559f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.3445f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.3329f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.3212f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.3094f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.2998f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.2902f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.2804f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.2706f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.2607f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.2526f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.2445f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.2363f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.228f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.2197f]];
    
    [self.Temp addObject: [NSNumber numberWithDouble:0.2129f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.2061f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1992f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1992f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1854f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1797f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.174f]];
    
    [self.Temp addObject: [NSNumber numberWithDouble:0.1682f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1625f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1567f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1519f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1471f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1423f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1375f]];
    

    [self.Temp addObject: [NSNumber numberWithDouble:0.1327f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1287f]];
    
    [self.Temp addObject: [NSNumber numberWithDouble:0.1247f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1207f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1167f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1127f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1093f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.106f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.1026f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.0992f]];
    [self.Temp addObject: [NSNumber numberWithDouble:0.0958f]];


    
}

/***********************************************************************************************
 * 함수용도 :
 * 파라미터 :
 *
 **********************************************************************************************/
-(NSInteger) byteTointeger:(Byte [])src
{
    int s1 = src[0] & 0xFF;
    
    int s2 = src[1] & 0xFF;
    
    return ((s1 << 8) + (s2 << 0));
}

/***********************************************************************************************
 * 함수용도 :
 * 파라미터 :
 *
 **********************************************************************************************/
- (void) setBorderColorForTextView
{
    self.txtView.layer.borderColor = [[UIColor blackColor]CGColor];
    self.txtView.layer.borderWidth = 2.0f;
    
    self.dataView.layer.borderColor = [[UIColor blackColor]CGColor];
    self.dataView.layer.borderWidth = 2.0f;
    
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.centralManager stopScan];
    
 //   NSLog(@"Scanning stopped");
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/***********************************************************************************************
 * 함수용도 :
 * 파라미터 :
 *
 **********************************************************************************************/
-(void) initLabelText
{
    self.lblSrch.text = @"Scanning Stop";
    self.lblPeripheral.text = @"None";
}
-(void) startBluetoothStatusMonitoring{
    
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue() options:@{CBCentralManagerOptionShowPowerAlertKey: @(NO)}];
}

#pragma mark - CBCentralManagerDelegate

- (void) centralManagerDidUpdateState:(CBCentralManager *)central
{
    if([central state] == CBCentralManagerStatePoweredOff)
    {
        _lblState.text = @"Bluetooth State : Off";
    }
    else{
        _lblState.text = @"Bluetooth State : On";
    }
    
    if (central.state == CBCentralManagerStatePoweredOn)
    {
        //[self scan];
        
    }
}


-(void) scan
{
    //[_centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"9A98CCB0-2EE3-223A-F3EA-6FAB67135203"]]  options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @ YES}];
    
    _lblSrch.text = @"Scanning started..";
}

-(void) cleanup{
    
    //Dont do anything if we're not connected.
    if(!self.discoveredPeripheral.state == 0)
    {
        return;
    }
    
    //See if we are subscribed to a characteristic on the peripheral
    if(self.discoveredPeripheral.services != nil){
        for(CBService *service in self.discoveredPeripheral.services){
            if(service.characteristics != nil){
                for(CBCharacteristic *characteristic in service.characteristics){
                    if([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"0000fffe-0000-1000-8000-00805f9b34fb"]])
                    {
                        if(characteristic.isNotifying){
                            //it is notifying, so unsubscribe
                            [self.discoveredPeripheral setNotifyValue:NO forCharacteristic:characteristic];
                            
                            //And We're done.
                            
                            return;
                        }
                    }
                }
            }
        }
    }
    
    //if we've got this far, we're connected. but we're not subscribed, so we just disconnect
    [self.centralManager cancelPeripheralConnection:self.discoveredPeripheral];
}
- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(nonnull CBPeripheral *)peripheral advertisementData:( NSDictionary *)advertisementData RSSI:( NSNumber *)RSSI{
    
    self.txtView.text = @"";
    self.dataView.text = @"";
    
    
    NSString *DiscoveredResult = [NSString stringWithFormat:@"Discovered Peripheral Name = %@  RSSI = %@\n", peripheral.name, RSSI];

    NSString *string = [self.txtView.text stringByAppendingString:DiscoveredResult];
    
    self.txtView.text = string;
    //    NSLog(@"Discoverd %@ at %@ %d", peripheral.name , RSSI, peripheral.state);
    
    
    if(self.discoveredPeripheral != peripheral)
    {
        self.discoveredPeripheral = peripheral;
        
        [[MyConstants sharedInstance]setPeripheral:self.discoveredPeripheral];
        
        _lblPeripheral.text = peripheral.name;
        
        [self.centralManager connectPeripheral:self.discoveredPeripheral options:nil];
    }
  
}

-(void) centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(nonnull CBPeripheral *)peripheral error:( NSError *)error{
    

    _lblPeripheral.text = @"Failed to connect";
    
    [self cleanup];
}


-(void) centralManager:(CBCentralManager *) central didConnectPeripheral:(nonnull CBPeripheral *)peripheral{
    
    [_centralManager stopScan];
    
    _lblRSSI.text = @"Connected";
    
    self.lblSrch.text = @"Scanning Stop";
    
 
    
    [_data setLength: 0];
    
    peripheral.delegate = self;
    
    if(peripheral.services)
    {
        [self peripheral:peripheral didDiscoverServices:nil];
    }
    else{
        [peripheral discoverServices:@[[CBUUID UUIDWithString:@"0xFFFA"]]]; //0000fffa-0000-1000-8000-00805f9b34fb
    
        
    }
}


-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error
{
    if(error){
        _lblSrch.text = @"Error discovering services: %@", [error localizedDescription];
        [self cleanup];
        
        return;
    }
    
//    for(CBService *service in peripheral.services)
//    {
//        
//        NSString *DiscoveredResult = [NSString stringWithFormat:@"Discovered service %@\n", service];
//        
//        NSString *string = [self.txtView.text stringByAppendingString:DiscoveredResult];
//        
//        self.txtView.text = string;
//        
//      //  NSLog(@"Discovered service %@", service);
//        if(self.ReadSensorState)
//        {
//            [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:@"0xFFFE"]] forService:service];  //0000fffe-0000-1000-8000-00805f9b34fb
//
//        }
//        else if(self.ControlLedState)
//        {
//             [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:@"0xFFFB"]] forService:service];
//        }
//       
//    }
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(nonnull CBService *)service error:(nullable NSError *)error{
    
    if(error){
        _lblSrch.text = @"Error discovering characteristics : %@", [error localizedDescription];
        
        [self cleanup];
        
        return;
    }
    
    for(CBCharacteristic *characteristic in service.characteristics)
    {
        if([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"0xFFFE"]])
        {  //0000fffe-0000-1000-8000-00805f9b34fb
            NSString *DiscoveredResult = [NSString stringWithFormat:@"Discovered chracteristic %@\n", characteristic];
            
            NSString *string = [self.txtView.text stringByAppendingString:DiscoveredResult];
            
            self.txtView.text = string;
            
           // NSLog(@"Discovered chracteristic %@", characteristic);
            [[MyConstants sharedInstance] setSensorCharacteristic:characteristic];
            
                        //[peripheral setNotifyValue:YES forCharacteristic:characteristic];
            
           //[peripheral readValueForCharacteristic:characteristic];
        
       
        }
        else if([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"0xFFFB"]])
        {
            [[MyConstants sharedInstance] setLedCharacteristic:characteristic];
        }
    }
}

-(void) peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
    if(error)
    {
        NSLog(@"Error Writing characteristic value: %@", [error localizedDescription]);
    }
}
-(void) peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
    if(error){
        _lblSrch.text = @"Error discovering characteristics: %@\n", [error localizedDescription];
        
        return;
    }
//    
//    NSString *stringFromData = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
//    
//    if([stringFromData isEqualToString:@"EOM"]){
//        
//        _lblData.text = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
//        
//        [peripheral setNotifyValue:NO forCharacteristic:characteristic];
//        
//        [self.centralManager cancelPeripheralConnection:peripheral];
//    }
//    
//    [self.data appendData:characteristic.value];
    
    NSData *data = [[NSData alloc] initWithData:characteristic.value];
    uint8_t byteArray[[data length]];
    [data getBytes:&byteArray];
    
    uint8_t ai00_byteArray[2];
    uint8_t ai01_byteArray[2];
    uint8_t ai02_byteArray[2];
    
    ai02_byteArray[0] = byteArray[0];
    ai02_byteArray[1] = byteArray[1];
    
   
    ai01_byteArray[0] = byteArray[2];
    ai01_byteArray[1] = byteArray[3];
    
    int s3_1 = [self byte2Int:ai01_byteArray];
    
    [self AI0_1_light: (s3_1 * 0.001)];
    
    ai00_byteArray[0] = byteArray[4];
    ai00_byteArray[1] = byteArray[5];
   
    int s3 = [self byte2Int:ai00_byteArray];
    
    [self AI0_0_temp: (s3 * 0.001)];
    
    
    
//    [self.AI02_byte addObject:[NSNumber numberWithInt:byteArray[0]]];
//    [self.AI02_byte addObject:[NSNumber numberWithInt:byteArray[1]]];
//
//    [self.AI01_byte addObject:[NSNumber numberWithInt:byteArray[2]]];
//    [self.AI01_byte addObject:[NSNumber numberWithInt:byteArray[3]]];
//
//    [self.AI00_byte addObject:[NSNumber numberWithInt:byteArray[4]]];
//    [self.AI00_byte addObject:[NSNumber numberWithInt:byteArray[5]]];

//    
//    for(int i =0; i<[data length]; i++)
//    {
//        char byted = byteArray[i];
//        NSLog(@"%d, %p,  %d",byteArray[i], &byteArray[i], [self.Temp count]);
//    }
//    


   // NSLog(@"Data Length : %d", [data length]);
    
//   NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
   // NSRange a = [s rangeOfString:@"x"];
    
    
    
   // NSLog(@"data is %@", s);
    
    NSLog(@"Real Data is Ligtht: %f   Temperature: %f  ", [[MyConstants sharedInstance] getLightValueData], [[MyConstants sharedInstance] getYData]);
    

    NSString *convertedToString = [NSString stringWithFormat:@"Received Data :%@                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     \n", data];
    
    //NSString *string = [self.dataView.text stringByAppendingString:convertedToString];
    
    self.dataView.text = convertedToString;
    
    
    //NSLog(@"Received Data : %@", data);
    


    
    
    self.states = true;
}
- (void) AI0_1_light:(double) volt
{
    double temp0 = 100 - (volt /1.280 *100);
    
    float fCasting = temp0;
    
    [[MyConstants sharedInstance] setLigthValueData:fCasting];
    
    
    //NSLog(@"Real Light value is %g", fCasting);
}
- (void) AI0_0_temp:(double) volt
{
    
    NSString *makeString = [NSString string];
    
//
    
    for(int i =0; i <= ([self.Temp count] - 2); i++)
    {
        double t_value = [[self.Temp objectAtIndex:i] doubleValue];
        double t_value_next = [[self.Temp objectAtIndex:i+1] doubleValue];
        
        if((t_value >= volt) & ( volt >= t_value_next))
        {
            double temp0 = t_value - t_value_next;
            double temp1 = t_value - volt;
            double temp2 = temp1 / temp0 * 10;
            int tempint = (int)temp2;
            
            //tempint가 실제 온도 값
            
            makeString = [NSString stringWithFormat:@"%d.",i];
            makeString = [makeString stringByAppendingString:[NSString stringWithFormat:@"%d",tempint]];
            float fCasting = [makeString floatValue];
            
            
            //NSDecimalNumber *RealData = [[NSDecimalNumber alloc] initWithFloat:fCasting];
            [[MyConstants sharedInstance] setYDataValue:fCasting];
            
         //   NSLog(@" real Temp is %f", [[MyConstants sharedInstance] getYData]);
            
            break;
        }
       
    }

}

//byte to integer
- (int) byte2Int:(Byte []) src
{
    int s1 = src[0] & 0xFF;
    int s2 = src[1] & 0xFF;
  
    
    return ((s1 << 8) + (s2 << 0));
}
- (void) peripheral:(CBPeripheral *) peripheral didUpdateNotificationStateForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
    if(error){
        NSLog(@"Error changing notification state : %@", error.localizedDescription);
    }
    
    //Exit if it's not the transfer characteristic
    if(![characteristic.UUID isEqual:[CBUUID UUIDWithString:@"0000fffe-0000-1000-8000-00805f9b34fb"]]){
        return;
    }
    
    //Notification has started
    
    if(characteristic.isNotifying){
        NSLog(@"Notification began on %@", characteristic);
    }
    else{
        //Notification has stopped
        NSLog(@"Notification stopped on %@. Disconnecting", characteristic);
        
        [self.centralManager cancelPeripheralConnection:peripheral];
    }
}

-(void) centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
    
    NSString *string = [self.txtView.text stringByAppendingString:@"Peripheral Disconnected\n"];
    
    self.txtView.text = string;
    
   // NSLog(@"Peripheral Disconnected");
    
    self.discoveredPeripheral = nil;
    
    // we're disconnected, so start scanning again
    //[self scan];
}
-(IBAction)btnSrch{
    
   
    _lblSrch.text = @"Scanning started..";

    [_centralManager scanForPeripheralsWithServices:nil options:nil];
}
- (IBAction)btnFindService:(id)sender {
    
        for(CBService *service in self.discoveredPeripheral.services)
    {
        
        NSString *DiscoveredResult = [NSString stringWithFormat:@"Discovered service %@\n", service];
        
        NSString *string = [self.txtView.text stringByAppendingString:DiscoveredResult];
        
        self.txtView.text = string;
        
        //  NSLog(@"Discovered service %@", service);
        [self.discoveredPeripheral discoverCharacteristics:@[[CBUUID UUIDWithString:@"0xFFFE"]] forService:service];  //0000fffe-0000-1000-8000-00805f9b34fb
        
    }
}

-(IBAction)btnGetData{
    self.states = true;

//    self.mThread = [[NSThread alloc] initWithTarget:self selector:@selector(readSensorData) object:nil];
//
//    [self.mThread start];
//    
//    [self readSensorData];
   
//    [NSThread sleepForTimeInterval:0.1f];
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    
    dispatch_async(queue, ^{
        [self readSensorData];
    });
}

-(void) readSensorData{
    while(1)
    {
        [self.discoveredPeripheral readValueForCharacteristic:[[MyConstants sharedInstance] getSensorCharacteristic]];
        
        
    
//        NSRange range = NSMakeRange(self.txtView.text.length - 1, 1);
//        [self.txtView scrollRangeToVisible:range];
        
      
        
        [NSThread sleepForTimeInterval:TimeInterval];
        
        
    }
//    if(self.states != false)
//      {
//        
//       // [self readSensorData];
//    }
//    else{
//        
//        return;
//    }

    
    
}
-(IBAction)btnDisconnect{
    if(self.discoveredPeripheral != NULL)
    {
        self.lblRSSI.text = @"Disconnected";
        self.lblPeripheral.text = @"None";
        
        [self.centralManager cancelPeripheralConnection:self.discoveredPeripheral];
    }
}

-(IBAction)btnStopGetData{
    self.states = false;
}

-(IBAction)popupSetting{
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];

    NextViewController *modalView = [[NextViewController alloc] init];
    [modalView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:modalView animated:YES];
    
}

-(CBPeripheral *)GetConnectedPeripheral{
    
    return self.discoveredPeripheral;
}

-(CBCharacteristic *)GetWriteCharacteristic{
    return self.discoveredCharacteristicLED;
}
-(void) setStateControlLed:(BOOL)isState
{
    self.ControlLedState = isState;
}

-(void) setStateReadSensor:(BOOL)isState
{
    self.ReadSensorState = isState;
}
- (void)dealloc {
    [_btnFindService release];
        [super dealloc];
}
@end
