  //
//  NextViewController.m
//  ble_test
//
//  Created by KyungWooMin on 2015. 11. 25..
//  Copyright © 2015년 KyungWooMin. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController
@synthesize hostView = _hostView;

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    // Do any additional setup after loading the view.
//}

//#pragma mark - Rotation
//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
//}

//- (BOOL) shouldAutorotate{
//    
//    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//   
//    
//    return YES;
//    
//}
//
//-(NSUInteger)supportedInterfaceOrientations{
//    
//    return UIInterfaceOrientationLandscapeLeft;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIViewController lifecycle methods;
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    self.isFirst = true;
    [self initPlot];

    self.currentIndex = 0;
    
    
    [self.plotData init];
    [self.LightPlotData init];
    
    [self.dataTimer invalidate];
    [self.dataTimer release];
    
    self.dataTimer = [[NSTimer timerWithTimeInterval:TimeInterval target:self selector:@selector(newData:) userInfo:nil repeats:YES] retain];
    
    [[NSRunLoop mainRunLoop] addTimer:self.dataTimer forMode:NSDefaultRunLoopMode];
    
    [self.dataTimer2 invalidate];
    [self.dataTimer2 release];
    
    self.dataTimer2 = [[NSTimer timerWithTimeInterval:TimeInterval target:self selector:@selector(newDataLightSensor:) userInfo:nil repeats:YES] retain];
    
    [[NSRunLoop mainRunLoop] addTimer:self.dataTimer2 forMode:NSDefaultRunLoopMode];
    
     dqueue = dispatch_queue_create("myGraph", NULL);
    
    dispatch_async(dqueue, ^{
        [self drawGraph];
    });
    //[self drawGraph];
    
}
- (void) viewWillDisappear:(BOOL)animated
{
    [self.dataTimer invalidate];
    
    self.dataTimer = nil;
    
    [self.dataTimer2 invalidate];
    
    self.dataTimer2 = nil;
    dqueue = nil;
    [super viewWillDisappear:animated];
}
-(IBAction)returnToMain:(UIStoryboardSegue *)segue
{
    
}

#pragma mark - Chart behavior
-(void) initPlot{
    
    self.plotData =[[NSMutableArray alloc] initWithCapacity:50];
    self.LightPlotData = [[NSMutableArray alloc] initWithCapacity:50];
    self.dataTimer = nil;
    self.dataTimer2 = nil;
    
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
   
    
}

-(void)configureHost{
    self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
    self.hostView.allowPinchScaling = YES;
    [self.view addSubview:self.hostView];
}

-(void)configureGraph{
    // Create the graph
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    [graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
    self.hostView.hostedGraph = graph;
    
    // Set graph title
    NSString *title = @"Senser Data Graph";
    graph.title = title;
    
    // Create and set text style
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor whiteColor];
    titleStyle.fontName = @"Helvetica-Bold";
    titleStyle.fontSize = 16.0f;
    
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, 10.0f);
    
    //Set Padding for plot area
    [graph.plotAreaFrame setPaddingLeft:30.0f];
    [graph.plotAreaFrame setPaddingBottom:50.0f];
    [graph.plotAreaFrame setPaddingTop:20.0f];
    [graph.plotAreaFrame setPaddingRight:30.0f];
    
    
    //Enable user interatcions for plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromCGFloat(0) length:CPTDecimalFromCGFloat(100)];
    plotSpace.globalYRange = plotSpace.yRange;
    
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromCGFloat(0) length:CPTDecimalFromCGFloat(50)];
    plotSpace.globalXRange = plotSpace.xRange;
    
    plotSpace.allowsUserInteraction = YES;
    
  
}

