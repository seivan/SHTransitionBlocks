
#import "MFMailComposeViewController+SHMessageUIBlocks.h"

#import "_SHComposerManager.h"

@interface MFMailComposeViewController (Private)
@end

@implementation MFMailComposeViewController (SHMessageUIBlocks)

#pragma mark -
#pragma mark Init
+(instancetype)SH_mailComposeViewController; {
  MFMailComposeViewController * vc = [[MFMailComposeViewController alloc] init];
  [_SHComposerBlocksManager setComposerDelegate:(id<SHComposerDelegate>)vc];
  return vc;
}



#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters
-(void)SH_setComposerCompletionBlock:(SHMailComposerBlock)theBlock; {
  [_SHComposerBlocksManager setComposerDelegate:(id<SHComposerDelegate>)self];
  [_SHComposerBlocksManager setBlock:theBlock forController:self];
}


#pragma mark -
#pragma mark Getters
-(SHMailComposerBlock)SH_blockComposerCompletion; {
  return [_SHComposerBlocksManager blockForController:self];
}


@end
