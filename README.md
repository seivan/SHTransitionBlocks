SHNavigationControllerBlocks
==========

Overview
--------
The blocks are automatically removed once they UINavigationController is gone, so it isn't necessary to clean up - Swizzle Free(™)

### API

#### [Setup](https://github.com/seivan/SHNavigationControllerBlocks#setup-2)

#### [Properties](https://github.com/seivan/SHNavigationControllerBlocks#properties-1)


Installation
------------

```ruby
pod 'SHNavigationControllerBlocks'
```

***

Setup
-----

Put this either in specific files or your project prefix file

```objective-c
#import "UINavigationController+SHNavigationControllerBlocks.h"
```
or
```objective-c
#import "SHNavigationControllerBlocks.h"
```

You need to setup the blocks delegate by calling

```objective-c
-(void)SH_setNavigationBlocks;
```


API
-----

### Setup

```objective-c

#pragma mark -
#pragma mark Init
-(void)SH_setNavigationBlocks;

```

### Properties

```objective-c

#pragma mark -
#pragma mark Block Def

typedef void (^SHNavigationControllerBlock)(UINavigationController * theNavigationController,
                                            UIViewController       * theViewController,
                                            BOOL                      isAnimated);

                                            
#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters

-(void)SH_setWillShowViewControllerBlock:(SHNavigationControllerBlock)theBlock;

-(void)SH_setDidShowViewControllerBlock:(SHNavigationControllerBlock)theBlock;

#pragma mark -
#pragma mark Getters

@property(nonatomic,readonly) SHNavigationControllerBlock SH_blockWillShowViewController;
@property(nonatomic,readonly) SHNavigationControllerBlock SH_blockDidShowViewController;
```


Contact
-------

If you end up using SHNavigationControllerBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHNavigationControllerBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHNavigationControllerBlocks/blob/master/LICENSE.md) file.

