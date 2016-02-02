//
//  DatabaseManager.m
//  AppForSaints
//
//  Created by Kashif Tasneem on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DatabaseManager.h"
#import "Constants.h"

static DatabaseManager *_sharedInstance = nil;
@implementation DatabaseManager

+(DatabaseManager*) sharedManager
{
    @synchronized(self)
    {
        if (_sharedInstance == nil) {
            _sharedInstance = [[self alloc] init];
        }
    }
    return _sharedInstance;
}


+(id)alloc
{
    @synchronized(self) 
    {
		NSAssert(_sharedInstance == nil, @"Attempted to allocate a second instance of DatabaseManager.");
		_sharedInstance = [super alloc];
		return _sharedInstance;
	}
	return nil;
}

-(id) init
{
	if( (self=[super init])) {
    }
	return self;
}

-(void) initlializeDatabaseManager
{
    // Create a string containing the full path to the sqlite.db inside the documents folder
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    appStateDBPath = [cachesDirectory stringByAppendingPathComponent:APP_STATE_DB];
    
    // Check to see if the database file already exists
    bool databaseAlreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:appStateDBPath];
    
    // Open the database and store the handle as a data member
    if (sqlite3_open([appStateDBPath UTF8String], &db) == SQLITE_OK)
    {
        // Create the database if it doesn't yet exists in the file system
        if (!databaseAlreadyExists)
        {
            const char *sqlStatement = "CREATE TABLE IF NOT EXISTS Todos (id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT,RepeatInterval TEXT,Zone TEXT, Hour INTEGER, Minutes INTEGER, Day INTEGER, Month INTEGER, Year INTEGER, IsActive INTEGER, IsCompleted INTEGER )";
            char *error;
            if (sqlite3_exec(db, sqlStatement, NULL, NULL, &error) == SQLITE_OK)
            {
                NSLog(@"Database and Todos table created.");
            }
            else
            {
                NSLog(@"Error: %s", error);
            }
            
        }
    }
//    [self reorderIds];
}

-(BOOL) executeQuery:(NSString *)query
{
    char *error;
    if (sqlite3_exec(db, [query UTF8String], NULL, NULL, &error) == SQLITE_OK)
    {
        return YES;
    }
    else 
    {
        NSLog(@"Error: %s",error);
        return NO;
    }
}

-(void) addTodoItemWithName:(NSString*) name RepeatInterval:(NSString*) repeatInterval Zone:(NSString*) zone Hour:(int) hour Minutes:(int) minutes Day:(int) day Month:(int) month Year:(int) year isActive:(int) isactive andIsCompleted:(int) isCompleted
{
    NSString *query = [NSString stringWithFormat:@"INSERT INTO Todos (Name,RepeatInterval,Zone,Hour,Minutes,Day,Month,Year,IsActive,IsCompleted) VALUES('%@','%@','%@',%d,%d,%d,%d,%d,%d,%d)",name,repeatInterval,zone,hour,minutes,day,month,year,isactive,isCompleted];
    [self executeQuery:query];
}

-(void) updateTodoItemWithName:(NSString*) name RepeatInterval:(NSString*) repeatInterval Zone:(NSString*) zone Hour:(int) hour Minutes:(int) minutes Day:(int) day Month:(int) month Year:(int) year isActive:(int) isactive isCompleted:(int) isCompleted andId:(int) idVal
{
    NSString *query = [NSString stringWithFormat:@"UPDATE Todos SET Name = '%@', RepeatInterval = '%@', Zone = '%@', Hour = %d, Minutes = %d, Day = %d, Month = %d, Year = %d, IsActive = %d, IsCompleted = %d WHERE id = %d",name,repeatInterval,zone,hour,minutes,day,month,year,isactive,isCompleted,idVal];
    [self executeQuery:query];
}

