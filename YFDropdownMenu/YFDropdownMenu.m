//
//  YFDropdownMenu.m
//  Medicine
//
//  Created by BigShow on 2021/5/21.
//


#import "YFDropdownMenu.h"

@interface YFDropdownMenu() <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

/**菜单按钮*/
@property (nonatomic, strong) UILabel     *mainLabel;
/**尖头图标*/
@property (nonatomic, strong) UIImageView *arrowMark;
/**下拉列表*/
@property (nonatomic, strong) UITableView *optionsList;
/**容器 （动态计算高度、位置）*/
@property (nonatomic, strong) UIView      *floatView;
/**透明遮盖 （获取点击事件 隐藏选项列表）*/
@property (nonatomic, strong) UIView      *coverView;

@property (nonatomic,assign) BOOL isOpened;

@end



@implementation YFDropdownMenu

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initProperties];
        [self initViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initProperties];
    [self initViews];
}

- (void)layoutSubviews {
    if (self.isOpened) return;

    CGFloat width  = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    [_floatView setFrame:CGRectMake(0, 0, width, height)];
    // left + title + right + img + right
    [_arrowMark setFrame:CGRectMake(width -self.rotateIconMarginRight -self.rotateIconSize.width, (height -self.rotateIconSize.height)/2, self.rotateIconSize.width, self.rotateIconSize.height)];
    [_mainLabel setFrame:CGRectMake(_titleMarginLeft, 0, width - _titleMarginLeft - _rotateIconSize.width - _titleMarginRight - _rotateIconMarginRight, height)];
    [_optionsList setFrame:CGRectMake(0, height, width, _optionsList.frame.size.height)];
}

#pragma mark - Init
- (void)initProperties{
    _title                   = @"Please Select";
    _titleBgColor            = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    _titleFont               = [UIFont boldSystemFontOfSize:15];
    _titleColor              = [UIColor whiteColor];
    _titleMarginLeft         = 7.5;
    _titleMarginRight        = 7.5;
    _titleAlignment          = NSTextAlignmentLeft;
    _selectedMenuWidth       = 0;
    _selectedLastestMenuWidth= 0;
    _selectedMenuMaxWidth    = 0;

    _rotateIcon             = nil;
    _rotateIconSize         = CGSizeMake(15, 15);
    _rotateIconMarginRight  = 7.5;
    _rotateIconTint         = [UIColor blackColor];

    _optionBgColor          = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    _optionFont             = [UIFont systemFontOfSize:13];
    _optionTextColor        = [UIColor blackColor];
    _optionTextAlignment    = NSTextAlignmentCenter;
    _optionTextMarginLeft   = 15;
    _optionNumberOfLines    = 0;
    _optionIconSize         = CGSizeMake(0, 0);
    _optionIconMarginRight  = 15;
    _optionLineColor        = [UIColor whiteColor];
    _optionLineHeight       = 0.5f;
    _optionIsScreenWidth    = NO;

    _animateTime            = 0.25f;

    _optionsListHeight = 0;

    _isOpened               = NO;
}

- (void)initViews{
    self.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainClick:)];
    [self addGestureRecognizer:tapGesture];
    
    _floatView = [[UIView alloc] initWithFrame:self.bounds];
    _floatView.layer.masksToBounds = YES;
    [self addSubview:_floatView];
    
    // 主按钮 显示在界面上的点击按钮
    _mainLabel = [[UILabel alloc] init];
    _mainLabel.textAlignment = NSTextAlignmentLeft;
    [_floatView addSubview:_mainLabel];
    
    // 旋转尖头
    _arrowMark = [[UIImageView alloc] init];
    [_arrowMark setTintColor:self.rotateIconTint];
    [_floatView addSubview:_arrowMark];
    
    // 下拉列表TableView
    _optionsList = [[UITableView alloc] init];
    _optionsList.delegate       = self;
    _optionsList.dataSource     = self;
    _optionsList.separatorStyle = UITableViewCellSeparatorStyleNone;
    _optionsList.scrollEnabled  = NO;
    [_floatView addSubview:_optionsList];
}

