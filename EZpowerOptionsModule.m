#import "EZpowerOptionsModule.h"
#import "EZpowerOptionsModuleViewController.h"

@implementation EZpowerOptionsModule
- (UIViewController<CCUIContentModuleContentViewController> *)contentViewController {
    return [[EZpowerOptionsModuleViewController alloc] init];
}

-(void)setApplicationIdentifier:(NSString *)appID{
	self.appID = @"com.apple.Preferences";
}
-(NSString *)applicationIdentifier{
	return self.appID;
}

@end
