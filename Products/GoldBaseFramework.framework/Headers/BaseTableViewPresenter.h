//
//  BaseTableViewPresenter.h
//  GoldBaseFramework
//
//  Created by Micker on 16/5/23.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseViewPresenter.h"

/*!
 *	实现了UITableView的delegate 和 datasource的呈现类
 */
@interface BaseTableViewPresenter : BaseViewPresenter<UITableViewDelegate, UITableViewDataSource>

/*!
*/
@property (nonatomic, weak) UITableView         *tableView;

/*!
 */
@property (nonatomic, weak) UIViewController    *controller;

/*!
 */
@property (nonatomic, strong) NSMutableArray    *contents;

/*!
 *	使用ViewController来初始化当前对象
 *
 *	@param controller	UIViewController
 *
 *	@return return value of BaseTableViewPresenter
 */
- (instancetype)initWithController:(UIViewController *) controller;

/*!
 *	使用UITableView ,ViewController来初始化当前对象
 *
 *	@param tableView	UITableView
 *	@param controller	UIViewController
 *
 *	@return return value of BaseTableViewPresenter
 */
- (instancetype)initWithTableView:(UITableView *)tableView controller:(UIViewController *) controller;

/*!
 *	初始化列表之后，定制化TableView，如注册Cell，改变大小...
 */
- (void) setupTableView;

/*!
 *	给当前对象进行赋值，在此使用的弱对象， 注意此content与属性中的contents的区别
 *  content为当前对象的值，而contents是为列表的值，具体的子类应根据content来设置contents
 *
 *	@param content  id
 */
- (void) doSetContentData:(id) content;

@end
