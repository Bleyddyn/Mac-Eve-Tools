//
//  MarketOrder.h
//  Mac Eve Tools
//
//  Created by Andrew Salamon on 5/29/13.
//  Copyright (c) 2013 Sebastian Kruemling. All rights reserved.
//

#import <Foundation/Foundation.h>

//                <row orderID="639587440" charID="118406849" stationID="60003760" volEntered="25" volRemaining="4" minVolume="1" orderState="0" typeID="26082" range="32767" accountKey="1000" duration="1" escrow="0.00" price="3399999.98" bid="0" issued="2008-02-03 22:35:54"/>

typedef enum {
    OrderStateActive = 0, // or open
    OrderStateClosed = 1,
    OrderStateExpired = 2, // (or fulfilled),
    OrderStateCancelled = 3,
    OrderStatePending = 4,
    OrderStateCharacterDeleted = 5,
    OrderStateUnknown = -1
} OrderStateType;

@interface MarketOrder : NSObject

@property (assign) NSUInteger orderID;
@property (assign) NSUInteger charID;
@property (assign) NSUInteger stationID;
@property (assign) NSUInteger volEntered;
@property (assign) NSUInteger volRemaining;
@property (assign) NSUInteger minVolume;
@property (assign) OrderStateType orderState;
@property (assign) NSUInteger typeID;
@property (retain) NSString *range;
@property (assign) NSUInteger accountKey;
@property (assign) double price;
@property (assign) double escrow;
@property (assign) BOOL buy; // if false = sell order
@property (retain) NSDate *issued;

- (NSString *)typeName;
- (NSString *)state;
@end
