//
//  BSModalDatePickerPeriodBase.h
//  eOral-iPhone
//
//  Created by fisea on 17/3/15.
//  Copyright © 2017年 fisea. All rights reserved.
//
#define ONE_DAY_INTERVAL 24 * 60 * 60
#define ONE_YEAR_DAY 365

#define BSMODALDATEPERIODPICKER_PANEL_HEIGHT 350
#define BSMODALDATEPERIODPICKER_TOOLBAR_HEIGHT 44
#define BSMODALDATEPERIODPICKER_BACKDROP_OPACITY 0.2
#define BSMODALDATEPERIODPICKER_DATEPERIODVIEW_HEIGHT 85
#define BSMODALDATEPERIODPICKER_DATEPICKER_HEIGHT 165
#define BSMODALDATEPERIODPICKER_LINEVIEW_HEIGHT 1
#define BSMODALDATEPERIODPICKER_BOTTOMOKVIEW_HEIGHT 55
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width

#define kToolBarBackgroundColor [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0]
#define kTitleLabelColor [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]
#define kBottomViewBackgroundColor [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0]
#define kOKButtonTitleColor [UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0]

#define mBlueColor [UIColor colorWithRed:50.0/255.0 green:162.0/255.0 blue:248.0/255.0 alpha:1.0]
#define mGrayColor [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0]
#define kDateLabelValueColor [UIColor colorWithRed:54.0/255.0 green:143.0/255.0 blue:255.0/255.0 alpha:1.0]
#define kLineViewBackgroundColor [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0]

#import <UIKit/UIKit.h>
typedef void (^BSModalPickerPeriodViewCallback)(BOOL madeChoice);

@interface BSModalDatePickerPeriodBase : UIView{
    UIView* _picker;
}
//@property (nonatomic, strong) NSDateFormatter *formatter;
//@property (nonatomic,strong)  UIDatePicker *datePicker;
@property (nonatomic, copy) void(^gotoSrceenDateSelectBlock)(NSString *,NSString *);

@property (nonatomic, strong) UIView *picker;

/* Determines whether to display the opaque backdrop view.  By default, this is YES. */
@property (nonatomic) BOOL presentBackdropView;
/* Presents the control embedded in the provided view.
 Arguments:
 view        - The view that will contain the control.
 callback    - The block that will receive the result of the user action.
 */
- (void)presentInView:(UIView *)view withBlock:(BSModalPickerPeriodViewCallback)callback;

/* Presents the control embedded in the window.
 Arguments:
 callback    - The block that will receive the result of the user action.
 */
- (void)presentInWindowWithBlock:(BSModalPickerPeriodViewCallback)callback;

/* Subclasses must override this method.  Subclasses implementations must NOT call super. */
//- (UIView *)pickerWithFrame:(CGRect)pickerFrame;

/* Events that may be overridden in subclasses */
- (void)onDone:(id)sender;
- (void)onCancel:(id)sender;
- (void)onBackdropTap:(id)sender;

@end
