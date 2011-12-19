//
//  SkillSearchCertDatasource.m
//  Mac Eve Tools
//
//  Created by Matt Tyson on 25/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SkillSearchCertDatasource.h"

#import "Character.h"
#import "CertTree.h"
#import "Cert.h"
#import "CertCategory.h"
#import "CertClass.h"
#import "CertPair.h"

#import "GlobalData.h"

#import "SkillPlan.h"
#import "Helpers.h"

#import <assert.h>

@implementation SkillSearchCertDatasource

-(void)dealloc
{
	[foundSearchObjects release];
	[certClasses release];
	[searchString release];
	[super dealloc];
}

-(void) buildCertClassArray
{
	NSInteger catCount = [certs catCount];

	for(NSInteger i = 0; i < catCount; i++){
		[certClasses addObjectsFromArray:[[certs catAtIndex:i]classArray]];
	}
}

-(SkillSearchCertDatasource*) init
{
	if((self = [super init])){
		certs = [[GlobalData sharedInstance]certTree];
		foundSearchObjects = [[NSMutableArray alloc]init];
		certClasses = [[NSMutableArray alloc]init];
		[self buildCertClassArray];
	}
	return self;
}

-(NSString*) skillSearchName
{
	return NSLocalizedString(@"Certs",@"Certifacte picker for skill planner.  Keep the translation short.");
}

-(void) setCharacter:(Character*)skills
{
	if(character != nil){
		[character release];
	}

	character = [skills retain];
	if(characterSkills != nil){
		[characterSkills release];
	}

	characterSkills = [[skills skillSet]retain];
}

-(void) skillSearchFilter:(id)sender
{

	NSString *searchValue = [[sender cell]stringValue];

	if([searchValue length] == 0){
		[searchString release];
		searchString = nil;
		[foundSearchObjects removeAllObjects];
		return;
	}

	[foundSearchObjects removeAllObjects];
	[searchString release];
	searchString = [searchValue retain];

	for(CertClass *c in certClasses){
		NSRange r = [[c certClassName]rangeOfString:searchValue options:NSCaseInsensitiveSearch];
		if(r.location != NSNotFound){
			[foundSearchObjects addObject:c];
		}
	}
}


#pragma mark Datasource Methods

-(NSInteger) outlineView:(NSOutlineView*)outlineView
  numberOfChildrenOfItem:(id)item
{
	if(item == nil){
		if(searchString != NULL){
			return [foundSearchObjects count];
		}
		return [certs catCount];
	}

	if([item isKindOfClass:[CertCategory class]]){
		return [item classCount];
	}

	if([item isKindOfClass:[CertClass class]]){
		return [item certCount];
	}

	assert(0);
	return 0;
}


-(id) outlineView:(NSOutlineView*)outlineView
			child:(NSInteger)index
		   ofItem:(id)item
{
	if(item == nil){
		if([foundSearchObjects count] > 0){
			return [foundSearchObjects objectAtIndex:index];
		}
		return [certs catAtIndex:index];
	}

	if([item isKindOfClass:[CertCategory class]]){
		return [item classAtIndex:index];
	}

	if([item isKindOfClass:[CertClass class]]){
		return [item certAtIndex:index];
	}

	assert(0);
	return nil;
}

-(BOOL) outlineView:(NSOutlineView*)outlineView
   isItemExpandable:(id)item
{
	if([item isKindOfClass:[Cert class]]){
		return NO;
	}

	return YES;
}

-(id) outlineView:(NSOutlineView *)outlineView
objectValueForTableColumn:(NSTableColumn *)tableColumn
		   byItem:(id)item
{
	if([item isKindOfClass:[CertCategory class]]){
		return [item catName];
	}

	if([item isKindOfClass:[CertClass class]]){
		return [item certClassName];
	}

	if([item isKindOfClass:[Cert class]]){
		return [item certGradeText];
	}

	assert(0);

	return nil;
}

- (NSString *)outlineView:(NSOutlineView *)ov
		   toolTipForCell:(NSCell *)cell
					 rect:(NSRectPointer)rect
			  tableColumn:(NSTableColumn *)tc
					 item:(id)item
			mouseLocation:(NSPoint)mouseLocation
{
	return nil;
}

-(NSMenu*) outlineView:(NSOutlineView*)outlineView
menuForTableColumnItem:(NSTableColumn*)column
				byItem:(id)item
{
	if(![item isKindOfClass:[Cert class]]){
		return nil;
	}

	NSMenu *menu = [[[NSMenu alloc]initWithTitle:@"Menu"]autorelease];

	NSString *certTitle = [NSString stringWithFormat:@"%@ - %@",
						   [[(Cert*)item parent]certClassName],
						   [item certGradeText]];

	NSMenuItem *menuItem = [[NSMenuItem alloc]initWithTitle:certTitle
													 action:@selector(displayCertWindow:)
											  keyEquivalent:@""];
	[menuItem setRepresentedObject:item];

	[menu addItem:menuItem];
	[menuItem release];

	[menu addItem:[NSMenuItem separatorItem]];


	NSArray *pre = [item certChainPrereqs];

	menuItem = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"Add to plan",@"add a certificate to the skill plan")
										 action:@selector(menuAddSkillClick:)
								  keyEquivalent:@""];
	[menuItem setRepresentedObject:pre];
	[menu addItem:menuItem];
	[menuItem release];

	return menu;
}



#pragma mark drag and drop support
- (BOOL)outlineView:(NSOutlineView *)outlineView
		 writeItems:(NSArray *)items
	   toPasteboard:(NSPasteboard *)pboard
{
	Cert *c = [items objectAtIndex:0];

	if(![c isKindOfClass:[Cert class]]){
		return NO;
	}

	NSArray *prereqs = [c certChainPrereqs];

	[pboard declareTypes:[NSArray arrayWithObject:MTSkillArrayPBoardType] owner:self];

	NSMutableData *data = [[NSMutableData alloc]init];

	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
	[archiver setOutputFormat:NSPropertyListBinaryFormat_v1_0];
	[archiver encodeObject:prereqs];
	[archiver finishEncoding];

	[pboard setData:data forType:MTSkillArrayPBoardType];

	[archiver release];
	[data release];

	return YES;
}

@end
