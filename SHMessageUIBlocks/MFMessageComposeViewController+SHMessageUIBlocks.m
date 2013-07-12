
#import "MFMessageComposeViewController+SHMessageUIBlocks.h"

#import "_SHComposerManager.h"

@implementation MFMessageComposeViewController (SHMessageUIBlocks)

#pragma mark -
#pragma mark Init
+(instancetype)SH_messageComposeViewController; {
  MFMessageComposeViewController * vc = [[MFMessageComposeViewController alloc] init];
  [_SHComposerManager setComposerDelegate:(id<SHComposerDelegate>)vc];
  return vc;
}


#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters
-(void)SH_setCompletionBlock:(SHMessageComposerBlock)theBlock; {
  [_SHComposerManager setBlock:theBlock forController:self];
}


#pragma mark -
#pragma mark Getters

-(SHMessageComposerBlock)SH_blockCompletion; {
  return [_SHComposerManager blockForController:self];
}


@end