#pragma mark - Action Methods
- (void)reloadOptionsData{
    [self.optionsList reloadData];
}

- (void)mainClick:(UITapGestureRecognizer *)tap {
    if (self.isOpened) {
        [self hideDropDown];
    }else {
        [self showDropDown];
    }
}

- (void)clickmainLabel:(UIButton *)button{
    if(button.selected == NO) {
        [self showDropDown];
    }else {
        [self hideDropDown];
    }
}

- (void)showDropDown{   /* 显示下拉列表 */
    self.isOpened = YES;
    
    // 变更menu图层
    CGPoint newPosition = [self getScreenPosition];
    _floatView.frame = CGRectMake(newPosition.x, newPosition.y, _floatView.bounds.size.width, _floatView.bounds.size.height);
    _floatView.layer.borderColor  = self.layer.borderColor;
    _floatView.layer.borderWidth  = self.layer.borderWidth;
    _floatView.layer.cornerRadius = self.layer.cornerRadius;
    [self.coverView addSubview:_floatView];
    
    if(self.optionIsScreenWidth) {
        _optionsList.frame = CGRectMake(0, newPosition.y+_mainLabel.frame.size.height, [[UIScreen mainScreen] bounds].size.width, _optionsList.bounds.size.height);
        [self.coverView addSubview:_optionsList];
    }
    
    // call delegate
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillShow:)]) {
        [self.delegate dropdownMenuWillShow:self]; // 将要显示回调代理
    }
    
    // 刷新下拉列表数据
    [self reloadOptionsData];
    
    // 菜单高度计算
    CGFloat listMaxHeight = [self getCurrentKeyWindow].frame.size.height  - newPosition.y - _mainLabel.frame.size.height;
    CGFloat listHeight = 0;
    if (self.optionsListHeight <= 0) { // 当未设置下拉菜单最小展示高度
        NSUInteger count = [self.dataSource numberOfOptionsInDropdownMenu:self];
        for (int i = 0; i < count; i++) {
            CGFloat cHeight = [self.dataSource dropdownMenu:self heightForOptionAtIndex:i];
            listHeight += cHeight;
        }
        if (listHeight > listMaxHeight) {
            _optionsList.scrollEnabled = YES;
            listHeight = listMaxHeight;
        }else {
            _optionsList.scrollEnabled =  NO;
        }
    } else {
        listHeight = self.optionsListHeight;
        _optionsList.scrollEnabled = YES;
    }
    
    // 执行展开动画
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.animateTime animations:^{
        UIView *floatView     = weakSelf.floatView;
        UILabel *mainLabel    = weakSelf.mainLabel;
        UITableView *listView = weakSelf.optionsList;
        
        floatView.frame = CGRectMake(floatView.frame.origin.x, floatView.frame.origin.y, floatView.frame.size.width, mainLabel.frame.size.height + listHeight);
        weakSelf.arrowMark.transform = CGAffineTransformMakeRotation(M_PI);
        listView.frame = CGRectMake(listView.frame.origin.x, listView.frame.origin.y, listView.frame.size.width, listHeight);
        
    }completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
            [self.delegate dropdownMenuDidShow:self]; // 已经显示回调代理
        }
    }];
}


