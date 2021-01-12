/**
 * @copyright 2020 https://github.com/reference
 */

#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>

NS_ASSUME_NONNULL_BEGIN

@interface FuckAGSPlatform : NSObject

/// appId
@property (nonatomic, strong, readonly) NSString *appId;

/// init
+ (FuckAGSPlatform *)instance;

/// regist app id
/// @param appId appId
- (BOOL)registAppWithId:(NSString *)appId;

/// add kml to map
/// @param kmlName kml file name
/// @param mapView AGSMapView
- (void)addKMLFileWithName:(NSString *)kmlName inMap:(AGSMapView*)mapView;
- (void)addKMLFileAtPath:(NSURL *)path inMap:(AGSMapView*)mapView;

/// add kmz to map
/// @param kmzName kmz file name
/// @param mapView AGSMapView
- (void)addKMZFileWithName:(NSString *)kmzName inMap:(AGSMapView*)mapView;
- (void)addKMZFileAtPath:(NSURL *)path inMap:(AGSMapView*)mapView;

/// add shp to map
/// @param shpName shp file name
/// @param mapView AGSMapView
- (void)addSHPFileWithName:(NSString *)shpName inMap:(AGSMapView*)mapView;
- (void)addSHPFileAtPath:(NSURL *)path inMap:(AGSMapView*)mapView;

@end

NS_ASSUME_NONNULL_END