-(void)configurePlots{
    //Get graph and plot space
    CPTGraph *graph = self.hostView.hostedGraph;
    
    self.myplotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    //Create the three plots
     //1. Temperture
   self.TempertureSenserPlot= [[CPTScatterPlot alloc] init];
    self.TempertureSenserPlot.dataSource = self;
    self.TempertureSenserPlot.identifier = MyTempSymbol;
    CPTColor * TempColor = [CPTColor redColor];
    
    [graph addPlot:self.TempertureSenserPlot toPlotSpace:self.myplotSpace];


     //2. Light
    
    
    self.LightSensorPlot = [[CPTScatterPlot alloc] init];
    self.LightSensorPlot.dataSource = self;
    self.LightSensorPlot.identifier = MyLightSymbol;
    CPTColor * LightColor = [CPTColor yellowColor];
    
    [graph addPlot:self.LightSensorPlot toPlotSpace:self.myplotSpace];
    

    
    //Set up plot space
    [self.myplotSpace scaleToFitPlots:[NSArray arrayWithObjects:self.TempertureSenserPlot, self.LightSensorPlot, nil]];
    CPTMutablePlotRange *xRange = [self.myplotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
    self.myplotSpace.xRange = xRange;
    
    CPTMutablePlotRange *yRange = [self.myplotSpace.yRange mutableCopy];
    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.2f)];
    self.myplotSpace.yRange = yRange;
    
    //Create Line styles
    CPTMutableLineStyle *TempLineStyle = [self.TempertureSenserPlot.dataLineStyle mutableCopy];
    TempLineStyle.lineWidth = 2.5;
    TempLineStyle.lineColor = TempColor;
    CPTMutableLineStyle *TempSymbolLineStyle = [CPTMutableLineStyle lineStyle];
    TempSymbolLineStyle.lineColor = TempColor;
    
//    CPTPlotSymbol *TempSymbol = [CPTPlotSymbol ellipsePlotSymbol];
//    TempSymbol.fill = [CPTFill fillWithColor:TempColor];
//    TempSymbol.lineStyle = TempSymbolLineStyle;
//    TempSymbol.size = CGSizeMake(6.0f, 6.0f);
//    self.TempertureSenserPlot.plotSymbol = TempSymbol;
    
    CPTMutableLineStyle *LightLineStyle = [self.LightSensorPlot.dataLineStyle mutableCopy];
    LightLineStyle.lineWidth = 2.5;
    LightLineStyle.lineColor = LightColor;
    CPTMutableLineStyle *LightSymbolLineStyle = [CPTMutableLineStyle lineStyle];
    LightSymbolLineStyle.lineColor = LightColor;
    
//    CPTPlotSymbol *LightSymbol = [CPTPlotSymbol ellipsePlotSymbol];
//    LightSymbol.fill = [CPTFill fillWithColor:LightColor];
//    LightSymbol.lineStyle = LightLineStyle;
//    LightSymbol.size = CGSizeMake(6.0f, 6.0f);
//    
//    self.LightSensorPlot.plotSymbol = LightSymbol;
    
}

