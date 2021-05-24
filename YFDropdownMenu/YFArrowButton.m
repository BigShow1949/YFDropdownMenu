//
//  YFArrowButton.m
//  Medicine
//
//  Created by BigShow on 2021/5/19.
//

#import "YFArrowButton.h"
#import "UIButton+Extension_yf.h"

@interface YFArrowButton ()<PopOverViewDelegate>

@property(nonatomic,strong) PopOverView *popView;
@property(nonatomic,assign) BOOL myState;
@property(nonatomic,copy) NSString *originTitle;

@end

@implementation YFArrowButton

- (void)showPopView {
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillShow:)]) {
        [self.delegate dropdownMenuWillShow:self]; // 将要显示回调代理
    }
    
    
    PopOverView *popOverView = [[PopOverView alloc] init];
    popOverView.delegate = self;
    popOverView.ownerView = self;
    popOverView.dataSoure = @[@"不限",@"小户型",@"一室户",@"二室户",@"三室户",@"四室户",@"别墅",@"其他"];
    self.popView = popOverView;
    
    [self.popView show];
    
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self]; // 已经显示回调代理
    }
}

- (void)hidePopView {
    // call delegate
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillHidden:)]) {
        [self.delegate dropdownMenuWillHidden:self]; // 将要隐藏回调代理
    }
    
    [self.popView hide];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidHidden:)]) {
        [self.delegate dropdownMenuDidHidden:self]; // 已经隐藏回调代理
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setImage:[UIImage imageNamed:@"btn-_down@2x"] forState:UIControlStateNormal];
//        [self setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateSelected];
        [self setTitleColor:HexRGB(0xAAAAAA) forState:UIControlStateNormal];
        self.backgroundColor = HexRGB(0xEEEEEE);
        self.titleLabel.font = kFontRegularSize(15);
        self.layer.cornerRadius = 3;
        self.selected = NO;
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _myState = NO;
        
    }
    return self;
}

+ (YFArrowButton *)buttonWithTitle:(NSString *)title {
    YFArrowButton *btn = [[YFArrowButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.originTitle = title;
    return btn;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutButtonWithEdgeInsetsStyle:LLButtonStyleTextLeft imageTitleSpace:11];
}

- (void)arrowAnimation {
    
    [UIView animateWithDuration:0.25 animations:^{
        if (CGAffineTransformIsIdentity(self.imageView.transform)) {
            self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }else{
            self.imageView.transform = CGAffineTransformIdentity;
        }
    }];
}

-(void)btnClick:(YFArrowButton*)sender {
    NSLog(@"sender.selected == %d", sender.selected);
    [self arrowAnimation];

//    sender.selected = !sender.selected; // 状态没有变？？？？？？？？
    self.myState = !self.myState;
    if (self.myState) {
        [self showPopView];
    }else {
        [self hidePopView];
    }
}


-(void)popOverView:(PopOverView*)popOverView didSelectItem:(id)item {
    
    [self setTitle:(NSString *)item forState:UIControlStateNormal];

    self.myState = NO;
    [self hidePopView];
    [self arrowAnimation];

    if ([self.delegate respondsToSelector:@selector(arrowButton:popView:didSelectItem:)]) {
        [self.delegate arrowButton:self popView:popOverView didSelectItem:item];
    }
}
@end
