//
//  AppDelegate.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/8.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    int startIndex;
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;
// dw add
@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D loc;
@property (nonatomic, copy) NSString * locState;        // 省
@property (nonatomic, copy) NSString * locCity;         // 市
@property (nonatomic, copy) NSString * locSubLocality;  // 区
// dw end
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (AppDelegate *) appDelegete; // dw add
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (void)cleanCache; // WangZhipeng Add

@end

