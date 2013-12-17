

#import <MessageUI/MFMessageComposeViewController.h>


#pragma mark - Block Defs
typedef void (^SHMessageComposerBlock)(MFMessageComposeViewController * theController,
                                       MessageComposeResult theResults);


@interface MFMessageComposeViewController (SHMessageUIBlocks)


#pragma mark - Init
+(instancetype)SH_messageComposeViewController;
+(instancetype)SH_messageComposeViewControllerWithBlock:(SHMessageComposerBlock)theBlock;

#pragma mark - Properties


#pragma mark - Setters
-(void)SH_setComposerCompletionBlock:(SHMessageComposerBlock)theBlock;



#pragma mark - Getters
@property(nonatomic,readonly) SHMessageComposerBlock SH_blockComposerCompletion;


@end