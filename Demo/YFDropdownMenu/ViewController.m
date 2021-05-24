//
//  ViewController.m
//  YFDropdownMenu
//
//  Created by BigShow on 2021/5/19.
//

#import "ViewController.h"

#import "YFArrowButton.h"

@interface ViewController ()
/**医院*/
@property(nonatomic,strong) YFArrowButton *hospitalBtn;
/**科室类别*/
@property(nonatomic,strong) YFArrowButton *departmentBtn;
/**综合排序*/
@property(nonatomic,strong) YFArrowButton *comprehensiveBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hospitalBtn = [YFArrowButton buttonWithTitle:@"医院"];
    self.hospitalBtn.delegate = self;
    [self addSubview:self.hospitalBtn];
  
    self.departmentBtn = [YFArrowButton buttonWithTitle:@"科室类别"];
    self.hospitalBtn.delegate = self;
    [self addSubview:self.departmentBtn];
    
    self.comprehensiveBtn = [YFArrowButton buttonWithTitle:@"综合排序"];
    self.hospitalBtn.delegate = self;
    [self addSubview:self.comprehensiveBtn];
    
}


@end
