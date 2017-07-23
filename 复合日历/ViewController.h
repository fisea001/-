//
//  ViewController.h
//  复合日历
//
//  Created by fisea on 17/7/23.
//  Copyright © 2017年 Fisea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnSelectDate;
- (IBAction)selectDate:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;

@end

