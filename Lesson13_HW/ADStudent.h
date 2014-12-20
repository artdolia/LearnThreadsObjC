//
//  ADStudent.h
//  Lesson13_HW
//
//  Created by A D on 12/20/13.
//  Copyright (c) 2013 AD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADStudent;

typedef void(^BlockResutl)(ADStudent *);

@interface ADStudent : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) CGFloat guessTime;

//-(void) guessNumber:(NSInteger) number from:(NSInteger) fromNum to:(NSInteger) toNum withBlock:(BlockResutl) resultBlock;

-(void) guessNumber:(NSDictionary *) paramsDict;

@end