-(void) reorderIds
{
    char **result;
	int r;
	int c;
	char *err;
	sqlite3 *database = NULL;
    
    if ( sqlite3_open([appStateDBPath UTF8String], &database) == SQLITE_OK )
    {
		NSString *query = [NSString stringWithFormat:@"SELECT * FROM Todos ORDER BY id"];
        
		sqlite3_get_table(database,[query UTF8String], &result, &r, &c, &err);
        
        if (r <= 0) {
            NSLog(@"no rows");
        }
        else {
            for (int i = 0; i < r; i++) {
                NSString *stringVal = [NSString stringWithCString:result[((i+1)*c)]encoding:NSUTF8StringEncoding];
                int intVal = [stringVal intValue];
                
                NSString *query = [NSString stringWithFormat:@"UPDATE Todos SET id = %d",intVal];
                [self executeQuery:query];
            }
        }
        sqlite3_free_table(result);
	}else {
        sqlite3_close(database);
	}
	sqlite3_close(database);
}

-(void) deleteTodoHavingId:(int) idValue
{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM Todos WHERE id = %d",idValue];
    [self executeQuery:query];
}

-(void) deleteTodoHavingName:(NSString*) name
{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM Todos WHERE Name = '%@'",name];
    [self executeQuery:query];
}

-(BOOL) checkIfTodosExist
{
    char **result;
	int r;
	int c;
	char *err;
	sqlite3 *database = NULL;
    BOOL retVal;
    
	if ( sqlite3_open([appStateDBPath UTF8String], &database) == SQLITE_OK )
    {
		NSString *query = [NSString stringWithFormat:@"SELECT * FROM Todos"];
        
		sqlite3_get_table(database,[query UTF8String], &result, &r, &c, &err);
        
        if (r == 0) {
            retVal = NO;
        }
        else {
            retVal = YES;
        }
        sqlite3_free_table(result);
	}else {
        sqlite3_close(database);
		return NO;
	}
	sqlite3_close(database);
	return retVal;
}

-(int) getTotalNumberOfRecords
{
    char **result;
	int r;
	int c;
	char *err;
	sqlite3 *database = NULL;
    int retVal;
    
	if ( sqlite3_open([appStateDBPath UTF8String], &database) == SQLITE_OK )
    {
		NSString *query = [NSString stringWithFormat:@"SELECT MAX(id) FROM Todos"];
        
		sqlite3_get_table(database,[query UTF8String], &result, &r, &c, &err);
        
        if (r == 0) {
            retVal = -1;
        }
        else {
            if (result[1] != nil) {
                NSString *retString = [NSString stringWithCString:result[1]
                                                         encoding:NSUTF8StringEncoding];
                retVal = [retString intValue];
            }
            else {
                retVal = -1;
            }
            
        }
        sqlite3_free_table(result);
	}else {
        sqlite3_close(database);
		return -1;
	}
	sqlite3_close(database);
	return retVal;
}

-(int) getHourForId:(int) value
{
    char **result;
	int r;
	int c;
	char *err;
	sqlite3 *database = NULL;
    int retVal;
    
	if ( sqlite3_open([appStateDBPath UTF8String], &database) == SQLITE_OK )
    {
		NSString *query = [NSString stringWithFormat:@"SELECT Hour FROM Todos WHERE id = %d",value];
        
		sqlite3_get_table(database,[query UTF8String], &result, &r, &c, &err);
        
        if (r == 0) {
            retVal = -1;
        }
        else {
            retVal = [[NSString stringWithCString:result[1]
                                         encoding:NSUTF8StringEncoding] intValue];
        }
        sqlite3_free_table(result);
	}else {
        sqlite3_close(database);
		return -1;
	}
	sqlite3_close(database);
	return retVal;
}

-(int) getMinutesForId:(int) value
{
    char **result;
	int r;
	int c;
	char *err;
	sqlite3 *database = NULL;
    int retVal;
    
	if ( sqlite3_open([appStateDBPath UTF8String], &database) == SQLITE_OK )
    {
		NSString *query = [NSString stringWithFormat:@"SELECT Minutes FROM Todos WHERE id = %d",value];
        
		sqlite3_get_table(database,[query UTF8String], &result, &r, &c, &err);
        
        if (r == 0) {
            retVal = -1;
        }
        else {
            retVal = [[NSString stringWithCString:result[1]
                                         encoding:NSUTF8StringEncoding] intValue];
        }
        sqlite3_free_table(result);
	}else {
        sqlite3_close(database);
		return -1;
	}
	sqlite3_close(database);
	return retVal;
}

