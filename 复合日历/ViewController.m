//
//  ViewController.m
//  复合日历
//
//  Created by fisea on 17/7/23.
//  Copyright © 2017年 Fisea. All rights reserved.
//

#import "ViewController.h"
#import "BSModalDatePickerPeriodBase.h"
@interface ViewController ()
{
    BSModalDatePickerPeriodBase *datePickerPeriod;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/*
 之前是用懒加载的方式初始化inputView和datePicker，发现会有一定时间的延迟，如果有人发现更好的方式，请赐教。故将初始化方法在这里调用，这样则一点击按钮控件就能弹出来。
 */

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (datePickerPeriod==nil)
    {
        datePickerPeriod=[[BSModalDatePickerPeriodBase alloc] init];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)selectDate:(UIButton *)sender {
    [datePickerPeriod presentInWindowWithBlock:^(BOOL madeChoice) {
    }];
    __weak typeof(self) weakSelf = self;
    datePickerPeriod.gotoSrceenDateSelectBlock=^(NSString *beginDateStr,NSString *endDateStr){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *startDateStr=@"开始日期：";
             NSString *end1DateStr=@"结束日期：";
            weakSelf.startDateLabel.text=[startDateStr stringByAppendingString:beginDateStr];
            weakSelf.endDateLabel.text=[end1DateStr stringByAppendingString:endDateStr];
        });
    };

}
@end
