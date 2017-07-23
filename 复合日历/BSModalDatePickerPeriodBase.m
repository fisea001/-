//
//  BSModalDatePickerPeriodBase.m
//  eOral-iPhone
//
//  Created by fisea on 17/3/15.
//  Copyright © 2017年 fisea. All rights reserved.
//

#import "BSModalDatePickerPeriodBase.h"
@interface BSModalDatePickerPeriodBase ()

@property(nonatomic,strong) UIView *toolbarView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *panel;
@property (nonatomic,strong)  UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *backdropView;
@property (nonatomic, strong) BSModalPickerPeriodViewCallback callbackBlock;
@property(nonatomic,strong) UIView *datePeriodView;
@property(nonatomic,strong) UIView *lineView;
@property(nonatomic,strong) UIView *bottomOkView;

@property(nonatomic,strong) UIButton *btnStartDate;
@property(nonatomic,strong) UIButton *btnEndDate;
@property(nonatomic,strong) UIButton *btnDone;
@property(nonatomic,strong) UILabel *lblStartDate;
@property(nonatomic,strong) UILabel *lblEndDate;
@property (nonatomic, strong) NSDateFormatter *formatter;
@end
@implementation BSModalDatePickerPeriodBase

#pragma mark - Designated Initializer

- (id)init {
    self = [super init];
    if (self) {
        self.autoresizesSubviews = YES;
        self.presentBackdropView = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self loadInView];
    }
    return self;
}

#pragma mark - Custom Getters

-(UIDatePicker *)datePicker
{
    if (!_datePicker) {
        CGRect pickerFrame = CGRectMake(0,
                                        BSMODALDATEPERIODPICKER_DATEPERIODVIEW_HEIGHT+BSMODALDATEPERIODPICKER_TOOLBAR_HEIGHT,
                                        self.bounds.size.width,
                                        BSMODALDATEPERIODPICKER_DATEPICKER_HEIGHT);
        _datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
        _datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.datePickerMode=UIDatePickerModeDate;
    }
    return _datePicker;
}

-(UIView *)toolbarView
{
    if (!_toolbarView) {
        _toolbarView=[[UIView alloc] initWithFrame:CGRectMake(0, BSMODALDATEPERIODPICKER_DATEPERIODVIEW_HEIGHT, SCREEN_WIDTH, BSMODALDATEPERIODPICKER_TOOLBAR_HEIGHT)];
        _toolbarView.backgroundColor=kToolBarBackgroundColor;
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 120, BSMODALDATEPERIODPICKER_TOOLBAR_HEIGHT)];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:kTitleLabelColor];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        //[_titleLabel setText:LOCALIZATION(@"PlanSelect")];
        UIButton *btnOK=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-75, 0, 60, BSMODALDATEPERIODPICKER_TOOLBAR_HEIGHT)];
        [btnOK setTitle:@"确定" forState:UIControlStateNormal];
        [btnOK setTitleColor:kOKButtonTitleColor forState:UIControlStateNormal];
        //[btnOK setBackgroundImage:[self createImageWithColor:mBlueColor] forState:UIControlStateNormal];
        [btnOK addTarget:self action:@selector(okButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_toolbarView addSubview:_titleLabel];
        [_toolbarView addSubview:btnOK];
    }
    return _toolbarView;
}

