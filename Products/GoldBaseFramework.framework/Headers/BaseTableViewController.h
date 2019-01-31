//
//  BaseTableViewController.h
//  GoldBase
//
//  Created by Micker on 16/5/4.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import "BaseViewController.h"

/*!
 *  对普通的TableView的一个封装
    可以直接使用，亦可以通过presenter来结合使用
 */
@interface BaseTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>


/*!
 *	 tableview 's presenter
 */
@property (nonatomic, strong) id presenter;

/*!
 *	 tableview
 */
@property (nonatomic, strong) UITableView *tableView;

/*!
 *	 给定TableView初始化时的视图大小
 *
 *	@return CGRect
 */
- (CGRect) doGetTableViewFrame;

/*!
 *	 给定TableView初始化时style
 *
 *	@return UITableViewStyle
 */
- (UITableViewStyle) tableViewStyle;

@end
