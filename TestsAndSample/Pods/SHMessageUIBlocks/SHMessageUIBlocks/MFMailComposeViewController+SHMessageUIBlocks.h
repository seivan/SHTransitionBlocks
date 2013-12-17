
#import <MessageUI/MFMailComposeViewController.h>



#pragma mark - Block Defs
typedef void (^SHMailComposerBlock)(MFMailComposeViewController * theController,
                                    MFMailComposeResult theResults,
                                    NSError * theError);

@interface MFMailComposeViewController (SHMessageUIBlocks)


#pragma mark - Init
+(instancetype)SH_mailComposeViewController;
+(instancetype)SH_mailComposeViewControllerWithBlock:(SHMailComposerBlock)theBlock;

#pragma mark - Properties


#pragma mark - Setters
-(void)SH_setComposerCompletionBlock:(SHMailComposerBlock)theBlock;



#pragma mark - Getters
@property(nonatomic,readonly) SHMailComposerBlock SH_blockComposerCompletion;

@end