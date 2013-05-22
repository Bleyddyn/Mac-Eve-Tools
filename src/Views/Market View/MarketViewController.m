//
//  MarketViewController.m
//  Mac Eve Tools
//
//  Created by Andrew Salamon on 5/20/13.
//  Copyright (c) 2013 Sebastian Kruemling. All rights reserved.
//

#import "MarketViewController.h"
#import "MarketOrders.h"

@implementation MarketViewController

@synthesize character;

-(id) init
{
	if( (self = [super initWithNibName:@"MarketView" bundle:nil]) )
    {
        orders = [[MarketOrders alloc] init];
	}
    
	return self;
}

- (void)dealloc
{
    [orders release];
    [character release];
    [app release];
    [super dealloc];
}

- (void)setCharacter:(Character *)_character
{
    if( _character != character )
    {
        [character release];
        character = [_character retain];
        // if view is active we need to reload market orders
        [orders setCharacter:character];
        [orders reload:self];
    }
}

//called after the window has become active
-(void) viewIsActive
{
    
}

-(void) viewIsInactive
{
    
}

-(void) viewWillBeDeactivated
{
    
}

-(void) viewWillBeActivated
{
}

-(void) setInstance:(id<METInstance>)instance
{
    if( instance != app )
    {
        [app release];
        app = [instance retain];
    }
}

-(NSMenuItem*) menuItems
{
    return nil;
}

@end
