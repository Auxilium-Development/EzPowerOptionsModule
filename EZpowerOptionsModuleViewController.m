#import "EZpowerOptionsModuleViewController.h"

#import "UIButton+BackgroundColor.h"
#import "UIColor+ColorExtensions.h"

#import <objc/runtime.h>

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@interface FBSystemService : NSObject
+(id)sharedInstance;
-(void)shutdownAndReboot:(BOOL)arg1;
-(void)exitAndRelaunch:(BOOL)arg1;
-(void)nonExistantMethod;
@end

@implementation EZpowerOptionsModuleViewController

-(EZpowerOptionsModuleViewController *) init {
    self = [super init];
    self.amExpanded = NO;
    self.amTransitioning = NO;
    return self;
}

-(void)loadView {
    [super loadView];

    UIImageView *dot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width / 1.5, self.view.bounds.size.height / 1.5)];
    dot.image = [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
    dot.image = [dot.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [dot setTintColor:[UIColor whiteColor]];
    dot.contentMode = UIViewContentModeScaleAspectFit;
    [dot setCenter:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2 + 1)];

    UIButton *respringButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [respringButton addTarget:self action:@selector(respring) forControlEvents:UIControlEventTouchUpInside];
    [respringButton setTitle:@"Restart SpringBoard" forState:UIControlStateNormal];
    [respringButton setBackgroundColor:[UIColor fadedWhiteColor] forState:UIControlStateNormal];
    [respringButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    respringButton.titleLabel.font = [UIFont fontWithName:@".SFUIText-Medium" size:17];
    respringButton.frame = CGRectMake(0,0, self.view.frame.size.width - 70, 50);
    [respringButton setCenter:CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 4) / 2 + 20)];
    respringButton.layer.cornerRadius = 10;
    respringButton.layer.masksToBounds = YES;

    UIButton *safeModeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [safeModeButton addTarget:self action:@selector(safeMode) forControlEvents:UIControlEventTouchUpInside];
    [safeModeButton setTitle:@"Enter Safe Mode" forState:UIControlStateNormal];
    [safeModeButton setBackgroundColor:[UIColor fadedWhiteColor] forState:UIControlStateNormal];
    [safeModeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    safeModeButton.titleLabel.font = [UIFont fontWithName:@".SFUIText-Medium" size:17];
    safeModeButton.frame = CGRectMake(0,0, self.view.frame.size.width - 70, 50);
    [safeModeButton setCenter:CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 3 + 20))] ;
    safeModeButton.layer.cornerRadius = 10;
    safeModeButton.layer.masksToBounds = YES;

    UIButton *restartButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [restartButton addTarget:self action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
    [restartButton setTitle:@"Restart Device" forState:UIControlStateNormal];
    [restartButton setBackgroundColor:[UIColor fadedWhiteColor] forState:UIControlStateNormal];
    [restartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    restartButton.titleLabel.font = [UIFont fontWithName:@".SFUIText-Medium" size:17];
    restartButton.frame = CGRectMake(0,0, self.view.frame.size.width - 70, 50);
    [restartButton setCenter:CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 3) * 2 - 20)];
    restartButton.layer.cornerRadius = 10;
    restartButton.layer.masksToBounds = YES;

    UIButton *powerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [powerButton addTarget:self action:@selector(powerOff) forControlEvents:UIControlEventTouchUpInside];
    [powerButton setTitle:@"Shutdown Device" forState:UIControlStateNormal];
    [powerButton setBackgroundColor:[UIColor fadedWhiteColor] forState:UIControlStateNormal];
    [powerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    powerButton.titleLabel.font = [UIFont fontWithName:@".SFUIText-Medium" size:17];
    powerButton.frame = CGRectMake(0,0, self.view.frame.size.width - 70, 50);
    [powerButton setCenter:CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 1.15 - 20))];
    powerButton.layer.cornerRadius = 10;
    powerButton.layer.masksToBounds = YES;

    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respring)];

    if ( self.amTransitioning ){
        respringButton.hidden = TRUE;
        safeModeButton.hidden = TRUE;
        restartButton.hidden = TRUE;
        powerButton.hidden = TRUE;
        dot.hidden = TRUE;
    } else if ( self.amExpanded ){
        [self.view removeGestureRecognizer:singleFingerTap];
        dot.hidden = TRUE;
        respringButton.hidden = FALSE;
        safeModeButton.hidden = FALSE;
        restartButton.hidden = FALSE;
        powerButton.hidden = FALSE;
    } else {
        [self.view addGestureRecognizer:singleFingerTap];
        respringButton.hidden = TRUE;
        safeModeButton.hidden = TRUE;
        restartButton.hidden = TRUE;
        powerButton.hidden = TRUE;
        dot.hidden = FALSE;
    }
    [self.view addSubview:respringButton];
    [self.view addSubview:safeModeButton];
    [self.view addSubview:restartButton];
    [self.view addSubview:powerButton];
    [self.view addSubview:dot];
}

- (void)respring{
  [[objc_getClass("FBSystemService") sharedInstance] exitAndRelaunch:YES];
}
- (void)safeMode{
  [[objc_getClass("FBSystemService") sharedInstance] nonExistantMethod];
}
- (void)restart{
  [[objc_getClass("FBSystemService") sharedInstance] shutdownAndReboot:YES];
}
- (void)powerOff{
  [[objc_getClass("FBSystemService") sharedInstance] shutdownAndReboot:FALSE];
}


//Set the default text.
- (void)willBecomeActive {
    [self loadView];
}

//Set the platter size and property.
- (CGFloat)preferredExpandedContentHeight {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    return screenHeight / 1.5;
}
- (CGFloat)preferredExpandedContentWidth {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    if (screenWidth / 1.15 < 320){
        return 320;
    } else {
        return screenWidth / 1.15;
    }
}

- (BOOL)providesOwnPlatter {
    return NO;
}
- (void)didTransitionToExpandedContentMode:(BOOL)didTransition {
    self.amExpanded = didTransition;
    self.amTransitioning = NO;
    [self loadView];
}

- (void)willTransitionToExpandedContentMode:(BOOL)willTransition {
    self.amTransitioning = YES;
    self.amExpanded = willTransition;
    [self loadView];
}

@end
