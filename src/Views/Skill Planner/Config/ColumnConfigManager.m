//
//  ColumnConfigManager.m
//  Mac Eve Tools
//
//  Created by Matt Tyson on 26/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ColumnConfigManager.h"

#import "macros.h"

#define SKILL_PLAN_CONFIG @"skill_plan_config"

@implementation ColumnConfigManager

-(id) init
{
	if((self = [super init])){
		[self readConfig];
	}
	return self;
}

-(void)dealloc
{
	[columnList release];
	[super dealloc];
}

-(NSArray*) buildDefaultColumnList
{
	PlannerColumn *col;
	NSMutableArray *array = [[[NSMutableArray alloc]init]autorelease];
	
	col = [[PlannerColumn alloc]initWithName:@"Skill Name" 
								  identifier:COL_PLAN_SKILLNAME 
									  status:YES
									   width:175.0f];
	[array addObject:col];
	[col release];
	
	col = [[PlannerColumn alloc]initWithName:@"Training Time"
								  identifier:COL_PLAN_TRAINING_TIME
									  status:YES
									   width:95.0f];
	[array addObject:col];
	[col release];
	
	col = [[PlannerColumn alloc]initWithName:@"Running Total"
								  identifier:COL_PLAN_TRAINING_TTD
									  status:NO
									   width:90.0f];
	[array addObject:col];
	[col release];
	
	col = [[PlannerColumn alloc]initWithName:@"SP/Hr"
								  identifier:COL_PLAN_SPHR
									  status:NO
									   width:50.0f];
	[array addObject:col];
	[col release];
	
	col = [[PlannerColumn alloc]initWithName:@"Start Date"
								  identifier:COL_PLAN_CALSTART
									  status:YES
									   width:125.0f];
	[array addObject:col];
	[col release];
	
	col = [[PlannerColumn alloc]initWithName:@"Finish Date"
								  identifier:COL_PLAN_CALFINISH
									  status:NO
									   width:125.0f];
	[array addObject:col];
	[col release];
	
	col = [[PlannerColumn alloc]initWithName:@"Progress"
								  identifier:COL_PLAN_PERCENT
									  status:YES
									   width:50.0f];
	[array addObject:col];
	[col release];
	
	return array;
}

-(void) readConfig
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if(columnList != nil){
		[columnList release];
	}
	
	//Create the default list
	
	//load up the saved list and merge the two.
	//Note: if new columns are added then they will never be seen.  fix this.
	
	NSData *data = [defaults objectForKey:SKILL_PLAN_CONFIG];
	if(data != nil){
		NSArray *ary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
		columnList = [ary mutableCopy];
	}else{
		columnList = [[self buildDefaultColumnList]retain];
	}
}

-(void) writeConfig
{
	if(columnList != nil){
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		
		NSData *data = [NSKeyedArchiver archivedDataWithRootObject:columnList];
		
		[defaults setObject:data forKey:SKILL_PLAN_CONFIG];
		
		[defaults synchronize];
	}
}

-(void) eraseConfig
{
	[[NSUserDefaults standardUserDefaults]removeObjectForKey:SKILL_PLAN_CONFIG];
	[[NSUserDefaults standardUserDefaults]synchronize];
}

-(PlannerColumn*) columnForIdentifer:(NSString*)identifier
{
	for(PlannerColumn *pcol in columnList){
		if([[pcol identifier]isEqualToString:identifier]){
			return pcol;
		}
	}
	NSLog(@"%@ not found in columnList",identifier);
	return nil;
}

-(BOOL) setWidth:(CGFloat)width forColumn:(NSString*)columnId
{
	PlannerColumn *pcol = [self columnForIdentifer:columnId];
	if(pcol == nil){
		return NO;
	}
	
	[pcol setColumnWidth:(float)width];
	[self writeConfig];
	return YES;
}

-(BOOL) setOrder:(NSInteger)position forColumn:(NSString*)columnId
{
	return NO;
}

-(NSArray*) columns
{
	return [[columnList copy]autorelease];
}

@end