- (void)hideDropDown{  // 隐藏下拉列表
    // call delegate
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillHidden:)]) {
        [self.delegate dropdownMenuWillHidden:self]; // 将要隐藏回调代理
    }

    // 执行关闭动画
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.animateTime animations:^{
        UIView *floatView  = weakSelf.floatView;
        UILabel *mainLabel = weakSelf.mainLabel;
        weakSelf.arrowMark.transform = CGAffineTransformIdentity;
        weakSelf.floatView.frame  = CGRectMake(floatView.frame.origin.x, floatView.frame.origin.y, floatView.frame.size.width, mainLabel.frame.size.height);
        
    }completion:^(BOOL finished) {
        weakSelf.optionsList.frame = CGRectMake(weakSelf.optionsList.frame.origin.x, weakSelf.optionsList.frame.origin.y, weakSelf.frame.size.width, 0);
        
        // 变更menu图层
        weakSelf.floatView.frame = weakSelf.floatView.bounds;
        [self addSubview:weakSelf.floatView];
        [weakSelf.coverView removeFromSuperview];
        weakSelf.coverView = nil;
        
        self.isOpened = NO;
        
        if ([self.delegate respondsToSelector:@selector(dropdownMenuDidHidden:)]) {
            [self.delegate dropdownMenuDidHidden:self]; // 已经隐藏回调代理
        }
    }];
}

#pragma mark - Utility Methods
- (CGPoint)getScreenPosition {
    return [self.superview convertPoint:self.frame.origin toView:[self getCurrentKeyWindow]];
}

- (UIWindow *)getCurrentKeyWindow {
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        return window;
                        break;
                    }
                }
            }
        }
    }
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfOptionsInDropdownMenu:self];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource dropdownMenu:self heightForOptionAtIndex:indexPath.row];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.dataSource respondsToSelector:@selector(dropdownMenu:cellForOptionAtIndex:)]) {
        UITableViewCell *cell = [self.dataSource dropdownMenu:self cellForOptionAtIndex:indexPath.row];
        if (cell) return cell;
    }
    
    static NSString *CellIdentifier = @"MenuOptionListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //---------------------------下拉选项样式，可在此处自定义-------------------------
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = self.optionBgColor;
        
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font          = self.optionFont;
        titleLabel.textColor     = self.optionTextColor;
        titleLabel.numberOfLines = self.optionNumberOfLines;
        titleLabel.textAlignment = self.optionTextAlignment;
        titleLabel.tag           = 999;
        [cell addSubview:titleLabel];
        
        UIImageView * icon = [[UIImageView alloc] init];
        icon.tag = 888;
        [cell addSubview:icon];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.optionLineHeight)];
        line.backgroundColor = self.optionLineColor;
        line.tag             = 777;
        [cell addSubview:line];
        //---------------------------------------------------------------------------
    }
    CGFloat cHeight = [self.dataSource dropdownMenu:self heightForOptionAtIndex:indexPath.row];
    
    UILabel * titleLabel = [cell viewWithTag:999];
    
    titleLabel.text  = [self.dataSource dropdownMenu:self titleForOptionAtIndex:indexPath.row];;
    titleLabel.frame = CGRectMake(self.optionTextMarginLeft, 0, self.optionsList.frame.size.width - self.optionTextMarginLeft -self.optionIconSize.width -self.optionIconMarginRight, cHeight);
    
    UIImageView * icon = [cell viewWithTag:888];
    if ([self.dataSource respondsToSelector:@selector(dropdownMenu:iconForOptionAtIndex:)]){
        icon.image = [self.dataSource dropdownMenu:self iconForOptionAtIndex:indexPath.row];
    }
    icon.frame = CGRectMake(self.optionsList.frame.size.width -self.optionIconSize.width -self.optionIconMarginRight, (cHeight - self.optionIconSize.height)/2, self.optionIconSize.width, self.optionIconSize.height);
    
    UIView *line = [cell viewWithTag:777];
    line.frame           = CGRectMake(0, 0, self.optionsList.frame.size.width, self.optionLineHeight);
    line.backgroundColor = self.optionLineColor;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel * titleLabel = [cell viewWithTag:999];
    self.title = titleLabel.text;
    // 重新计算新的宽度
    // left + title + right+ arror + right
    CGFloat titleWidth = [self.title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.mainLabel.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.mainLabel.font} context:nil].size.width;
    
    if (!self.selectedLastestMenuWidth) {
        self.selectedLastestMenuWidth = self.frame.size.width;
    }else {
        _selectedLastestMenuWidth = self.selectedMenuWidth;
    }

    _selectedMenuWidth = _titleMarginLeft + titleWidth + _titleMarginRight + _rotateIconSize.width + _rotateIconMarginRight;

    if (_selectedMenuMaxWidth) {
        _selectedMenuWidth = MIN(self.selectedMenuWidth, self.selectedMenuMaxWidth);
    }
    if ([self.delegate respondsToSelector:@selector(dropdownMenu:didSelectOptionAtIndex:optionTitle:)]) {
        [self.delegate dropdownMenu:self didSelectOptionAtIndex:indexPath.row optionTitle:titleLabel.text];
    }
    [self hideDropDown];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
   if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
       return NO;
   }
   return  YES;
}


