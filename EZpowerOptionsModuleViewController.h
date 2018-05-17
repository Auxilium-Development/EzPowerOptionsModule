#import <UIKit/UIKit.h>
#import <ControlCenterUIKit/CCUIToggleModule.h>

#import <CoreLocation/CoreLocation.h>

@interface EZpowerOptionsModuleViewController : UIViewController <CCUIContentModuleContentViewController>
@property (nonatomic, assign, readwrite) BOOL amExpanded;
@property (nonatomic, assign, readwrite) BOOL amTransitioning;
@end

@interface UIApplication (EZpowerOptionsModuleViewController)
- (BOOL)launchApplicationWithIdentifier:(NSString *)identifier suspended:(BOOL)suspend;
@end