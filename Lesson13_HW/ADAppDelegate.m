//
//  ADAppDelegate.m
//  Lesson13_HW
//
//  Created by A D on 12/20/13.
//  Copyright (c) 2013 AD. All rights reserved.
//

#import "ADAppDelegate.h"
#import "ADStudent.h"

@interface ADAppDelegate()

@property (strong, nonatomic) NSArray *students;

@end

@implementation ADAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ADStudent *student1 = [[ADStudent alloc] init];
    student1.name = @"Student1";
    
    ADStudent *student2 = [[ADStudent alloc] init];
    student2.name = @"Student2";
    
    ADStudent *student3 = [[ADStudent alloc] init];
    student3.name = @"Student3";
    
    ADStudent *student4 = [[ADStudent alloc] init];
    student4.name = @"Student4";
    
    NSInteger fromNum = 50;
    NSInteger toNum = 1000;
    NSInteger numToGuess = arc4random()%(toNum - fromNum) + fromNum;
    
    NSLog(@"Num to guess = %ld, from = %ld, to = %ld", (long)numToGuess, (long)fromNum, (long)toNum);
    
    self.students = [NSArray arrayWithObjects:student1, student2,
                         student3,student4, nil];

    BlockResutl resultBlock = ^(ADStudent *student){
        
        //only check the result when all the students have the result of guess
        if([student.name isEqualToString:[[self.students objectAtIndex:[self.students count]-1] name]]){
            
            NSLog(@"Is the block on main thread? %@", [[NSThread currentThread] isMainThread]? @"Yes" : @"No");
            
            NSArray *sortedStudents = [self.students sortedArrayUsingComparator:^NSComparisonResult(ADStudent *obj1, ADStudent *obj2) {
                
                return[[NSNumber numberWithFloat:obj1.guessTime] compare:[NSNumber numberWithFloat:obj2.guessTime]];
            }];
            NSLog(@"\n\nThe winner is %@ with time %f\n\n", [[sortedStudents objectAtIndex:0] name], [[sortedStudents objectAtIndex:0] guessTime]);
           
            /*
            //find min guessTime and announce the winner
            CGFloat min = [[students objectAtIndex:0] guessTime];
            NSInteger winIndex;
            
            for(int i = 0; i< [students count]; i++) {
                if ([[students objectAtIndex:i] guessTime] < min) {
                    min = [[students objectAtIndex:i] guessTime];
                    winIndex = i;
                }
            }
            NSLog(@"\n\nThe winner is the student %@ with time %f\n\n", [[students objectAtIndex:winIndex] name], [[students objectAtIndex:winIndex] guessTime]);
            */
        }
    };
    
    //dictionary with the params to pass to method
    NSDictionary *paramsDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInteger:numToGuess], @"numToGuess",
                                [NSNumber numberWithInteger:fromNum], @"fromNum",
                                [NSNumber numberWithInteger:toNum], @"toNum",
                                resultBlock,@"resultBlock", nil];
    /*
    for(ADStudent *student in students){
        
        NSThread *thread = [[NSThread alloc] initWithTarget:student
                                                   selector:@selector(guessNumber:)
                                                     object:paramsDict];
        
        thread.name = [NSString stringWithFormat:@"%@_thread", student.name];
        [thread start];
    }
    */
    
    NSOperationQueue *operationQueue = [NSOperationQueue new];
    
    for(ADStudent *student in self.students){
        
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:student selector:@selector(guessNumber:) object:paramsDict];
        
        [operationQueue addOperation:operation];
        //[operation release];
        }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
