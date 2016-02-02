//
//  AppData.h
//  Dopple
//
//  Created by Mitchell Williams on 21/08/2015.
//  Copyright (c) 2015 Mitchell Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppData : NSObject

+ (AppData*) sharedData;


//User Info
@property (nonatomic, retain) NSMutableArray* arrSessionInfo;
@property (nonatomic) BOOL   bSession2;
@property (nonatomic) BOOL   bSession3;
@property (nonatomic) int    nState;

@property (nonatomic) int    nSelectTodoIdx;

@property (nonatomic) BOOL   bSelectMon;
@property (nonatomic) BOOL   bSelectTue;
@property (nonatomic) BOOL   bSelectWen;
@property (nonatomic) BOOL   bSelectThu;
@property (nonatomic) BOOL   bSelectFri;
@property (nonatomic) BOOL   bSelectSat;
@property (nonatomic) BOOL   bSelectSun;

@property (nonatomic, retain) NSString* strAudioName;
@property (nonatomic, retain) NSString* strTitle;

@end
