//
//  DatabaseManager.h
//  AppForSaints
//
//  Created by Kashif Tasneem on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface DatabaseManager : NSObject
{
    sqlite3 *db;
    NSString *appStateDBPath;
}

+(DatabaseManager*) sharedManager;

-(void) initlializeDatabaseManager;

-(BOOL) executeQuery:(NSString*) query;

-(void) addTodoItemWithName:(NSString*) name RepeatInterval:(NSString*) repeatInterval Zone:(NSString*) zone Hour:(int) hour Minutes:(int) minutes Day:(int) day Month:(int) month Year:(int) year isActive:(int) isactive andIsCompleted:(int) isCompleted;

-(void) updateTodoItemWithName:(NSString*) name RepeatInterval:(NSString*) repeatInterval Zone:(NSString*) zone Hour:(int) hour Minutes:(int) minutes Day:(int) day Month:(int) month Year:(int) year isActive:(int) isactive isCompleted:(int) isCompleted andId:(int) idVal;

-(void) deleteTodoHavingId:(int) idValue;
-(void) deleteTodoHavingName:(NSString*) name;

-(BOOL) checkIfTodosExist;

-(int) getTotalNumberOfRecords;

-(int) getHourForId:(int) value;
-(int) getMinutesForId:(int) value;
-(int) getDayForId:(int) value;
-(int) getMonthForId:(int) value;
-(int) getYearForId:(int) value;
-(NSString*) getNameForId:(int) value;
-(NSString*) getZoneForId:(int) value;
-(NSString*) getIntervalForId:(int) value;
-(BOOL) getIsActiveForId:(int) value;
-(BOOL) getIsCompletedForId:(int) value;
-(BOOL) getIsCompletedForName:(NSString*) name;

-(void) setIsCompletedForName:(NSString*) name;
-(void) setNotIsCompletedForName:(NSString*) name;

-(void) setIsActiveForId:(int) idValue;
-(void) setNotIsActiveForId:(int) idValue;

-(void) reorderIds;
@end
