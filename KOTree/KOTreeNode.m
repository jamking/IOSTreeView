//
//  KOTreeNode.m
//  KOTree
//
//  Created by Mac_dev on 7/02/13.
//  Copyright (c) 2013 Adam Horacek. All rights reserved.
//

#import "KOTreeNode.h"

@implementation KOTreeNode
@synthesize submersionLevel,base;
@synthesize nodeId;

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToSelectingItem:other];
}

- (BOOL)isEqualToSelectingItem:(KOTreeNode *)selectingItem {
	if (self == selectingItem)
        return YES;
	
	if ([base isEqualToString:selectingItem.base]) 
        if (submersionLevel == selectingItem.submersionLevel)
            if(nodeId == selectingItem.nodeId)
                return YES;
	
	return NO;
}

- (NSString *)description {
    return base;
}

@end