-(int) getDayForId:(int) value
{
    char **result;
	int r;
	int c;
	char *err;
	sqlite3 *database = NULL;
    int retVal;
    
	if ( sqlite3_open([appStateDBPath UTF8String], &database) == SQLITE_OK )
    {
		NSString *query = [NSString stringWithFormat:@"SELECT Day FROM Todos WHERE id = %d",value];
        
		sqlite3_get_table(database,[query UTF8String], &result, &r, &c, &err);
        
        if (r == 0) {
            retVal = -1;
        }
        else {
            retVal = [[NSString stringWithCString:result[1]
                                         encoding:NSUTF8StringEncoding] intValue];
        }
        sqlite3_free_table(result);
	}else {
        sqlite3_close(database);
		return -1;
	}
	sqlite3_close(database);
	return retVal;
}

-(int) getMonthForId:(int) value
{
    char **result;
	int r;
	int c;
	char *err;
	sqlite3 *database = NULL;
    int retVal;
    
	if ( sqlite3_open([appStateDBPath UTF8String], &database) == SQLITE_OK )
    {
		NSString *query = [NSString stringWithFormat:@"SELECT Month FROM Todos WHERE id = %d",value];
        
		sqlite3_get_table(database,[query UTF8String], &result, &r, &c, &err);
        
        if (r == 0) {
            retVal = -1;
        }
        else {
            retVal = [[NSString stringWithCString:result[1]
                                         encoding:NSUTF8StringEncoding] intValue];
        }
        sqlite3_free_table(result);
	}else {
        sqlite3_close(database);
		return -1;
	}
	sqlite3_close(database);
	return retVal;
}

-(int) getYearForId:(int) value
{
    char **result;
	int r;
	int c;
	char *err;
	sqlite3 *database = NULL;
    int retVal;
    
	if ( sqlite3_open([appStateDBPath UTF8String], &database) == SQLITE_OK )
    {
		NSString *query = [NSString stringWithFormat:@"SELECT Year FROM Todos WHERE id = %d",value];
        
		sqlite3_get_table(database,[query UTF8String], &result, &r, &c, &err);
        
        if (r == 0) {
            retVal = -1;
        }
        else {
            retVal = [[NSString stringWithCString:result[1]
                                         encoding:NSUTF8StringEncoding] intValue];
        }
        sqlite3_free_table(result);
	}else {
        sqlite3_close(database);
		return -1;
	}
	sqlite3_close(database);
	return retVal;
}

-(NSString*) getNameForId:(int) value
{
    char **result;
	int r;
	int c;
	char *err;
	sqlite3 *database = NULL;
    NSString *retVal;
    
	if ( sqlite3_open([appStateDBPath UTF8String], &database) == SQLITE_OK )
    {
		NSString *query = [NSString stringWithFormat:@"SELECT Name FROM Todos WHERE id = %d",value];
        
		sqlite3_get_table(database,[query UTF8String], &result, &r, &c, &err);
        
        if (r == 0) {
            retVal = nil;
        }
        else {
            retVal = [NSString stringWithCString:result[1]
                                         encoding:NSUTF8StringEncoding];
        }
        sqlite3_free_table(result);
	}else {
        sqlite3_close(database);
		return nil;
	}
	sqlite3_close(database);
	return retVal;
}

-(NSString*) getZoneForId:(int) value;
{
    char **result;
	int r;
	int c;
	char *err;
	sqlite3 *database = NULL;
    NSString *retVal;
    
	if ( sqlite3_open([appStateDBPath UTF8String], &database) == SQLITE_OK )
    {
		NSString *query = [NSString stringWithFormat:@"SELECT Zone FROM Todos WHERE id = %d",value];
        
		sqlite3_get_table(database,[query UTF8String], &result, &r, &c, &err);
        
        if (r == 0) {
            retVal = nil;
        }
        else {
            retVal = [NSString stringWithCString:result[1]
                                        encoding:NSUTF8StringEncoding];
        }
        sqlite3_free_table(result);
	}else {
        sqlite3_close(database);
		return nil;
	}
	sqlite3_close(database);
	return retVal;
}

