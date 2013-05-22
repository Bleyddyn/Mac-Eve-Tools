//
//  MarketOrders.h
//  Mac Eve Tools
//
//  Created by Andrew Salamon on 5/17/13.
//  Copyright (c) 2013 Sebastian Kruemling. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Character;

@interface MarketOrders : NSObject

@property (retain) Character *character;
@property (retain) NSArray *orders;
@property (readonly,retain) NSString *xmlPath;
@property (readonly,retain) NSDate *cachedUntil;

- (IBAction)reload:(id)sender;

@end
