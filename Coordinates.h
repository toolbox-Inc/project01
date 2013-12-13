//
//  Coordinates.h
//  Proj.01.Ray.Amour
//
//  Created by Ray Amour on 12/12/13.
//  Copyright (c) 2013 Ray Amour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Coordinates : NSManagedObject

@property (nonatomic, retain) NSNumber * delta;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSString * voiceMemo;

@end