#pragma mark - Get Methods
- (BOOL)showsVerticalScrollIndicatorOfOptionsList {
    return _optionsList.showsVerticalScrollIndicator;
}

- (UIView *)coverView {
    UIWindow *window = [self getCurrentKeyWindow];
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, window.bounds.size.width, window.bounds.size.height)];
        _coverView.backgroundColor = [UIColor clearColor];
        [window addSubview:_coverView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDropDown)];
        tap.delegate = self;
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

#pragma mark - Set Methods
- (void)setIsOpened:(BOOL)isOpened {
    _isOpened = isOpened;
    if (self.titleBgColorSelected) {
        self.floatView.backgroundColor = isOpened?self.titleBgColorSelected:self.titleBgColor;
    }
    if (self.titleColorSelected) {
        self.mainLabel.textColor = isOpened?self.titleColorSelected:self.titleColor;
    }
    if (self.rotateIconSelected) {
        [self.arrowMark setImage:isOpened?self.rotateIconSelected:self.rotateIcon];
    }
}


- (void)setRotateIcon:(UIImage *)rotateIcon {
    _rotateIcon = rotateIcon;
    [self.arrowMark setImage:rotateIcon];
}
- (void)setRotateIconSize:(CGSize)rotateIconSize {
    _rotateIconSize = rotateIconSize;
    [self.arrowMark setFrame:CGRectMake(self.mainLabel.bounds.size.width -self.rotateIconMarginRight -rotateIconSize.width, (self.mainLabel.bounds.size.height -rotateIconSize.height)/2, rotateIconSize.width, rotateIconSize.height)];
}
- (void)setRotateIconMarginRight:(CGFloat)rotateIconMarginRight {
    _rotateIconMarginRight = rotateIconMarginRight;
    [self.arrowMark setFrame:CGRectMake(self.mainLabel.bounds.size.width -rotateIconMarginRight -self.rotateIconSize.width, (self.mainLabel.bounds.size.height -self.rotateIconSize.height)/2, self.rotateIconSize.width, self.rotateIconSize.height)];
}
- (void)setRotateIconTint:(UIColor *)rotateIconTint {
    _rotateIconTint = rotateIconTint;
    self.arrowMark.tintColor = rotateIconTint;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    self.mainLabel.text = title;
}
- (void)setTitleBgColor:(UIColor *)titleBgColor{
    _titleBgColor = titleBgColor;
    self.floatView.backgroundColor = titleBgColor;
}
- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    self.mainLabel.font = titleFont;
}
- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    self.mainLabel.textColor = titleColor;
}
- (void)setTitleAlignment:(NSTextAlignment)titleAlignment{
    _titleAlignment = titleAlignment;
    self.mainLabel.textAlignment = titleAlignment;
}

- (void)setShowsVerticalScrollIndicatorOfOptionsList:(BOOL)showsVerticalScrollIndicatorOfOptionsList {
    _optionsList.showsVerticalScrollIndicator = showsVerticalScrollIndicatorOfOptionsList;
}


@end
