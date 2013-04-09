//
//  SkillEnablesTypeDatasource.h
//  Mac Eve Tools
//
//  Created by Matt Tyson on 4/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class METDependSkill;
@class Character;

@interface SkillEnablesTypeDatasource : NSObject <NSOutlineViewDataSource> {
	NSDictionary *enabledTypes;
	NSInteger skillTypeID; // The skill that we are checking dependicnes for.

	NSInteger categoryCount; //Number of unique Categories.

	id *dependSkillArray;
	id *categoryNameArray;

	Character *character;
}

-(SkillEnablesTypeDatasource*) initWithSkillID:(NSInteger)typeID forCharacter:(Character*)ch;



@end
