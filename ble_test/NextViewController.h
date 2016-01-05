//
//  NextViewController.h
//  ble_test
//
//  Created by KyungWooMin on 2015. 11. 25..
//  Copyright © 2015년 KyungWooMin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CorePlotHeaders/CorePlot-CocoaTouch.h"

#import "MyConstants.h"

@interface NextViewController  : UIViewController <CPTPlotDataSource>{
    
@private dispatch_queue_t dqueue;
@private uint64_t endRangeCount;
@private uint16_t defaultRangeCount;
}

+ (NextViewController *)sharedInstance;

@property (nonatomic, strong) CPTGraphHostingView *hostView;


@property BOOL isFirst;
@property float xRangeValue;
@property (nonatomic, strong) CPTXYPlotSpace *myplotSpace;
@property (nonatomic, strong)   CPTScatterPlot *TempertureSenserPlot ;
@property (nonatomic, strong) CPTScatterPlot *LightSensorPlot;

@property (nonatomic, strong) CPTMutableTextStyle *axisTitleStyle;
@property (nonatomic, strong) CPTMutableLineStyle *axisLineStyle;
@property (nonatomic, strong) CPTMutableTextStyle *axisTextStyle;
@property (nonatomic, strong) CPTMutableLineStyle *tickLineStyle;
@property (nonatomic, strong) CPTMutableLineStyle *gridLineStyle;
@property (nonatomic, strong) CPTXYAxisSet *axisSet;

@property (nonatomic, retain) NSMutableArray *plotData;
@property (nonatomic, retain) NSMutableArray *LightPlotData;

@property NSUInteger currentIndex;
@property (nonatomic, retain) NSTimer *dataTimer;
@property (nonatomic, retain) NSTimer *dataTimer2;

-(BOOL) shouldAutorotate;
-(NSUInteger) supportedInterfaceOrientations;
-(void)newData :(NSTimer*)theTimer;
-(void)newnewDataLightSensor:(NSTimer*)theTimer;
@end
