
#import <MessageUI/MFMailComposeViewController.h>


#pragma mark -
#pragma mark Block Defs
typedef void (^SHMailComposerBlock)(MFMailComposeViewController * theController,
                                    MFMailComposeResult theResults,
                                    NSError * theError);

@interface MFMailComposeViewController (SHMessageUIBlocks)

#pragma mark -
#pragma mark Init
+(instancetype)SH_mailComposeViewController;

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters
-(void)SH_setComposerCompletionBlock:(SHMailComposerBlock)theBlock;


#pragma mark -
#pragma mark Getters
@property(nonatomic,readonly) SHMailComposerBlock SH_blockComposerCompletion;

@end