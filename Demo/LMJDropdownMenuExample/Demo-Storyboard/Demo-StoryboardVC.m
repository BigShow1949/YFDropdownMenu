//
//  Demo-StoryboardVC.m
//  YFDropdownMenuExample
//
//  Created by JerryLMJ on 2019/12/23.
//  Copyright © 2019 LMJ. All rights reserved.
//

#import "Demo-StoryboardVC.h"

#import "YFDropdownMenu.h"

@interface Demo_StoryboardVC () <YFDropdownMenuDelegate,YFDropdownMenuDataSource>

@property (weak, nonatomic) IBOutlet YFDropdownMenu *dropdownMenu;

@end

@implementation Demo_StoryboardVC
{
    NSArray * _menu1OptionTitles;
    NSArray * _menu1OptionIcons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"back" forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor lightGrayColor]];
    [backBtn setFrame:CGRectMake(20, 20, 90, 30)];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    
    /* YFDropdownMenu */
    _menu1OptionTitles = @[@"Option1",@"Option2",@"Option3",@"Option4",@"Option5"];
    _menu1OptionIcons = @[@"icon1",@"icon2",@"icon3",@"icon4",@"icon5"];
    
    _dropdownMenu.delegate   = self;
    _dropdownMenu.dataSource = self;
    
    _dropdownMenu.layer.borderColor  = [UIColor whiteColor].CGColor;
    
    _dropdownMenu.title           = @"Please Select";
    _dropdownMenu.titleBgColor    = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    _dropdownMenu.titleFont       = [UIFont boldSystemFontOfSize:15];
    _dropdownMenu.titleColor      = [UIColor whiteColor];
    _dropdownMenu.titleAlignment  = NSTextAlignmentLeft;
    _dropdownMenu.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    _dropdownMenu.rotateIcon      = [UIImage imageNamed:@"arrowIcon3"];
    _dropdownMenu.rotateIconSize  = CGSizeMake(15, 15);
    
    _dropdownMenu.optionBgColor       = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    _dropdownMenu.optionFont          = [UIFont systemFontOfSize:13];
    _dropdownMenu.optionTextColor     = [UIColor blackColor];
    _dropdownMenu.optionTextAlignment = NSTextAlignmentLeft;
    _dropdownMenu.optionNumberOfLines = 0;
    _dropdownMenu.optionLineColor     = [UIColor whiteColor];
    _dropdownMenu.optionIconSize      = CGSizeMake(15, 15);
    /* YFDropdownMenu */
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - YFDropdownMenu DataSource
- (NSUInteger)numberOfOptionsInDropdownMenu:(YFDropdownMenu *)menu{
    return _menu1OptionTitles.count;
}
- (CGFloat)dropdownMenu:(YFDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index{
    return 30;
}
- (NSString *)dropdownMenu:(YFDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index{
    return _menu1OptionTitles[index];
}
- (UIImage *)dropdownMenu:(YFDropdownMenu *)menu iconForOptionAtIndex:(NSUInteger)index{
    return [UIImage imageNamed:_menu1OptionIcons[index]];
}
#pragma mark - YFDropdownMenu Delegate
- (void)dropdownMenu:(YFDropdownMenu *)menu didSelectOptionAtIndex:(NSUInteger)index optionTitle:(NSString *)title{
    NSLog(@"你选择了(you selected)：menu1，index: %ld - title: %@", index, title);
}
- (void)dropdownMenuWillShow:(YFDropdownMenu *)menu{
    NSLog(@"--将要显示(will appear)--menu1");
}
- (void)dropdownMenuDidShow:(YFDropdownMenu *)menu{
    NSLog(@"--已经显示(did appear)--menu1");
}

- (void)dropdownMenuWillHidden:(YFDropdownMenu *)menu{
    NSLog(@"--将要隐藏(will disappear)--menu1");
}
- (void)dropdownMenuDidHidden:(YFDropdownMenu *)menu{
    NSLog(@"--已经隐藏(did disappear)--menu1");
}


@end
