//
//  UICollectionView+QuickReusing.m
//  MrDoCanKit
//
//  Created by 王灿 on 1/6/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "UICollectionView+QuickReusing.h"

static inline NSString * StringifyIdentifier(id identifier)
{
	if ( ![identifier isKindOfClass:NSString.class] )
	{
		identifier = NSStringFromClass(identifier);
	}
	
	return identifier;
}

#pragma mark- UICollectionReusableView (QuickReusing)

@implementation UICollectionReusableView (QuickReusing)

#pragma mark - Cell

+ (void)registerNibTo:(UICollectionView *)collectionView
{
	[collectionView registerNib:[self nib] forCellWithReuseIdentifier:NSStringFromClass(self)];
}

+ (void)registerClassTo:(UICollectionView *)collectionView
{
	[collectionView registerClass:self forCellWithReuseIdentifier:NSStringFromClass(self)];
}

#pragma mark - SupplementaryView

+ (void)registerNibTo:(UICollectionView *)collectionView kind:(NSString *)kind
{
	[collectionView registerNib:[self nib] forSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(self)];
}

+ (void)registerClassTo:(UICollectionView *)collectionView kind:(NSString *)kind
{
	[collectionView registerClass:self forSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(self)];
}

@end

#pragma mark - UICollectionView (QuickReusing)

@implementation UICollectionView (QuickReusing)

#pragma mark - Cell

- (void)registerNib:(NSString *)nibName
{
	[self registerNib:nibName bundle:[NSBundle mainBundle]];
}

- (void)registerNib:(NSString *)nibName bundle:(NSBundle *)bundle
{
	[self registerNib:[UINib nibWithNibName:nibName bundle:bundle] forCellWithReuseIdentifier:nibName];
}

- (void)registerClass:(NSString *)className
{
	[self registerClass:NSClassFromString(className) forCellWithReuseIdentifier:className];
}

#pragma mark - SupplementaryView

- (void)registerNib:(NSString *)nibName kind:(NSString *)kind
{
	[self registerNib:nibName bundle:[NSBundle mainBundle] kind:kind];
}

- (void)registerNib:(NSString *)nibName bundle:(NSBundle *)bundle kind:(NSString *)kind
{
	[self registerNib:[UINib nibWithNibName:nibName bundle:bundle] forSupplementaryViewOfKind:kind withReuseIdentifier:nibName];
}

- (void)registerClass:(NSString *)className kind:(NSString *)kind
{
	[self registerClass:NSClassFromString(className) forSupplementaryViewOfKind:kind withReuseIdentifier:className];
}

#pragma mark - Dequeue

- (id)dequeue:(id)identifier forIndexPath:(NSIndexPath *)indexPath
{
	return [self dequeueReusableCellWithReuseIdentifier:StringifyIdentifier(identifier) forIndexPath:indexPath];
}

- (id)dequeue:(id)identifier kind:(NSString *)kind forIndexPath:(NSIndexPath *)indexPath
{
	return [self dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:StringifyIdentifier(identifier) forIndexPath:indexPath];
}

@end
