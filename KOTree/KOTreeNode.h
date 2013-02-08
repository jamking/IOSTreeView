//
//  KOTreeNode.h
//  KOTree
//
//  Created by Mac_dev on 7/02/13.
//  Copyright (c) 2013 Adam Horacek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KOTreeNode : NSObject

@property (nonatomic, strong) NSString * base;
@property (nonatomic) NSInteger submersionLevel;
@property (nonatomic) NSInteger nodeId;

- (BOOL)isEqualToSelectingItem:(KOTreeNode *)selectingItem ;
@end
