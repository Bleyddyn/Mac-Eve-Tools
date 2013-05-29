#import <Cocoa/Cocoa.h>

@class CCPDatabase;
@class CCPCategory;

#import "SkillSearchView.h"

@interface SkillSearchModuleDatasource : NSObject<SkillSearchDatasource> {
    CCPDatabase *database;
    CCPCategory *category;

    NSString *searchString;
    NSMutableArray *searchObjects;
}

-(NSString*) skillSearchName;
-(void) skillSearchFilter:(id)sender;

-(id)initWithCategory:(NSInteger)cat;

@end