-(NSString*) getIntervalForId:(int) value
{
    char **result;
	int r;
	int c;
	char *err;
	sqlite3 *database = NULL;
    NSString *retVal;
    
	if ( sqlite3_open([appStateDBPath UTF8String], &database) == SQLITE_OK )
    {
		NSString *query = [NSString stringWithFormat:@"SELECT RepeatInterval FROM Todos WHERE id = %d",value];
        
		sqlite3_get_table(database,[query UTF8String], &result, &r, &c, &err);
        
        if (r == 0) {
            retVal = nil;
        }
        else {
            retVal = [NSString stringWithCString:result[1]
                                        encoding:NSUTF8StringEncoding];
        }
        sqlite3_free_table(result);
	}else {
        sqlite3_close(database);
		return nil;
	}
	sqlite3_close(database);
	return retVal;
}

-(BOOL) getIsActiveForId:(int) value
{
    char **result;
	int r;
	int c;
	char *err;
	sqlite3 *database = NULL;
    BOOL retVal;
    
	if ( sqlite3_open([appStateDBPath UTF8String], &database) == SQLITE_OK )
    {
		NSString *query = [NSString stringWithFormat:@"SELECT IsActive FROM Todos WHERE id = %d",value];
        
		sqlite3_get_table(database,[query UTF8String], &result, &r, &c, &err);
        
        if (r == 0) {
            retVal = NO;
        }
        else {
            retVal = [[NSString stringWithCString:result[1]
                                         encoding:NSUTF8StringEncoding] boolValue];
        }
        sqlite3_free_table(result);
	}else {
        sqlite3_close(database);
		return NO;
	}
	sqlite3_close(database);
	return retVal;
}

-(BOOL) getIsCompletedForId:(int)value
{
    char **result;
	int r;
	int c;
	char *err;
	sqlite3 *database = NULL;
    BOOL retVal;
    
	if ( sqlite3_open([appStateDBPath UTF8String], &database) == SQLITE_OK )
    {
		NSString *query = [NSString stringWithFormat:@"SELECT IsCompleted FROM Todos WHERE id = %d",value];
        
		sqlite3_get_table(database,[query UTF8String], &result, &r, &c, &err);
        
        if (r == 0) {
            retVal = NO;
        }
        else {
            retVal = [[NSString stringWithCString:result[1]
                                         encoding:NSUTF8StringEncoding] boolValue];
        }
        sqlite3_free_table(result);
	}else {
        sqlite3_close(database);
		return NO;
	}
	sqlite3_close(database);
	return retVal;
}

-(BOOL) getIsCompletedForName:(NSString*) name;
{
    char **result;
	int r;
	int c;
	char *err;
	sqlite3 *database = NULL;
    BOOL retVal;
    
	if ( sqlite3_open([appStateDBPath UTF8String], &database) == SQLITE_OK )
    {
		NSString *query = [NSString stringWithFormat:@"SELECT IsCompleted FROM Todos WHERE Name = '%@'",name];
        
		sqlite3_get_table(database,[query UTF8String], &result, &r, &c, &err);
        
        if (r == 0) {
            retVal = NO;
        }
        else {
            retVal = [[NSString stringWithCString:result[1]
                                        encoding:NSUTF8StringEncoding] boolValue];
        }
        sqlite3_free_table(result);
	}else {
        sqlite3_close(database);
		return NO;
	}
	sqlite3_close(database);
	return retVal;
}

-(void) setIsCompletedForName:(NSString*) name
{
    NSString *query = [NSString stringWithFormat:@"UPDATE Todos SET IsCompleted = 1 WHERE Name = '%@'",name];
    [self executeQuery:query];
}

-(void) setNotIsCompletedForName:(NSString*) name
{
    NSString *query = [NSString stringWithFormat:@"UPDATE Todos SET IsCompleted = 0 WHERE Name = '%@'",name];
    [self executeQuery:query];
}

-(void) setIsActiveForId:(int) idValue
{
    NSString *query = [NSString stringWithFormat:@"UPDATE Todos SET IsActive = 1 WHERE id = %d",idValue];
    [self executeQuery:query];
}

-(void) setNotIsActiveForId:(int) idValue
{
    NSString *query = [NSString stringWithFormat:@"UPDATE Todos SET IsActive = 0 WHERE id = %d",idValue];
    [self executeQuery:query];
}

@end
