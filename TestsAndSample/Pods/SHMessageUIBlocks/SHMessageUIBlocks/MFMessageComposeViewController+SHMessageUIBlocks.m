
#import "MFMessageComposeViewController+SHMessageUIBlocks.h"

#import "_SHComposerManager.h"

@implementation MFMessageComposeViewController (SHMessageUIBlocks)


#pragma mark - Init
+(instancetype)SH_messageComposeViewController; {
  MFMessageComposeViewController * vc = [[MFMessageComposeViewController alloc] init];
  [_SHComposerBlocksManager setComposerDelegate:(id<SHComposerDelegate>)vc];
  return vc;
}

+(instancetype)SH_messageComposeViewControllerWithBlock:(SHMessageComposerBlock)theBlock; {
  MFMessageComposeViewController * vc = [self SH_messageComposeViewController];
  [vc SH_setComposerCompletionBlock:theBlock];
  return vc;
}



#pragma mark - Properties


#pragma mark - Setters
-(void)SH_setComposerCompletionBlock:(SHMessageComposerBlock)theBlock; {
  [_SHComposerBlocksManager setComposerDelegate:(id<SHComposerDelegate>)self];
  [_SHComposerBlocksManager setBlock:theBlock forController:self];
}



#pragma mark - Getters

-(SHMessageComposerBlock)SH_blockComposerCompletion; {
  return [_SHComposerBlocksManager blockForController:self];
}


@end
