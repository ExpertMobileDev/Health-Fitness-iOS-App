//
//  AppData.m
//  Dopple
//
//  Created by Mitchell Williams on 21/08/2015.
//  Copyright (c) 2015 Mitchell Williams. All rights reserved.
//

#import "AppData.h"

@implementation AppData

#pragma mark - Initialization
+ (AppData*) sharedData
{
    static AppData *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc]init];
    });
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        
    }
    
    return self;
}

#pragma mark - Getter and Setter
- (void) setArrSessionInfo:(NSMutableArray *)arrSessionInfo
{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:arrSessionInfo];
    
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:kArrSession];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableArray*) arrSessionInfo
{
    NSData *encodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:kArrSession];
    
    NSArray* arrTemp = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    NSMutableArray* arrResult = nil;
    if (!arrTemp)
    {
        arrResult = [NSMutableArray new];
    }
    else
    {
        arrResult = [[NSMutableArray alloc] initWithArray:arrTemp];
    }
    
    return arrResult;
}

- (void) setBSession2:(BOOL)bSession2
{
    [[NSUserDefaults standardUserDefaults] setBool:bSession2 forKey:kBSession2];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL) bSession2
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kBSession2];
}

- (void) setBSession3:(BOOL)bSession3
{
    [[NSUserDefaults standardUserDefaults] setBool:bSession3 forKey:kBSession3];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL) bSession3
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kBSession3];
}

- (void) setBSelectMon:(BOOL)bSelectMon
{
    [[NSUserDefaults standardUserDefaults] setBool:bSelectMon forKey:kSelectMon];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL) bSelectMon
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSelectMon];
}

- (void) setBSelectTue:(BOOL)bSelectTue
{
    [[NSUserDefaults standardUserDefaults] setBool:bSelectTue forKey:kSelectTue];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL) bSelectTue
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSelectTue];
}

- (void) setBSelectWen:(BOOL)bSelectWen
{
    [[NSUserDefaults standardUserDefaults] setBool:bSelectWen forKey:kSelectWen];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL) bSelectWen
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSelectWen];
}

- (void) setBSelectThu:(BOOL)bSelectThu
{
    [[NSUserDefaults standardUserDefaults] setBool:bSelectThu forKey:kSelectThu];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL) bSelectThu
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSelectThu];
}

- (void) setBSelectFri:(BOOL)bSelectFri
{
    [[NSUserDefaults standardUserDefaults] setBool:bSelectFri forKey:kSelectFri];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL) bSelectFri
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSelectFri];
}

- (void) setBSelectSat:(BOOL)bSelectSat
{
    [[NSUserDefaults standardUserDefaults] setBool:bSelectSat forKey:kSelectSat];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL) bSelectSat
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSelectSat];
}

- (void) setBSelectSun:(BOOL)bSelectSun
{
    [[NSUserDefaults standardUserDefaults] setBool:bSelectSun forKey:kSelectSun];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL) bSelectSun
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSelectSun];
}

- (void) setNState:(int)nState
{
    [[NSUserDefaults standardUserDefaults] setInteger:nState forKey:kStateNum];
}

- (int) nState
{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:kStateNum];
}

- (void) setNSelectTodoIdx:(int)nSelectTodoIdx
{
    [[NSUserDefaults standardUserDefaults] setInteger:nSelectTodoIdx forKey:kSelectTodoIdx];
}

- (int) nSelectTodoIdx
{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:kSelectTodoIdx];
}

- (NSString*) strAudioName
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kAudioName];
}

- (void) setStrAudioName:(NSString *)strAudioName
{
    [[NSUserDefaults standardUserDefaults] setValue:strAudioName forKey:kAudioName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*) strTitle
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kVideoTitle];
}

- (void) setStrTitle:(NSString *)strTitle
{
    [[NSUserDefaults standardUserDefaults] setValue:strTitle forKey:kVideoTitle];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
