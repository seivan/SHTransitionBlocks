
#import "_SHComposerManager.h"
#import <MessageUI/MessageUI.h>

#import "MFMailComposeViewController+SHMessageUIBlocks.h"
#import "MFMessageComposeViewController+SHMessageUIBlocks.h"

@interface _SHComposerManager ()
<UINavigationControllerDelegate,
MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property(nonatomic,strong)   NSMapTable   * mapBlocks;
-(void)SH_memoryDebugger;

@end

@implementation _SHComposerManager

#pragma mark -
#pragma mark Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapBlocks            = [NSMapTable weakToStrongObjectsMapTable];
    [self SH_memoryDebugger];
  }
  
  return self;
}

+(instancetype)sharedManager; {
  static _SHComposerManager * _sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[_SHComposerManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}


#pragma mark -
#pragma mark Debugger
-(void)SH_memoryDebugger; {
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"MAP %@",self.mapBlocks);
    [self SH_memoryDebugger];
  });
}

#pragma mark -
#pragma mark Class selectors

#pragma mark -
#pragma mark Setter
+(void)setComposerDelegate:(id<SHComposerDelegate>)theComposer;{
  [theComposer setDelegate:[self sharedManager]];
}
+(void)setBlock:(id)theBlock forController:(UIViewController *)theController; {
  id block = [theBlock copy];
  NSAssert(block, @"Must pass theBlock");
  NSAssert(theController, @"Must pass theController");
  [[_SHComposerManager sharedManager].mapBlocks setObject:block forKey:theController];
}

#pragma mark - 
#pragma mark Getter
+(id)blockForController:(UIViewController *)theController; {
  NSAssert(theController, @"Must pass a controller to fetch blocks for");
  return [[_SHComposerManager sharedManager].mapBlocks objectForKey:theController];
}

#pragma mark -
#pragma mark Delegates

#pragma mark -
#pragma mark <MFMailComposeViewControllerDelegate>

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error; {
  SHMailComposerBlock  block = [self.mapBlocks objectForKey:controller];
  if(block) block(controller, result, error);
  
}

#pragma mark -
#pragma mark <MFMessageComposeViewControllerDelegate>

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller
                didFinishWithResult:(MessageComposeResult)result; {
  SHMessageComposerBlock  block = [self.mapBlocks objectForKey:controller];
  if(block) block(controller, result);

}

#pragma mark -
#pragma mark <UINavigationControllerDelegate>
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated; {
  
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated; {
  
}



@end
