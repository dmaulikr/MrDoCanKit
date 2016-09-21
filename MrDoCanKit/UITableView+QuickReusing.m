//
//  UITableView+QuickReusing.m
//  MrDoCanKit
//
//  Created by 王灿 on 1/6/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "UITableView+QuickReusing.h"

static inline NSString * StringifyIdentifier(id identifier)
{
    NSString * result = nil;
    
	if ( ![identifier isKindOfClass:NSString.class] )
	{
		result = NSStringFromClass(identifier);
	}
    else
    {
        result = identifier;
    }
	
	return result;
}

#pragma mark - UITableViewCell (QuickReusing)

@implementation UITableViewCell (QuickReusing)

+ (void)registerNibTo:(UITableView *)tableView
{
	[tableView registerNib:[self nib] forCellReuseIdentifier:NSStringFromClass(self)];
}

+ (void)registerClassTo:(UITableView *)tableView
{
	[tableView registerClass:self forCellReuseIdentifier:NSStringFromClass(self)];
}

@end

@implementation UITableViewHeaderFooterView (QuickReusing)

+ (void)registerNibTo:(UITableView *)tableView
{
	[tableView registerNib:[self nib] forHeaderFooterViewReuseIdentifier:NSStringFromClass(self)];
}

+ (void)registerClassTo:(UITableView *)tableView
{
	[tableView registerClass:self forHeaderFooterViewReuseIdentifier:NSStringFromClass(self)];
}

@end

#pragma mark - UITableView (QuickReusing)

@implementation UITableView (QuickReusing)

#pragma mark - Cell

- (void)registerNib:(NSString *)nibName
{
	[self registerNib:nibName bundle:[NSBundle mainBundle]];
}

- (void)registerNib:(NSString *)nibName identifier:(NSString *)identifier
{
	[self registerNib:nibName bundle:[NSBundle mainBundle] identifier:identifier];
}

- (void)registerNib:(NSString *)nibName bundle:(NSBundle *)bundle
{
	[self registerNib:[UINib nibWithNibName:nibName bundle:bundle] forCellReuseIdentifier:nibName];
}

- (void)registerNib:(NSString *)nibName bundle:(NSBundle *)bundle identifier:(NSString *)identifier
{
	[self registerNib:[UINib nibWithNibName:nibName bundle:bundle] forCellReuseIdentifier:identifier];
}

- (void)registerClass:(NSString *)className
{
	[self registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
}

#pragma mark - HeaderFooter

- (void)registerHeaderFooterNib:(NSString *)nibName
{
	[self registerNib:nibName bundle:[NSBundle mainBundle]];
}

- (void)registerHeaderFooterNib:(NSString *)nibName bundle:(NSBundle *)bundle
{
	[self registerNib:[UINib nibWithNibName:nibName bundle:bundle] forHeaderFooterViewReuseIdentifier:nibName];
}

- (void)registerHeaderFooterClass:(NSString *)className
{
	[self registerClass:NSClassFromString(className) forHeaderFooterViewReuseIdentifier:className];
}

#pragma mark - Dequeue

- (id)dequeue:(id)identifier
{
	return [self dequeueReusableCellWithIdentifier:StringifyIdentifier(identifier)];
}

- (id)dequeue:(id)identifier forIndexPath:(NSIndexPath *)indexPath
{
	return [self dequeueReusableCellWithIdentifier:StringifyIdentifier(identifier) forIndexPath:indexPath];
}

- (id)dequeueHeaderFooter:(id)identifier
{
	return [self dequeueReusableHeaderFooterViewWithIdentifier:StringifyIdentifier(identifier)];
}

//- (id)dequeueHeaderFooter:(Class)clazz
//{
//	return [self dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(clazz)];
//}

@end
