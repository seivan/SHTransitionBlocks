
#import "_SHComposerManager.h"
#import <MessageUI/MessageUI.h>

#import "MFMailComposeViewController+SHMessageUIBlocks.h"
#import "MFMessageComposeViewController+SHMessageUIBlocks.h"

@interface _SHComposerBlocksManager ()
<MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property(nonatomic,strong)   NSMapTable   * mapBlocks;

+(instancetype)sharedManager;
-(void)SH_memoryDebugger;

@end

@implementation _SHComposerBlocksManager


#pragma mark - Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapBlocks            = [NSMapTable weakToStrongObjectsMapTable];
//    [self SH_memoryDebugger];
  }
  
  return self;
}

+(instancetype)sharedManager; {
  static _SHComposerBlocksManager * _sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[_SHComposerBlocksManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}



#pragma mark - Debugger
-(void)SH_memoryDebugger; {
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"MAP %@",self.mapBlocks);
    [self SH_memoryDebugger];
  });
}


#pragma mark - Class selectors


#pragma mark - Setter
+(void)setComposerDelegate:(id<SHComposerDelegate>)theComposer;{
  _SHComposerBlocksManager * manager = [_SHComposerBlocksManager sharedManager];
  
  if([theComposer respondsToSelector:@selector(setMessageComposeDelegate:)])
    [theComposer setMessageComposeDelegate:manager];
  else if ([theComposer respondsToSelector:@selector(setMailComposeDelegate:)])
    [theComposer setMailComposeDelegate:manager];
  

}

+(void)setBlock:(id)theBlock forController:(UIViewController *)theController; {
  NSAssert(theController, @"Must pass theController");

  _SHComposerBlocksManager * manager = [_SHComposerBlocksManager sharedManager];
  
  id block = [theBlock copy];
  if(block)
    [manager.mapBlocks setObject:block forKey:theController];
  else
    [manager.mapBlocks removeObjectForKey:theController];
}


#pragma mark - Getter
+(id)blockForController:(UIViewController *)theController; {
  NSAssert(theController, @"Must pass a controller to fetch blocks for");
  return [[_SHComposerBlocksManager sharedManager].mapBlocks objectForKey:theController];
}


#pragma mark - Delegates


#pragma mark - <MFMailComposeViewControllerDelegate>

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error; {
  SHMailComposerBlock  block = [self.mapBlocks objectForKey:controller];
  if(block) block(controller, result, error);
  
}


#pragma mark - <MFMessageComposeViewControllerDelegate>

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller
                didFinishWithResult:(MessageComposeResult)result; {
  SHMessageComposerBlock  block = [self.mapBlocks objectForKey:controller];
  if(block) block(controller, result);

}


@end
