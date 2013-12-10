//
//  Annotations.h
//  Proj.01.Ray.Amour
//
//  Created by Ray Amour on 11/12/13.
//  Copyright (c) 2013 Ray Amour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotations : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@end