-(void)configureAxes{
    //Create styles
   self.axisTitleStyle = [CPTMutableTextStyle textStyle];
    self.axisTitleStyle.color = [CPTColor whiteColor];
    self.axisTitleStyle.fontName = @"Helvetica-Bold";
    self.axisTitleStyle.fontSize = 12.0f;
    
    self.axisLineStyle = [CPTMutableLineStyle lineStyle];
    self.axisLineStyle.lineWidth = 2.0f;
    self.axisLineStyle.lineColor = [CPTColor whiteColor];
    
    self.axisTextStyle = [[CPTMutableTextStyle alloc]init];
    self.axisTextStyle.color = [CPTColor whiteColor];
    self.axisTextStyle.fontName = @"Helvetica-Bold";
    self.axisTextStyle.fontSize = 11.0f;
    
    self.tickLineStyle = [CPTMutableLineStyle lineStyle];
    self.tickLineStyle.lineColor = [CPTColor whiteColor];
    self.tickLineStyle.lineWidth = 2.0f;
    
    self.gridLineStyle = [CPTMutableLineStyle lineStyle];
    self.gridLineStyle.lineColor = [CPTColor blackColor];
    self.gridLineStyle.lineWidth = 1.0f;
    
    //Get axis set
 self.axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
    
    //Configure x-axis
    CPTAxis *x = self.axisSet.xAxis;
    x.title =@"Time";
    x.titleTextStyle = self.axisTitleStyle;
    x.titleOffset = 15.0f;
    x.axisLineStyle = self.axisLineStyle;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    x.labelTextStyle = self.axisTextStyle;
    x.majorTickLineStyle = self.axisLineStyle;
    x.majorTickLength = 4.0f;
    x.tickDirection = CPTSignNegative;
    endRangeCount += 50;
    CGFloat dataCount = endRangeCount;
    NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dataCount];
    NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dataCount];
    
    for(uint32_t i = 0; i <= endRangeCount; i++)
    {
        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%u",i] textStyle:x.labelTextStyle];
        CGFloat location = i;
        label.tickLocation = CPTDecimalFromCGFloat(location);
        label.offset = x.majorTickLength;
        
        if(label)
        {
            [xLabels addObject:label];
            [xLocations addObject:[NSNumber numberWithFloat:location]];
        }
    }
    
    x.axisLabels = xLabels;
    x.majorTickLocations = xLocations;
    
    
    //Configure y-axis
    CPTAxis *y = self.axisSet.yAxis;
    y.title = @"Value";
    y.titleTextStyle = self.axisTitleStyle;
    y.titleOffset = -40.0f;
    y.axisLineStyle = self.axisLineStyle;
    y.majorGridLineStyle = self.gridLineStyle;
    y.labelingPolicy = CPTAxisLabelingPolicyNone;
    y.labelTextStyle = self.axisTextStyle;
    y.labelOffset = 16.0f;
    y.majorTickLineStyle = self.axisLineStyle;
    y.majorTickLength = 4.0f;
    y.minorTickLength = 2.0f;
    y.tickDirection = CPTSignPositive;
    
    NSInteger majorIncrement = 10;
    NSInteger minorIncrement = 5;
    
    CGFloat yMax = 100.0f;
    
    NSMutableSet *yLabels = [NSMutableSet set];
    NSMutableSet *yMajorLocations = [NSMutableSet set];
    NSMutableSet *yMinorLocations = [NSMutableSet set];
    
    for(NSInteger j = minorIncrement; j <= yMax; j += minorIncrement)
    {
        NSUInteger mod = j % majorIncrement;
        if(mod == 0)
        {
            CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%i", j] textStyle:y.labelTextStyle];
            NSDecimal location = CPTDecimalFromInteger(j);
            label.tickLocation = location;
            label.offset = -y.majorTickLength - y.labelOffset;
            
            if(label)
            {
                [yLabels addObject:label];
            }
            [yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
            
        }
        else{
            [yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
        }
    }
    
    y.axisLabels = yLabels;
    y.majorTickLocations = yMajorLocations;
    y.minorTickLocations = yMinorLocations;
    
}
-(CPTPlotRange *)plotSpace:(CPTPlotSpace *)space willChangePlotRangeTo:(CPTPlotRange *)newRange forCoordinate:(CPTCoordinate)coordinate{
    
    if(coordinate == CPTCoordinateX)
    {
        CPTPlotRange *maxRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0) length:CPTDecimalFromDouble(50)];
        
        CPTMutablePlotRange *changedRange = [[newRange copy] autorelease];
        [changedRange shiftEndToFitInRange:maxRange];
        [changedRange shiftLocationToFitInRange:maxRange];
        
        newRange = changedRange;
    }
    
    return newRange;
}
-(void)createXAxis
{
    CPTAxis *x = self.axisSet.xAxis;
    x.title =@"Time";
    x.titleTextStyle = self.axisTitleStyle;
    x.titleOffset = 15.0f;
    x.axisLineStyle = self.axisLineStyle;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    x.labelTextStyle = self.axisTextStyle;
    x.majorTickLineStyle = self.axisLineStyle;
    x.majorTickLength = 4.0f;
    x.tickDirection = CPTSignNegative;

    
    CGFloat dataCount = endRangeCount;
    NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dataCount];
    NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dataCount];
    
    for(uint32_t i = startRangeCount; i <= dataCount; i++)
    {
        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%u",i] textStyle:x.labelTextStyle];
        CGFloat location = i;
        label.tickLocation = CPTDecimalFromCGFloat(location);
        label.offset = x.majorTickLength;
        
        if(label)
        {
            [xLabels addObject:label];
            [xLocations addObject:[NSNumber numberWithFloat:location]];
        }
    }
    
    x.axisLabels = xLabels;
    x.majorTickLocations = xLocations;
    
}
-(void)newData:(NSTimer *)theTimer{
    
    CPTGraph *theGraph = self.hostView.hostedGraph;
    
    CPTPlot *thePlot = [theGraph plotWithIdentifier:MyTempSymbol];
    
    if(thePlot)
    {
        NSLog(@"%f\n", self.dataTimer.timeInterval);
        
        if(self.plotData.count >= 50)
        {
            
            [self.plotData removeAllObjects];
            [thePlot deleteDataInIndexRange:NSMakeRange(0, 50)];
           
//            endRangeCount += 50;
//            [self createXAxis];
              CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)theGraph.defaultPlotSpace;
//                plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(startRangeCount)  length:CPTDecimalFromDouble(endRangeCount)];
//            plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(endRangeCount - 50) length:CPTDecimalFromDouble(50)];
#pragma mark - modfied x-axis labels
/*            startRangeCount = (uint32_t) endRangeCount;
            endRangeCount += 50;
            CPTAxis *x = self.axisSet.xAxis;

            
            CGFloat dataCount = 50;
            NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dataCount];
            NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dataCount];
            
            for(uint32_t i = startRangeCount; i <= endRangeCount; i++)
               {
                CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%u",i] textStyle:x.labelTextStyle];
                NSString *location = [NSString stringWithFormat:@"%u",i];
                label.tickLocation = CPTDecimalFromString(location);
                label.offset = x.majorTickLength;
                
                if(label)
                {
                    [xLabels addObject:label];
                    [xLocations addObject:location];
                }
            }
            
            x.axisLabels = xLabels;
            x.majorTickLocations = xLocations;
*/
           
        }
        
//        NSUInteger location = (self.currentIndex >= 50 ? self.currentIndex - 50+2 : 0);
//
//        CPTPlotRange *newRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromUnsignedInteger(location) length:CPTDecimalFromUnsignedInteger(50 - 2)];
        
     //   [CAAnimation animate:plotSpace property:@"xRange" fromplotRange:plotSpace.xRange toPlotRange:newRange duration:1.0f];
        CPTMutableLineStyle *myLineStyle = [self.TempertureSenserPlot.dataLineStyle mutableCopy];
        myLineStyle.lineWidth = 2.5;
        myLineStyle.lineColor = [CPTColor redColor];
        self.TempertureSenserPlot.dataLineStyle = myLineStyle;
        
        self.currentIndex++;

        [self.plotData addObject:[NSNumber numberWithFloat:[[MyConstants sharedInstance] getYData]]];
        [thePlot insertDataAtIndex:self.plotData.count -1 numberOfRecords:1];
        
    }
}

