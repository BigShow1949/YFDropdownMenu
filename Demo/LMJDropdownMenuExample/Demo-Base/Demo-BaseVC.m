//
//  Demo-BaseVC.m
//  YFDropdownMenuExample
//
//  Created by JerryLMJ on 2020/10/13.
//  Copyright © 2020 LMJ. All rights reserved.
//

#import "Demo-BaseVC.h"
#import "YFDropdownMenu.h"
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface Demo_BaseVC () <YFDropdownMenuDataSource,YFDropdownMenuDelegate>

@end

@implementation Demo_BaseVC
{
    NSArray * _menu1OptionTitles;
    NSArray * _menu1OptionIcons;
    
    NSArray * _menu3OptionTitles;
    
    YFDropdownMenu * navMenu;
    
    YFDropdownMenu * menu1;
    YFDropdownMenu * menu2;
    YFDropdownMenu * menu3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    _menu1OptionTitles = @[@"Option1",@"Option2",@"Option3",@"Option4",@"Option5"];
    _menu1OptionIcons = @[@"icon1",@"icon2",@"icon3",@"icon4",@"icon5"];
    
    _menu3OptionTitles = @[@"选项一\n1",@"选项二\n2",@"选项三\n3",@"选项四\n4",
                           @"选项一\n1",@"选项二\n2",@"选项三\n3",@"选项四\n4",
                           @"选项一\n1",@"选项二\n2",@"选项三\n3",@"选项四\n4",
                           @"选项一\n1",@"选项二\n2",@"选项三\n3",@"选项四\n4",
                           @"选项一\n1",@"选项二\n2",@"选项三\n3",@"选项四\n4",
                           @"选项一\n1",@"选项二\n2",@"选项三\n3",@"选项四\n4"];
    
    
    // ----------------------- navigation bar menu ---------------------------
    navMenu = [[YFDropdownMenu alloc] init];
    [navMenu setFrame:CGRectMake(self.view.bounds.size.width - 160, 2, 150, 40)];
    navMenu.dataSource = self;
    navMenu.delegate   = self;
    
    navMenu.layer.borderColor  = [UIColor whiteColor].CGColor;
    navMenu.layer.borderWidth  = 1;
    navMenu.layer.cornerRadius = 3;
    
    navMenu.title           = @"Please Select";
    navMenu.titleBgColor    = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    navMenu.titleFont       = [UIFont boldSystemFontOfSize:15];
    navMenu.titleColor      = [UIColor whiteColor];
    navMenu.titleAlignment  = NSTextAlignmentLeft;
    
    navMenu.rotateIcon            = [UIImage imageNamed:@"arrowIcon3"];
    navMenu.rotateIconSize        = CGSizeMake(15, 15);
    navMenu.rotateIconMarginRight = 15;
    
    navMenu.optionBgColor       = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    navMenu.optionFont          = [UIFont systemFontOfSize:13];
    navMenu.optionTextColor     = [UIColor blackColor];
    navMenu.optionTextAlignment = NSTextAlignmentLeft;
    navMenu.optionNumberOfLines = 0;
    navMenu.optionLineColor     = [UIColor whiteColor];
    navMenu.optionIconSize      = CGSizeMake(15, 15);
    
    [self.navigationController.navigationBar addSubview:navMenu];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 200, 170, 60)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    // ----------------------- menu1 ---------------------------
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    [self.view addSubview:bgview];
    
    menu1 = [[YFDropdownMenu alloc] init];
    [menu1 setFrame:CGRectMake(0, 0, 150, 40)];
    menu1.dataSource = self;
    menu1.delegate   = self;
    
    menu1.layer.borderColor  = [UIColor whiteColor].CGColor;
    menu1.layer.borderWidth  = 1;
    menu1.layer.cornerRadius = 3;
    
    menu1.title           = @"Please Select1";
    menu1.titleBgColor    = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    menu1.titleFont       = [UIFont boldSystemFontOfSize:15];
    menu1.titleColor      = [UIColor whiteColor];
    menu1.titleAlignment  = NSTextAlignmentLeft;
    
    menu1.rotateIcon      = [UIImage imageNamed:@"arrowIcon3"];
    menu1.rotateIconSize  = CGSizeMake(15, 15);
    
    menu1.optionBgColor         = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    menu1.optionFont            = [UIFont systemFontOfSize:13];
    menu1.optionTextColor       = [UIColor blackColor];
    menu1.optionTextAlignment   = NSTextAlignmentLeft;
    menu1.optionNumberOfLines   = 0;
    menu1.optionLineColor       = [UIColor whiteColor];
    menu1.optionIconSize        = CGSizeMake(15, 15);
    menu1.optionIconMarginRight = 30;
    
    [view addSubview:menu1];
    
    
    // ----------------------- menu2 ---------------------------
    menu2 = [[YFDropdownMenu alloc] initWithFrame:CGRectMake(200, 200, 150, 40)];
    menu2.dataSource = self;
    menu2.delegate   = self;

    menu2.layer.borderColor  = [UIColor blackColor].CGColor;
    menu2.layer.borderWidth  = 1;

    menu2.title           = @"Select2";
    menu2.titleBgColor    = [UIColor lightGrayColor];
    menu2.titleFont       = [UIFont boldSystemFontOfSize:15];
    menu2.titleColor      = [UIColor orangeColor];
    menu2.titleAlignment  = NSTextAlignmentCenter;

    menu2.optionBgColor       = [UIColor whiteColor];
    menu2.optionFont          = [UIFont systemFontOfSize:12];
    menu2.optionTextColor     = [UIColor blackColor];
    menu2.optionTextAlignment = NSTextAlignmentCenter;
    menu2.optionNumberOfLines = 0;
    menu2.optionLineColor     = [UIColor blackColor];
    menu2.optionLineHeight    = 1;
    