- (UIView *)backdropView {
    if (!_backdropView) {
        _backdropView = [[UIView alloc] initWithFrame:self.bounds];
        _backdropView.backgroundColor = [UIColor colorWithWhite:0 alpha:BSMODALDATEPERIODPICKER_BACKDROP_OPACITY];
        _backdropView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backdropView.alpha = 0;
        UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackdropTap:)];
        [_backdropView addGestureRecognizer:tapRecognizer];
    }
    
    return _backdropView;
}
-(UIView *)datePeriodView//85
{
    if (!_datePeriodView) {
        _datePeriodView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BSMODALDATEPERIODPICKER_DATEPERIODVIEW_HEIGHT)];
        _datePeriodView.backgroundColor=[UIColor whiteColor];
        UIView *startDateView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, BSMODALDATEPERIODPICKER_DATEPERIODVIEW_HEIGHT)];
        startDateView.backgroundColor=[UIColor whiteColor];
        self.btnStartDate=[[UIButton alloc] initWithFrame:CGRectMake(30.0f, 15.0f, SCREEN_WIDTH/2-60, 30.0f)];
        [self.btnStartDate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnStartDate addTarget:self action:@selector(beginDateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //btnStartDate.tintColor=[UIColor blueColor];
        self.lblStartDate=[[UILabel alloc] initWithFrame:CGRectMake(0, 53.0f, SCREEN_WIDTH/2, 17.0f)];
        [self.lblStartDate setTextColor:kDateLabelValueColor];
        self.lblStartDate.text=@"请选择";
        self.lblStartDate.textAlignment=NSTextAlignmentCenter;
        [startDateView addSubview:self.btnStartDate];
        [startDateView addSubview:self.lblStartDate];
        
        UIView *endDateView=[[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, BSMODALDATEPERIODPICKER_DATEPERIODVIEW_HEIGHT)];
        endDateView.backgroundColor=[UIColor whiteColor];
        self.btnEndDate=[[UIButton alloc] initWithFrame:CGRectMake(30.0f, 15.0f, SCREEN_WIDTH/2-60, 30.0f)];
        [self.btnEndDate setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.btnEndDate addTarget:self action:@selector(endDateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.btnEndDate.tintColor=[UIColor blueColor];
        self.lblEndDate=[[UILabel alloc] initWithFrame:CGRectMake(0, 53.0f, SCREEN_WIDTH/2, 17.0f)];
        [self.lblEndDate setTextColor:kDateLabelValueColor];
        self.lblEndDate.text=@"请选择";
        self.lblEndDate.textAlignment=NSTextAlignmentCenter;
        [endDateView addSubview:self.btnEndDate];
        [endDateView addSubview:self.lblEndDate];
        
        [self.btnStartDate setTitle:@"开始日期" forState:UIControlStateNormal];
        [self.btnEndDate setTitle:@"结束日期" forState:UIControlStateNormal];
        //[self.okBtn setTitle:LOCALIZATION(@"OK") forState:UIControlStateNormal];
        //[self.okBtnToSrceenOrder setTitle:LOCALIZATION(@"OK") forState:UIControlStateNormal];
        
        //self.tipLable.text=LOCALIZATION(@"SelectDate");
        // 开始时间和结束时间按钮的UI
        self.btnStartDate.layer.cornerRadius = self.btnStartDate.frame.size.height * 0.5;
        self.btnStartDate.clipsToBounds = YES;
        self.btnEndDate.layer.cornerRadius = self.btnEndDate.frame.size.height * 0.5;
        self.btnEndDate.clipsToBounds = YES;
        
        [self.btnStartDate setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [self.btnEndDate setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [self.btnStartDate setBackgroundImage:[self createImageWithColor:mBlueColor] forState:UIControlStateSelected];
        [self.btnEndDate setBackgroundImage:[self createImageWithColor:mBlueColor] forState:UIControlStateSelected];
        
        self.btnStartDate.layer.borderWidth = 1;
        self.btnStartDate.layer.borderColor = mBlueColor.CGColor;
        self.btnEndDate.layer.borderWidth = 1;
        self.btnEndDate.layer.borderColor = mBlueColor.CGColor;
        [_datePeriodView addSubview:startDateView];
        [_datePeriodView addSubview:endDateView];
    }
    return _datePeriodView;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(0, BSMODALDATEPERIODPICKER_DATEPERIODVIEW_HEIGHT+BSMODALDATEPERIODPICKER_TOOLBAR_HEIGHT+BSMODALDATEPERIODPICKER_DATEPICKER_HEIGHT, SCREEN_WIDTH, BSMODALDATEPERIODPICKER_LINEVIEW_HEIGHT)];
        _lineView.backgroundColor=kLineViewBackgroundColor;
    }
    return _lineView;
}
-(UIView *)bottomOkView//55
{
    if (!_bottomOkView) {
        _bottomOkView=[[UIView alloc] initWithFrame:CGRectMake(0, BSMODALDATEPERIODPICKER_DATEPERIODVIEW_HEIGHT+BSMODALDATEPERIODPICKER_TOOLBAR_HEIGHT+BSMODALDATEPERIODPICKER_DATEPICKER_HEIGHT+BSMODALDATEPERIODPICKER_LINEVIEW_HEIGHT, SCREEN_WIDTH, BSMODALDATEPERIODPICKER_BOTTOMOKVIEW_HEIGHT)];
        _bottomOkView.backgroundColor=kBottomViewBackgroundColor;
        self.btnDone=[[UIButton alloc] initWithFrame:CGRectMake(20.0f, 10.0f, SCREEN_WIDTH-40.f, 35)];
        [_bottomOkView addSubview:self.btnDone];
        [self.btnDone setTitle:@"确定" forState:UIControlStateNormal];
        [self.btnDone addTarget:self action:@selector(gotoSrceenDateSelectClick:) forControlEvents:UIControlEventTouchUpInside];
        self.btnDone.backgroundColor = mBlueColor;
        [self.btnDone setBackgroundImage:[self createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
        self.btnDone.titleLabel.font = [UIFont systemFontOfSize:16];
        self.btnDone.enabled = NO;
        self.btnDone.layer.cornerRadius = 3;
        self.btnDone.clipsToBounds = YES;
    }
    return _bottomOkView;
}
#pragma mark - Event Handlers

/** 确定选择该时间 */
- (void)okButtonClick:(UIButton *)sender {
    if (self.btnStartDate.selected) {
        self.lblStartDate.text = [self.formatter stringFromDate:self.datePicker.date];
        // 选择了开始时间，去选择结束时间
        [self endDateBtnClick:self.btnEndDate];
    }
    else {
        self.lblEndDate.text = [self.formatter stringFromDate:self.datePicker.date];
        // 选择了结束时间，去选择开始时间
        [self beginDateBtnClick:self.btnStartDate];
    }
    [self refreshOkBtnEnableStatus];
}

- (void)endDateBtnClick:(UIButton *)sender {
    self.btnEndDate.selected = YES;
    self.btnStartDate.selected = NO;
    
    self.titleLabel.text = @"选择结束日期";
    [self.btnEndDate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnStartDate setTitleColor:mBlueColor forState:UIControlStateNormal];
    
    if (![self.lblEndDate.text isEqualToString:@"请选择"]) {
        [self.datePicker setDate:[self.formatter dateFromString:self.lblEndDate.text] animated:YES];
    }
    [self refreshOkBtnEnableStatus];
}
/** 选择开始时间 */
- (void)beginDateBtnClick:(id)sender {
    self.btnStartDate.selected = YES;
    self.btnEndDate.selected = NO;
    
    self.titleLabel.text = @"选择开始日期";
    [self.btnStartDate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnEndDate setTitleColor:mBlueColor forState:UIControlStateNormal];
    
    if (![self.lblStartDate.text isEqualToString:@"请选择"]) {
        [self.datePicker setDate:[self.formatter dateFromString:self.lblStartDate.text] animated:YES];
    }
    
    [self refreshOkBtnEnableStatus];
}
- (void)gotoSrceenDateSelectClick:(id)sender {
    [self onDone:sender];
    if (self.gotoSrceenDateSelectBlock) {
        self.gotoSrceenDateSelectBlock(self.lblStartDate.text,self.lblEndDate.text);
    }
}
- (void)onCancel:(id)sender {
    self.callbackBlock(NO);
    [self dismissPicker];
}

- (void)onDone:(id)sender {
    self.callbackBlock(YES);
    [self dismissPicker];
}

- (void)onBackdropTap:(id)sender {
    [self onCancel:sender];
}

#pragma mark - Instance Methods

-(void)loadInView //初始化一下
{
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateFormat = @"yyyy-MM-dd";
    self.datePicker.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hant"];
    self.datePicker.timeZone=[NSTimeZone systemTimeZone];
    self.datePicker.minimumDate = [NSDate date];
    self.datePicker.maximumDate=[self.datePicker.minimumDate dateByAddingTimeInterval:ONE_DAY_INTERVAL*ONE_YEAR_DAY];
    id appDelegate = [[UIApplication sharedApplication] delegate];
    UIWindow *window = [appDelegate window];
    //NSDate *date1=[NSDate date];
    self.frame = window.bounds;
    [self.panel removeFromSuperview];
    [self.backdropView removeFromSuperview];
    self.panel = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - BSMODALDATEPERIODPICKER_PANEL_HEIGHT, self.bounds.size.width, BSMODALDATEPERIODPICKER_PANEL_HEIGHT)];
    self.panel.autoresizesSubviews = YES;
    self.panel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (self.presentBackdropView) {
        [self addSubview:self.backdropView];
    }
    CGRect pickerFrame = CGRectMake(0,
                                    BSMODALDATEPERIODPICKER_DATEPERIODVIEW_HEIGHT+BSMODALDATEPERIODPICKER_TOOLBAR_HEIGHT,
                                    self.bounds.size.width,
                                    BSMODALDATEPERIODPICKER_DATEPICKER_HEIGHT+3);
    self.datePicker.frame=pickerFrame;
    [self.panel addSubview:self.datePeriodView];
    [self.panel addSubview:self.toolbarView];
    [self.panel addSubview:self.datePicker];
    [self.panel addSubview:self.lineView];
    [self.panel addSubview:self.bottomOkView];
}
- (void)presentInView:(UIView *)view withBlock:(BSModalPickerPeriodViewCallback)callback {
    self.frame = view.bounds;
    self.callbackBlock = callback;
    [self.panel removeFromSuperview];
    [self.backdropView removeFromSuperview];
    self.panel = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - BSMODALDATEPERIODPICKER_PANEL_HEIGHT, self.bounds.size.width, BSMODALDATEPERIODPICKER_PANEL_HEIGHT)];
    self.panel.autoresizesSubviews = YES;
    self.panel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (self.presentBackdropView) {
        [self addSubview:self.backdropView];
    }
    CGRect pickerFrame = CGRectMake(0,
                                    BSMODALDATEPERIODPICKER_DATEPERIODVIEW_HEIGHT+BSMODALDATEPERIODPICKER_TOOLBAR_HEIGHT,
                                    self.bounds.size.width,
                                    BSMODALDATEPERIODPICKER_DATEPICKER_HEIGHT+3);
    self.datePicker.frame=pickerFrame;
    [self.panel addSubview:self.datePeriodView];
    [self.panel addSubview:self.toolbarView];
    [self.panel addSubview:self.datePicker];
    [self.panel addSubview:self.lineView];
    [self.panel addSubview:self.bottomOkView];
    self.panel.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.panel];
    [view addSubview:self];
   /* self.formatter = [[NSDateFormatter alloc] init];
    if ([CurrentLanguage isEqualToString:@"zh-Hans"]) {
        self.formatter.dateFormat = SHORT_DATE_TIME_FORMAT;
    }
    else
    {
        self.formatter.dateFormat = SHORT_DATE_D_M_Y_FORMAT;
    }*/
    // 选中开始时间按钮
    [self beginDateBtnClick:self.btnStartDate];
    // 配置DatePicker
    /*self.datePicker.locale=[[NSLocale alloc] initWithLocaleIdentifier:CurrentLanguage];
    self.datePicker.timeZone=[NSTimeZone systemTimeZone];
    self.datePicker.minimumDate = [NSDate date];
    self.datePicker.maximumDate=[self.datePicker.minimumDate dateByAddingTimeInterval:ONE_DAY_INTERVAL*ONE_YEAR_DAY];*/
    CGRect oldFrame = self.panel.frame;
    CGRect newFrame = self.panel.frame;
    newFrame.origin.y += newFrame.size.height;
    self.panel.frame = newFrame;
    [UIView animateWithDuration:0.25 delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.panel.frame = oldFrame;
                         self.backdropView.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)presentInWindowWithBlock:(BSModalPickerPeriodViewCallback)callback {
    id appDelegate = [[UIApplication sharedApplication] delegate];
    UIWindow *window = [appDelegate window];
    [self presentInView:window withBlock:callback];
}

