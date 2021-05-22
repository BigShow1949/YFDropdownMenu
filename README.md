# YFDropdownMenu
 

## 使用
* 使用cocoapods安装：               
`pod 'YFDropdownMenu'`
* 手动导入:             
    * 将 `YFDropdownMenu` 文件拖拽到工程中
    * 导入头文件`#import "YFDropdownMenu.h"`
    
    
## 属性及方法
| 属性 | 描述 |
| --- | ---
| dataSource | 数据源代理对象
| delegate | 代理对象
| --- | ---
| title | 标题，默认‘Please Select’。选择选项值后，表示当前选择的选项
| titleFont | 标题字体
| titleColor | 标题颜色
| titleAlignment | 标题对齐
| titleEdgeInsets | 标题边界内距
| titleBgColor | 标题背景颜色
| --- | ---
| rotateIcon | 下拉旋转箭头图标
| rotateIconSize | 下拉旋转箭头大小
| rotateIconMarginRight | 下拉旋转箭头右侧边距，默认7.5
| rotateIconTint | 下拉旋转箭头颜色
| --- | ---
| optionBgColor | 选项背景颜色
| optionFont | 选项字体
| optionTextColor | 选项字体颜色
| optionTextAlignment | 选项文字对齐
| optionTextMarginLeft | 选项文字左侧边距，默认15
| optionNumberOfLines | 选项文字行数，默认0（多行）
| optionIconSize | 选项图标大小，默认(15,15)
| optionIconMarginRight | 选项图标右侧边距，默认15
| optionLineColor | 选项分割线颜色
| optionLineHeight | 选项分割线粗细，默认0.5
| --- | ---
| optionsListLimitHeight | 选项列表的最大高度。超出最大高度后，选项可滚动。默认0 （当optionsListLimitHeight <= 0 时，下拉列表将显示所有选项）
| showsVerticalScrollIndicatorOfOptionsList | 是否展示选项列表的纵向滑块
| --- | ---
| animateTime | 下拉动画时间， 默认0.25

| 方法 | 描述 |
| --- | ---
| - reloadOptionsData | 刷新下拉列表数据
| - showDropDown | 显示下拉列表
| - hideDropDown | 隐藏下拉列表


| 代理方法 | 是否必选 | 描述 |
| --- | --- | ---
| *YFDropdownMenuDataSource* | --- | ---
| - numberOfOptionsInDropdownMenu: | 必选 | 获取下拉列表选项个数
| - dropdownMenu:heightForOptionAtIndex: | 必选 | 获取每个下拉选项的高度
| - dropdownMenu:titleForOptionAtIndex: | 必选 | 获取每个下拉选项的文字
| - dropdownMenu:iconForOptionAtIndex: | 可选 | 获取每个下拉选项的图标
| *YFDropdownMenuDelegate* | --- | ---
| - dropdownMenuWillShow: | 可选 | 下拉菜单将要显示
| - dropdownMenuDidShow: | 可选 | 下拉菜单已经显示
| - dropdownMenuWillHidden: | 可选 | 下拉菜单将要隐藏
| - dropdownMenuDidHidden: | 可选 | 下拉菜单已经隐藏
| - dropdownMenu:didSelectOptionAtIndex:optionTitle: | 可选 | 点击下拉列表某个选项