-(void)newDataLightSensor:(NSTimer *)theTimer{
    
    CPTGraph *theGraph = self.hostView.hostedGraph;
    
    CPTPlot *thePlot = [theGraph plotWithIdentifier:MyLightSymbol];
    
    if(thePlot)
    {
        NSLog(@"%f\n", self.dataTimer2.timeInterval);
        if(self.LightPlotData.count >= 50)
        {
            [self.LightPlotData removeAllObjects];
                                                                                              [thePlot deleteDataInIndexRange:NSMakeRange(0, 50)];
        }
        
        CPTMutableLineStyle *LightLineStyle = [self.LightSensorPlot.dataLineStyle mutableCopy];
        LightLineStyle.lineWidth = 2.5;
        LightLineStyle.lineColor = [CPTColor yellowColor];
        self.LightSensorPlot.dataLineStyle = LightLineStyle;
        
        
        [self.LightPlotData addObject:[NSNumber numberWithFloat:[[MyConstants sharedInstance] getLightValueData]]];
        [thePlot insertDataAtIndex:self.LightPlotData.count-1 numberOfRecords:1];
    }
}
#pragma mark - CPTPlotDataSource methods


-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    
    if([plot.identifier isEqual:MyLightSymbol] )
    {
        return [self.LightPlotData count];
    }
    else{
        return [self.plotData count];
    }
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
   
    NSNumber *num = nil;
    
    if(self.isFirst == true)
    {
        self.isFirst = false;
        
        return [NSDecimalNumber zero];
    }
    
    if(self.currentIndex >= 50)
    {
        self.currentIndex  = 0;
    }
//    if(self.xRangeValue >= 10)
//    {
//        self.xRangeValue = 0;
//    }
    
    switch (fieldEnum) {
        case CPTScatterPlotFieldX:
//                self.xRangeValue += 0.1;
            num = [NSNumber numberWithUnsignedInteger:index + self.currentIndex - self.plotData.count];
    
            
            break;
            
        case CPTScatterPlotFieldY:
            if([plot.identifier isEqual:MyTempSymbol] == YES)
            {
                
                num = [self.plotData objectAtIndex:index];
                //return [NSDecimalNumber numberWithFloat:[[MyConstants sharedInstance] getYData]];
            }
            
            if([plot.identifier isEqual:MyLightSymbol] == YES)
            {
                num = [self.LightPlotData objectAtIndex:index];
            }
            
            break;
        default:
            break;
    }
    
    return num;
}



-(void) drawGraph
{
    
//    while(1)
//    {
//        [self numberForPlot:self.TempertureSenserPlot field:0 recordIndex:0];
//        
//        [NSThread sleepForTimeInterval:0.5f];
//        
//        [self numberForPlot:self.TempertureSenserPlot field:1 recordIndex:1];
//        
//        [NSThread sleepForTimeInterval:0.5f];
//    }
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) dealloc{
    
    [super dealloc];
}

@end
