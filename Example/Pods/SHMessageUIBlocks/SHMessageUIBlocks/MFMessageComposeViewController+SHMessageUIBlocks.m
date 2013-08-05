
#import "MFMessageComposeViewController+SHMessageUIBlocks.h"

#import "_SHComposerManager.h"

@implementation MFMessageComposeViewController (SHMessageUIBlocks)

#pragma mark -
#pragma mark Init
+(instancetype)SH_messageComposeViewController; {
  MFMessageComposeViewController * vc = [[MFMessageComposeViewController alloc] init];
  [_SHComposerBlocksManager setComposerDelegate:(id<SHComposerDelegate>)vc];
  return vc;
}


#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters
-(void)SH_setComposerCompletionBlock:(SHMessageComposerBlock)theBlock; {
  [_SHComposerBlocksManager setComposerDelegate:(id<SHComposerDelegate>)self];
  [_SHComposerBlocksManager setBlock:theBlock forController:self];
}


#pragma mark -
#pragma mark Getters

-(SHMessageComposerBlock)SH_blockComposerCompletion; {
  return [_SHComposerBlocksManager blockForController:self];
}


@end
