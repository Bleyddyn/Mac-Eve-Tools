//
//  MarketViewController.h
//  Mac Eve Tools
//
//  Created by Andrew Salamon on 5/20/13.
//  Copyright (c) 2013 Sebastian Kruemling. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "METPluggableView.h"

@class MarketOrders;

@interface MarketViewController : NSViewController <METPluggableView>
{
    Character *character;
    id<METInstance> app;
    MarketOrders *orders;
}
@property (readwrite,retain,nonatomic) Character *character;
@end
