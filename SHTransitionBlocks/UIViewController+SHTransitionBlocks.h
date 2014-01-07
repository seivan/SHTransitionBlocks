



@protocol SHViewControllerAnimatedTransitioning <UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign,getter = isReversed) BOOL reversed;
@property(nonatomic,strong) NSMutableDictionary * userInfo;
@property(nonatomic,readonly) id<UIViewControllerContextTransitioning> transitionContext;
@end

typedef void(^SHViewControllerAnimationCompletionBlock)();

typedef void(^SHViewControllerContextTransitioningPreparedAnimationBlock)(UIView * containerView,
                                                                          UIViewController * fromVC,
                                                                          UIViewController * toVC,
                                                                          NSTimeInterval duration,
                                                                          id<SHViewControllerAnimatedTransitioning> transitionObject,
                                                                          SHViewControllerAnimationCompletionBlock transitionDidComplete
                                                                          );

typedef void(^SHViewControllerContextTransitioningAnimationBlock)(id<SHViewControllerAnimatedTransitioning> transitionObject);

typedef NSTimeInterval(^SHViewControllerContextTransitioningDurationBlock)(id<SHViewControllerAnimatedTransitioning> transitionObject);

typedef UIGestureRecognizer *(^SHInteractiveTransitionCreateGestureRecognitionBlock)(UIScreenEdgePanGestureRecognizer * edgeRecognizer);

typedef void(^SHInteractiveTransitionCallbackGestureRecognitionBlock)(UIViewController * controller,
                                                                      UIGestureRecognizer * recognizer,
                                                                      UIGestureRecognizerState state,
                                                                      CGPoint location
                                                                      );


@interface UIViewController (SHTransitionBlocks)

@property(nonatomic,strong, setter = SH_setInteractiveTransition:) UIPercentDrivenInteractiveTransition * SH_interactiveTransition;

-(void)SH_setInteractiveTransitionWithGestureBlock:(SHInteractiveTransitionCreateGestureRecognitionBlock)theGestureCreateBlock
                            onGestureCallbackBlock:(SHInteractiveTransitionCallbackGestureRecognitionBlock)theGestureCallbackBlock;

-(id<SHViewControllerAnimatedTransitioning>)SH_animatedTransition;

-(void)SH_setAnimationDuration:(NSTimeInterval)theDuration
   withPreparedTransitionBlock:(SHViewControllerContextTransitioningPreparedAnimationBlock)theBlock;

-(void)SH_setAnimatedTransitionBlock:(SHViewControllerContextTransitioningAnimationBlock)theBlock;
-(void)SH_setDurationTransitionBlock:(SHViewControllerContextTransitioningDurationBlock)theBlock;

@property(nonatomic,readonly) SHViewControllerContextTransitioningPreparedAnimationBlock SH_blockAnimationDurationWithPreparedTransition;
@property(nonatomic,readonly)  SHViewControllerContextTransitioningAnimationBlock SH_blockAnimatedTransition;
@property(nonatomic,readonly)  SHViewControllerContextTransitioningDurationBlock SH_blockDurationTransition;


@end