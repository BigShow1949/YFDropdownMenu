//
//  YFViewController.m
//  YFDropdownMenu
//
//  Created by BigShow1949 on 05/27/2021.
//  Copyright (c) 2021 BigShow1949. All rights reserved.
//

#import "YFViewController.h"
#import "Demo-BaseVC.h"
#import "Demo-StoryboardVC.h"
#import "Demo-TableViewCellVC.h"
#import "Demo-LayoutByMasonryVC.h"

@interface YFViewController ()

@end

@implementation YFViewController
- (IBAction)clickDemoAddToBasePage:(id)sender {
    Demo_BaseVC *baseVC = [[Demo_BaseVC alloc] init];
    [self.navigationController pushViewController:baseVC animated:YES];
}

- (IBAction)clickDemoAddToXibPage:(id)sender {
    Demo_StoryboardVC * vc = [[UIStoryboard storyboardWithName:@"Demo" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Demo_StoryboardVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)clickDemoAddToTableViewCell:(id)sender {
    Demo_TableViewCellVC *vc = [[UIStoryboard storyboardWithName:@"Demo_TableView" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Demo_TableViewCellVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)clickDemoLayoutByMasonry:(id)sender {
    Demo_LayoutByMasonryVC *vc = [[Demo_LayoutByMasonryVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
