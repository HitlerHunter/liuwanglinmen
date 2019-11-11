//
//  MKMapView+ZoomLevel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/7.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
