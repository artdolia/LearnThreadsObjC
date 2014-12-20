//
//  ADStudent.m
//  Lesson13_HW
//
//  Created by A D on 12/20/13.
//  Copyright (c) 2013 AD. All rights reserved.
//

#import "ADStudent.h"

@implementation ADStudent

@synthesize name = _name;
@synthesize guessTime = _guessTime;

/*
+(dispatch_queue_t)studentsQueue{
    
    static dispatch_queue_t studentsQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        studentsQueue = dispatch_queue_create("art.dolia.13.master", DISPATCH_QUEUE_CONCURRENT);
    });
    return studentsQueue;
}
 */

-(void) guessNumber:(NSDictionary *)paramsDict{
    
    //dispatch_sync([ADStudent studentsQueue], ^{

        double startTime = CACurrentMediaTime();
        NSLog(@"%@ started to guess", self.name); //[[NSThread currentThread] name]);

        NSInteger numToGuess = [[paramsDict objectForKey:@"numToGuess"] integerValue];
        NSInteger fromNum = [[paramsDict objectForKey:@"fromNum"] integerValue];
        NSInteger toNum = [[paramsDict objectForKey:@"toNum"] integerValue];
        BlockResutl blockResult = [paramsDict objectForKey:@"resultBlock"];

        while(YES){
            
            NSInteger studNumber = arc4random()%(toNum - fromNum) + fromNum;
            if(studNumber == numToGuess){
                
                self.guessTime = (CGFloat)CACurrentMediaTime() - startTime;
                    
                NSLog(@"Student %@ got the number %ld in %f time",
                          self.name, (long)studNumber, self.guessTime);
                break;
            }
        }
        
        //initiate the block on main thread
    
        __weak ADStudent *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            blockResult(weakSelf);
        });
    //});
}

-(NSString*) description{
    return self.name;
}

/*
-(void) guessNumber:(NSInteger)number from:(NSInteger)fromNum to:(NSInteger)toNum withBlock:(BlockResutl)resultBlock{
    
    NSLog(@"Student %@ started the guess", self.name);
    
    double startTime = CACurrentMediaTime();
    
    while(YES){
    
        NSInteger studNumber = arc4random()%(++toNum - fromNum) + fromNum;
        if(studNumber == number){
            
            self.guessTime = (CGFloat)CACurrentMediaTime() - startTime;
            
            NSLog(@"Student %@ got the number %d in %f time",
                  self.name, number, self.guessTime);
            
            break;
        }
    }
    
    resultBlock(self);
}

*/

- (void)dealloc
{
    NSLog(@"%@ is no longer a student", self.name);
}


@end
