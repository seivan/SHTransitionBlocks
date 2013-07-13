

#import <MessageUI/MFMessageComposeViewController.h>

#pragma mark -
#pragma mark Block Defs
typedef void (^SHMessageComposerBlock)(MFMessageComposeViewController * theController,
                                       MessageComposeResult theResults);


@interface MFMessageComposeViewController (SHMessageUIBlocks)

#pragma mark -
#pragma mark Init
+(instancetype)SH_messageComposeViewController;

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters
-(void)SH_setComposerCompletionBlock:(SHMessageComposerBlock)theBlock;


#pragma mark -
#pragma mark Getters
@property(nonatomic,readonly) SHMessageComposerBlock SH_blockComposerCompletion;


@end