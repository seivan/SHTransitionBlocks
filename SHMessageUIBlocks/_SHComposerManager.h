
@protocol SHComposerDelegate <NSObject>
@required
-(void)setDelegate:(id<UINavigationControllerDelegate>)theDelegate;
@end

@interface _SHComposerManager : NSObject
#pragma mark -
#pragma mark Class selectors

#pragma mark -
#pragma mark Setter
+(void)setComposerDelegate:(id<SHComposerDelegate>)theComposer;

+(void)setBlock:(id)theBlock forController:(UIViewController *)theController;

#pragma mark -
#pragma mark Getter
+(id)blockForController:(UIViewController *)theController;
@end