//    menu2.optionsListHeight = 100;
    menu2.showsVerticalScrollIndicatorOfOptionsList = NO;

    [self.view addSubview:menu2];
    
    
    
    // ----------------------- menu3 ---------------------------
    YFDropdownMenu *menu = [[YFDropdownMenu alloc] initWithFrame:CGRectMake(20, 250, 150, 40)];
    menu.dataSource = self;
    menu.delegate   = self;
    
    menu.layer.borderColor  = [UIColor whiteColor].CGColor;
    menu.layer.borderWidth  = 1;
    menu.layer.cornerRadius = 3;
    
    menu.titleBgColorSelected    = HexRGB(0x1890FF);
    menu.titleColorSelected      = HexRGB(0xFFFFFF);
//    menu.rotateIconSelected      = [UIImage imageNamed:@"组 1490"];

    menu.title           = @"Select3";
    menu.titleBgColor    = HexRGB(0xEEEEEE);
    menu.titleFont       = [UIFont systemFontOfSize:12];
    menu.titleColor      = HexRGB(0xAAAAAA);

//    menu.rotateIcon      = [UIImage imageNamed:@"组 1592"];
    menu.rotateIconSize  = CGSizeMake(12, 8);
    menu.rotateIconTint  = [UIColor blueColor];

    menu.optionBgColor         = [UIColor whiteColor];
    menu.optionFont            = [UIFont systemFontOfSize:12];
    menu.optionTextColor       = HexRGB(0xbbbbbb);
    menu.optionTextAlignment   = NSTextAlignmentLeft;
    menu.optionNumberOfLines   = 1;
    menu.optionLineColor       = [UIColor whiteColor];
    menu.optionIsScreenWidth     = YES;
    menu3 = menu;
    [self.view addSubview:menu3];
    
    
    
}

