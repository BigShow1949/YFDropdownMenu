//
//  YFDropdownMenu.h
//  Medicine
//
//  Created by BigShow on 2021/5/21.
//


#import <UIKit/UIKit.h>

@class YFDropdownMenu;

NS_ASSUME_NONNULL_BEGIN
@protocol YFDropdownMenuDataSource <NSObject>

@required
- (NSUInteger)numberOfOptionsInDropdownMenu:(YFDropdownMenu *)menu;
- (CGFloat)dropdownMenu:(YFDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index;
- (NSString *)dropdownMenu:(YFDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index;

@optional
/** 如果自定义cell 那么titleForOptionAtIndex  iconForOptionAtIndex 就不起作用了 */
- (UITableViewCell *)dropdownMenu:(YFDropdownMenu *)menu cellForOptionAtIndex:(NSUInteger)index;
- (UIImage *)dropdownMenu:(YFDropdownMenu *)menu iconForOptionAtIndex:(NSUInteger)index;

@end


@protocol YFDropdownMenuDelegate <NSObject>
@optional
- (void)dropdownMenuWillShow:(YFDropdownMenu *)menu;    // 当下拉菜单将要显示时调用
- (void)dropdownMenuDidShow:(YFDropdownMenu *)menu;     // 当下拉菜单已经显示时调用
- (void)dropdownMenuWillHidden:(YFDropdownMenu *)menu;  // 当下拉菜单将要收起时调用
- (void)dropdownMenuDidHidden:(YFDropdownMenu *)menu;   // 当下拉菜单已经收起时调用

- (void)dropdownMenu:(YFDropdownMenu *)menu didSelectOptionAtIndex:(NSUInteger)index optionTitle:(NSString *)title; // 当选择某个选项时调用
@end




@interface YFDropdownMenu : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <YFDropdownMenuDataSource> dataSource;
@property (nonatomic, weak) id <YFDropdownMenuDelegate> delegate;

/**菜单按钮*/
//@property (nonatomic,strong,readonly) UIButton    *mainBtn;
/**尖头图标*/
@property (nonatomic,strong,readonly) UIImageView *arrowMark;
/**下拉列表*/
@property (nonatomic,strong,readonly) UITableView *optionsList;
/**容器 （动态计算高度、位置）*/
@property (nonatomic, strong,readonly) UIView      *floatView;
/**透明遮盖 （获取点击事件 隐藏选项列表）*/
@property (nonatomic, strong,readonly) UIView      *coverView;

/** 文字改变后，menu的宽度 */
@property (nonatomic,assign) CGFloat           selectedMenuWidth;


@property (nonatomic,copy)   NSString        * title;
@property (nonatomic,strong) UIColor         * titleBgColor;
@property (nonatomic,strong) UIColor         * titleBgColorSelected;
@property (nonatomic,strong) UIFont          * titleFont;
@property (nonatomic,strong) UIColor         * titleColor;
@property (nonatomic,strong) UIColor         * titleColorSelected;
@property (nonatomic,assign) CGFloat           titleMarginLeft; // default: 7.5
@property (nonatomic,assign) CGFloat           titleMarginRight; // default: 7.5
@property (nonatomic)        NSTextAlignment   titleAlignment; // default : NSTextAlignmentLeft
@property (nonatomic)        UIEdgeInsets      titleEdgeInsets; // 废弃了

///**点击列表项后 menu文字改为选中项文字 */
//@property (nonatomic,assign) BOOL              titleIsAutoChange;
///**文字改变后menu的最大宽度（仅在titleIsAutoChange为YES有效）*/
//@property (nonatomic,assign) CGFloat           titleAutoChangeMaxWidth;


@property (nonatomic,strong) UIImage         * rotateIcon;
@property (nonatomic,strong) UIImage         * rotateIconSelected;
@property (nonatomic,assign) CGSize            rotateIconSize;
@property (nonatomic,assign) CGFloat           rotateIconMarginRight; // default: 7.5
@property (nonatomic,strong) UIColor         * rotateIconTint;

@property (nonatomic,strong) UIColor         * optionBgColor;
@property (nonatomic,strong) UIFont          * optionFont;
@property (nonatomic,strong) UIColor         * optionTextColor;
@property (nonatomic)        NSTextAlignment   optionTextAlignment;
@property (nonatomic,assign) CGFloat           optionTextMarginLeft; // default: 15
@property (nonatomic)        NSInteger         optionNumberOfLines;
@property (nonatomic,assign) CGSize            optionIconSize;  // default:(15,15)
@property (nonatomic,assign) CGFloat           optionIconMarginRight; // default: 15
@property (nonatomic,strong) UIColor         * optionLineColor;
@property (nonatomic,assign) CGFloat           optionLineHeight; // default: 0.5
@property (nonatomic,assign) BOOL              optionIsScreenWidth; // 默认：NO:self的宽度  YES:屏幕宽度



/*
 选项列表高度。超出此高度后，选项可滚动；超过最大值就是最大值
 最大值：按钮底部到屏幕底部的距离
 */
@property (nonatomic,assign) CGFloat           optionsListHeight; // default: 0

@property (nonatomic,assign) BOOL              showsVerticalScrollIndicatorOfOptionsList; // default: YES


@property (nonatomic,assign) CGFloat animateTime;   // 下拉动画时间 default: 0.25


- (void)reloadOptionsData;

- (void)showDropDown; // 显示下拉菜单
- (void)hideDropDown; // 隐藏下拉菜单

@end

NS_ASSUME_NONNULL_END