- (void)dismissPicker {
    [UIView animateWithDuration:0.25 delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect newFrame = self.panel.frame;
                         newFrame.origin.y += self.panel.frame.size.height;
                         self.panel.frame = newFrame;
                         self.backdropView.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self.picker removeFromSuperview];
                         [self.panel removeFromSuperview];
                         [self.backdropView removeFromSuperview];
                         
                         self.picker = nil;
                         self.panel = nil;
                         self.backdropView = nil;
                         
                         [self removeFromSuperview];
                     }];
}


/** 检查确定按钮是否可被点击*/
- (void)refreshOkBtnEnableStatus {
    
    self.btnDone.enabled = (![self.lblStartDate.text isEqualToString:@"请选择"] && ![self.lblEndDate.text isEqualToString:@"请选择"]);
    // 检查数据
    if (self.btnDone.enabled) {
        NSString *beginDateStr = [self.lblStartDate.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSString *endDateStr = [self.lblEndDate.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        if (beginDateStr.integerValue > endDateStr.integerValue) {
            [self.btnDone setTitle:@"开始日期须小于等于结束日期" forState:UIControlStateDisabled];
            self.btnDone.enabled = NO;
        } else {
            [self.btnDone setTitle:@"确定" forState:UIControlStateDisabled];
        }
    }
}

/** 用颜色生成一张图片 */
- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
