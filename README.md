SHMessageUIBlocks
==========

Overview
--------
The blocks are automatically removed once the alert is gone, so it isn't necessary to clean up - Swizzle Free(™)

### API

#### [Init](https://github.com/seivan/SHMessageUIBlocks#init-1)

#### [Add](https://github.com/seivan/SHMessageUIBlocks#add-1)

#### [Properties](https://github.com/seivan/SHMessageUIBlocks#properties-1)


Installation
------------

```ruby
pod 'SHMessageUIBlocks'
```

***

Setup
-----

Put this either in specific files or your project prefix file

```objective-c
#import "MFMailComposeViewController+SHMessageUIBlocks.h"
```
or
```objective-c
#import "MFMessageComposeViewController+SHMessageUIBlocks.h"
```

API
-----

### Init

```objective-c
#pragma mark -
#pragma mark Init
+(instancetype)SH_alertViewWithTitle:(NSString *)theTitle withMessage:(NSString *)theMessage;

+(instancetype)SH_alertViewWithTitle:(NSString *)theTitle
                          andMessage:(NSString *)theMessage
                        buttonTitles:(NSArray *)theButtonTitles
                         cancelTitle:(NSString *)theCancelTitle
                           withBlock:(SHAlertViewBlock)theBlock;


```

### Add

```objective-c
#pragma mark -
#pragma mark Adding
-(NSUInteger)SH_addButtonWithTitle:(NSString *)theTitle
                         withBlock:(SHAlertViewBlock)theBlock;


///Will add a new cancel button and make previous cancel buttons to a normal button
-(NSUInteger)SH_addButtonCancelWithTitle:(NSString *)theTitle
                               withBlock:(SHAlertViewBlock)theBlock;



```

### Properties

```objective-c
#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters
-(void)SH_setButtonBlockForIndex:(NSUInteger)theButtonIndex
                       withBlock:(SHAlertViewBlock)theBlock;

-(void)SH_setButtonCancelBlock:(SHAlertViewBlock)theBlock;

-(void)SH_setWillShowBlock:(SHAlertViewShowBlock)theBlock;
-(void)SH_setDidShowBlock:(SHAlertViewShowBlock)theBlock;

-(void)SH_setWillDismissBlock:(SHAlertViewDismissBlock)theBlock;
-(void)SH_setDidDismissBlock:(SHAlertViewDismissBlock)theBlock;

-(void)SH_setFirstButtonEnabled:(SHAlertViewFirstButtonEnabledBlock)theBlock;

#pragma mark -
#pragma mark Getters
-(SHAlertViewBlock)SH_blockForButtonIndex:(NSUInteger)theButtonIndex;


@property(nonatomic,readonly) SHAlertViewBlock SH_blockForCancelButton;


@property(nonatomic,readonly) SHAlertViewShowBlock    SH_blockWillShow;
@property(nonatomic,readonly) SHAlertViewShowBlock    SH_blockDidShow;

@property(nonatomic,readonly) SHAlertViewDismissBlock SH_blockWillDismiss;
@property(nonatomic,readonly) SHAlertViewDismissBlock SH_blockDidDismiss;

@property(nonatomic,readonly) SHAlertViewFirstButtonEnabledBlock SH_blockFirstButtonEnabled;


```


Contact
-------

If you end up using SHAlertViewBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHAlertViewBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHAlertViewBlocks/blob/master/LICENSE.md) file.