#pragma mark - YFDropdownMenu DataSource
- (NSUInteger)numberOfOptionsInDropdownMenu:(YFDropdownMenu *)menu{
    if (menu == navMenu || menu == menu1) {
        return _menu1OptionTitles.count;
    } else if (menu == menu3 || menu == menu2) {
        return _menu3OptionTitles.count;
    } else {
        return 0;
    }
}
- (CGFloat)dropdownMenu:(YFDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index{
    if (menu == navMenu || menu == menu1) {
        return 30;
    } else if (menu == menu2 || menu == menu3) {
        return 40;
    } else {
        return 0;
    }
}
- (NSString *)dropdownMenu:(YFDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index{
    if (menu == navMenu || menu == menu1) {
        return _menu1OptionTitles[index];
    } else if (menu == menu2) {
        return _menu3OptionTitles[index];
    }  else if (menu == menu3) {
        return _menu3OptionTitles[index];
    } else {
        return @"";
    }
}
- (UIImage *)dropdownMenu:(YFDropdownMenu *)menu iconForOptionAtIndex:(NSUInteger)index{
    if (menu == navMenu || menu == menu1) {
        return [UIImage imageNamed:_menu1OptionIcons[index]];
    } else {
        return nil;
    }
}

- (UITableViewCell *)dropdownMenu:(YFDropdownMenu *)menu cellForOptionAtIndex:(NSUInteger)index {
    if (menu == menu3) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = _menu3OptionTitles[index];
        return  cell;
    }
    
    return nil;
}
#pragma mark - YFDropdownMenu Delegate
- (void)dropdownMenu:(YFDropdownMenu *)menu didSelectOptionAtIndex:(NSUInteger)index optionTitle:(NSString *)title{
    if (menu == navMenu) {
        NSLog(@"你选择了(you selected)：navMenu，index: %ld - title: %@", index, title);
    } else if (menu == menu1) {
        NSLog(@"你选择了(you selected)：menu1，index: %ld - title: %@", index, title);
    } else if (menu == menu2) {
        NSLog(@"你选择了(you selected)：menu2，index: %ld - title: %@", index, title);
    } else if (menu == menu3) {
        NSLog(@"你选择了(you selected)：menu3，index: %ld - title: %@", index, title);
    }
}

- (void)dropdownMenuWillShow:(YFDropdownMenu *)menu{
    if (menu == navMenu) {
        NSLog(@"--将要显示(will appear)--navMenu");
    } else if (menu == menu1) {
        NSLog(@"--将要显示(will appear)--menu1");
    } else if (menu == menu2) {
        NSLog(@"--将要显示(will appear)--menu2");
    }else if (menu == menu3) {
        NSLog(@"--将要显示(will appear)--menu3");
    }
}
- (void)dropdownMenuDidShow:(YFDropdownMenu *)menu{
    if (menu == navMenu) {
        NSLog(@"--已经显示(did appear)--navMenu");
    } else if (menu == menu1) {
        NSLog(@"--已经显示(did appear)--menu1");
    } else if (menu == menu2) {
        NSLog(@"--已经显示(did appear)--menu2");
    }else if (menu == menu3) {
        NSLog(@"--已经显示(did appear)--menu3");
    }
}

- (void)dropdownMenuWillHidden:(YFDropdownMenu *)menu{
    if (menu == navMenu) {
        NSLog(@"--将要隐藏(will disappear)--navMenu");
    } else if (menu == menu1) {
        NSLog(@"--将要隐藏(will disappear)--menu1");
    } else if (menu == menu2) {
        NSLog(@"--将要隐藏(will disappear)--menu2");
    }else if (menu == menu3) {
        NSLog(@"--将要隐藏(will disappear)--menu3");
    }
}
- (void)dropdownMenuDidHidden:(YFDropdownMenu *)menu{
    if (menu == navMenu) {
        NSLog(@"--已经隐藏(did disappear)--navMenu");
    } else if (menu == menu1) {
        NSLog(@"--已经隐藏(did disappear)--menu1");
    } else if (menu == menu2) {
        NSLog(@"--已经隐藏(did disappear)--menu2");
    }else if (menu == menu3) {
        NSLog(@"--已经隐藏(did disappear)--menu3");
    }
}

- (void)dealloc {
    [navMenu removeFromSuperview];
    navMenu = nil;
}

@end
