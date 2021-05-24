//
//  YFArrowButton.h
//  Medicine
//
//  Created by BigShow on 2021/5/19.
//

#import <UIKit/UIKit.h>
#import "PopOverView.h"
NS_ASSUME_NONNULL_BEGIN

@class YFArrowButton;
@protocol YFArrowButtonDelegate <NSObject>

@required
-(void)arrowButton:(YFArrowButton *)arrowButton popView:(PopOverView*)popOverView didSelectItem:(id)item;

@optional
- (void)dropdownMenuWillShow:(YFArrowButton *)button;    // 当下拉菜单将要显示时调用
- (void)dropdownMenuDidShow:(YFArrowButton *)button;     // 当下拉菜单已经显示时调用
- (void)dropdownMenuWillHidden:(YFArrowButton *)button;  // 当下拉菜单将要收起时调用
- (void)dropdownMenuDidHidden:(YFArrowButton *)button;   // 当下拉菜单已经收起时调用

@end

@interface YFArrowButton : UIButton

+ (YFArrowButton *)buttonWithTitle:(NSString *)title;

@property(nonatomic,weak)id<YFArrowButtonDelegate> delegate;

- (void)showPopView;
- (void)hidePopView;

@end

NS_ASSUME_NONNULL_END
