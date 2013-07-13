
#import "UINavigationController+SHNavigationControllerBlocks.h"

static NSString * const SH_blockWillShowViewController = @"SH_blockWillShowViewController";
static NSString * const SH_blockDidShowViewController = @"SH_blockDidShowViewController";

@protocol SHNavigationDelegate <NSObject>
@required
-(void)setDelegate:(id<UINavigationControllerDelegate>)theDelegate;
@end


@interface SHNavigationControllerBlockManager : NSObject
<UINavigationControllerDelegate>

@property(nonatomic,strong)   NSMapTable   * mapBlocks;
+(instancetype)sharedManager;
-(void)SH_memoryDebugger;

#pragma mark -
#pragma mark Class selectors

#pragma mark -
#pragma mark Setter
+(void)setComposerDelegate:(id<SHNavigationDelegate>)theNavigationDelegate;

+(void)setBlock:(id)theBlock
  forController:(UIViewController *)theController
        withKey:(NSString *)theKey;

#pragma mark -
#pragma mark Getter
+(id)blockForController:(UIViewController *)theController withKey:(NSString *)theKey;

@end

@implementation SHNavigationControllerBlockManager

#pragma mark -
#pragma mark Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapBlocks            = [NSMapTable weakToStrongObjectsMapTable];
    [self SH_memoryDebugger];
  }
  
  return self;
}

+(instancetype)sharedManager; {
  static SHNavigationControllerBlockManager * _sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHNavigationControllerBlockManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}


#pragma mark -
#pragma mark Debugger
-(void)SH_memoryDebugger; {
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"MAP %@",self.mapBlocks);
    [self SH_memoryDebugger];
  });
}

#pragma mark -
#pragma mark Class selectors

#pragma mark -
#pragma mark Setter
+(void)setComposerDelegate:(id<SHNavigationDelegate>)theComposer;{
  [theComposer setDelegate:[SHNavigationControllerBlockManager sharedManager]];
}

+(void)setBlock:(id)theBlock
  forController:(UIViewController *)theController
        withKey:(NSString *)theKey; {
  NSAssert(theController, @"Must pass theController");
  
  id block = [theBlock copy];
  
  SHNavigationControllerBlockManager * manager = [SHNavigationControllerBlockManager
                                                  sharedManager];
  NSMutableDictionary * map = [manager.mapBlocks objectForKey:self];
  if(map == nil) {
    map = [@{} mutableCopy];
    [manager.mapBlocks setObject:map forKey:self];
  }
  if(block == nil) {
    [map removeObjectForKey:theKey];
    if(map.count == 0) [manager.mapBlocks removeObjectForKey:theController];
  }
  
  else map[theKey] = block;
    

//  if(block)
//    [manager.mapBlocks setObject:block forKey:theController];
//  else
//    [manager.mapBlocks removeObjectForKey:theController];
  
}

#pragma mark -
#pragma mark Getter
+(id)blockForController:(UIViewController *)theController withKey:(NSString *)theKey; {
  NSAssert(theController, @"Must pass a controller to fetch blocks for");
  return [[[SHNavigationControllerBlockManager sharedManager].mapBlocks
          objectForKey:theController] objectForKey:theKey];
}

#pragma mark -
#pragma mark Delegates


#pragma mark -
#pragma mark <UINavigationControllerDelegate>
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated; {
  
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated; {
  
}

@end

@implementation UINavigationController  (SHNavigationControllerBlocks)

#pragma mark -
#pragma mark Init
-(void)SH_setBlocks; {
  self.delegate = [SHNavigationControllerBlockManager sharedManager];
}


#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters

-(void)SH_setWillShowViewControllerBlock:(SHNavigationControllerBlock)theBlock; {
  [SHNavigationControllerBlockManager setBlock:theBlock
                                 forController:self
                                       withKey:SH_blockWillShowViewController];
}

-(void)SH_setDidShowViewControllerBlock:(SHNavigationControllerBlock)theBlock; {
  [SHNavigationControllerBlockManager setBlock:theBlock
                                 forController:self
                                       withKey:SH_blockDidShowViewController];
  
}

#pragma mark -
#pragma mark Getters
-(SHNavigationControllerBlock)SH_blockWillShowViewController; {
  return [SHNavigationControllerBlockManager blockForController:self
                                                        withKey:SH_blockWillShowViewController];
}
-(SHNavigationControllerBlock)SH_blockDidShowViewController; {
  return [SHNavigationControllerBlockManager blockForController:self
                                                        withKey:SH_blockDidShowViewController];
}
@end