//
// Modified by Kun Zhang on 08/02/2013,2 days before Chinese New Year.
//
// Store tree nodes in an array(pre-order) so it is easier to build a tree dynamicly.
// Don't need numberOfSubitems parentSelectingItem ancestorSelectingItems any more.We can get these items from array.
// Show +/- 
// Fix: cellForRowAtIndexPath will return nil if invisible which crashes with a big tree.Use self.treeNodes instead,
//

//
//  KOSelectingViewController.m
//  Kodiak
//
//  Created by Adam Horacek on 18.04.12.
//  Copyright (c) 2012 Adam Horacek, Kuba Brecka
//
//  Website: http://www.becomekodiak.com/
//  github: http://github.com/adamhoracek/KOTree
//	Twitter: http://twitter.com/becomekodiak
//  Mail: adam@becomekodiak.com, kuba@becomekodiak.com
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "KOTreeViewController.h"
#import "KOTreeTableViewCell.h"

@implementation KOTreeViewController 

@synthesize treeNodeTableView;
@synthesize treeNodes;
@synthesize selectedTreeNodes;
@synthesize node0, node1, node1_1, node1_2, node1_2_1, node2, node3;
@synthesize allNodes;

- (void) initialize{
    //int array[] = {0,1,2,2,2,2,2,3,3,2,2,2,2,3,2,1,2,3,3,2,1,2,3,3,3,2,3,3,2,3,3,3,2,3,2,3,2,3,2,3,2,3,2,3};    
    int array[] = {0,1,2,2,2,2,2,2,0,1,2,2,2,2,2,3,3,2,2,2,2,3,2,1,2,3,3,2,1,2,3,3,3,2,3,3,2,3,3,3,2,3,2,3,2,3,2,3,2,3,2,3};
    
    NSMutableArray *depths = [NSMutableArray array];
    
    for (NSInteger i = 0; i < sizeof(array)/sizeof(int) ; i++)
        [depths addObject:[NSNumber numberWithInteger:array[i]]];
    
//    NSArray * depths = [[NSArray alloc]initWithObjects:0,1,2,2,2,2,2,2,0,1,2,2,2,2,2,3,3,2,2,2,2,3,2,1,2,3,3,2,1,2,3,3,3,2,3,3,2,3,3,3,2,3,2,3,2,3,2,3,2,3,2,3, nil];
   
//    @"BUILD(Building Description)",
//    @"STRUCT(Structure)",
//    @"Domestic",
//    @"Commercial",
//    @"Apartment",
//    @"Unit",
//    @"Flat",
//    @"Duplex",
    NSArray * descs = [[NSArray alloc]initWithObjects:
                           @"BUILD(Building Description)",
                           @"STRUCT(Structure)",
                           @"Domestic",
                           @"Commercial",
                           @"Apartment",
                           @"Unit",
                           @"Flat",
                           @"Duplex",
                       @"INSPCT(Areas Inspected/Not Inspected)",
                       @"INSPCT(Areas Inspected)",
                       @"Subfloor",
                       @"Interior",
                       @"Roof Void",
                       @"Garage",
                       @"Out Building",
                       @"Toilet",
                       @"Laundry",
                       @"Grounds",
                       @"Fences",
                       @"Exterior",
                       @"Other",
                       @"Details",
                       @"Station",
                       @"OTHINS(Other areas inspected)",
                       @"Yes",
                       @"Shed",
                       @"Ext Laundry",
                       @"No",
                       @"ACCESS(Areas NOT inspected and/or areas to which REASONABLE ACCESS for Inspection was NOT available and reason why?)",
                       @"Subfloor",
                       @"No Access",
                       @"Blocked",
                       @"Stored Goods",
                       @"Exterior",
                       @"Stored Goods",
                       @"Foliage",
                       @"Interior",
                       @"Stored Goods",
                       @"Furniture",
                       @"Wall Hangings",
                       @"Roof Void",
                       @"due to",
                       @"Garage",
                       @"due to",
                       @"Out Buildings",
                       @"due to",
                       @"Fences",
                       @"due to",
                       @"Edge slab",
                       @"due to",
                       @"Carport",
                       @"due to"
                        , nil];
         
    
    node0 = [[KOTreeNode alloc]init];
	[node0 setBase:@"Item 0"];
    [node0 setSubmersionLevel:0];
    [node0 setNodeId:0];
    
    node1 = [[KOTreeNode alloc]init];
	[node1 setBase:@"Item 1"];
    [node1 setSubmersionLevel:1];
    [node1 setNodeId:1];
    
    
    node1_1 = [[KOTreeNode alloc] init];
	[node1_1 setBase:@"Item 1 1"];
    [node1_1 setSubmersionLevel:2];
    [node1_1 setNodeId:2];

    
    node1_2 = [[KOTreeNode alloc] init];
	[node1_2 setBase:@"Item 1 2"];
    [node1_2 setSubmersionLevel:2];
    [node1_2 setNodeId:3];

    
    node1_2_1 = [[KOTreeNode alloc] init];
	[node1_2_1 setBase:@"Item 1 2 1"];
    [node1_2_1 setSubmersionLevel:3];
    [node1_2_1 setNodeId:4];

    
    node2 = [[KOTreeNode alloc]init];
	[node2 setBase:@"Item 2"];
    [node2 setSubmersionLevel:1];
    [node2 setNodeId:5];

    
    node3 = [[KOTreeNode alloc]init];
	[node3 setBase:@"Item 3"];
    [node3 setSubmersionLevel:1];
    [node3 setNodeId:6];

    
    allNodes = [NSMutableArray array];
    //allNodes = [[NSMutableArray alloc]initWithObjects:node0,node1,node1_1,node1_2,node1_2_1,node2,node3, nil];
    
    
    for(int i = 0 ; i < depths.count ; i++){
        KOTreeNode * node = [[KOTreeNode alloc]init];
        [node setBase:descs[i]];
        [node setSubmersionLevel:((NSNumber *)depths[i]).intValue];
        [node setNodeId:i];
        [allNodes addObject:node];
    }
}

- (NSMutableArray *)getFirstLevel:(NSMutableArray *)nodes{
    NSMutableArray * array = [NSMutableArray array];
    for (KOTreeNode *node in nodes) {
        if(node.submersionLevel == 0){
            [array addObject:node];
        }
    }
    return array;
}

- (int) getChildrenCount:(NSMutableArray *)nodes ofNode:(KOTreeNode *)node{
    int count = 0;
    NSInteger pos = [nodes indexOfObject:node];
    for (int i = pos+1 ; i < nodes.count && node.submersionLevel < ((KOTreeNode *)nodes[i]).submersionLevel ; i++) {
        if(((KOTreeNode *)nodes[i]).submersionLevel == node.submersionLevel + 1){
            count++;
        }
    }
    return count;
}

- (NSMutableArray *)getChildren:(NSMutableArray *)nodes ofNode:(KOTreeNode *)node{
    NSMutableArray * array = [NSMutableArray array];
    NSInteger pos = [nodes indexOfObject:node];
    for (int i = pos+1 ; i < nodes.count && node.submersionLevel < ((KOTreeNode *)nodes[i]).submersionLevel ; i++) {
        if(((KOTreeNode *)nodes[i]).submersionLevel == node.submersionLevel + 1){
            [array addObject:nodes[i]];
        }
    }
    return array;
}

- (int) isExpand:(NSMutableArray *)nodes ofNode:(KOTreeNode *)node showNodes:(NSMutableArray *)showNodes
{
    NSMutableArray * childrenNodes = [self getChildren:nodes ofNode:node];
    if(childrenNodes != nil && childrenNodes.count > 0) {
        for(KOTreeNode * childNode in childrenNodes){
            for (KOTreeNode * item in showNodes) {
                if([childNode isEqualToSelectingItem:item]){
                    return 1; //expand
                }
            }
        }
        return -1;
    }
    return 0; //no children
}


- (NSMutableArray *)getOffsprings:(NSMutableArray *)nodes ofNode:(KOTreeNode *)node saveToArray:array{
     NSInteger pos = [nodes indexOfObject:node];
    for (int i = pos+1 ; i < nodes.count && node.submersionLevel < ((KOTreeNode *)nodes[i]).submersionLevel ; i++) {
        [array addObject:nodes[i]];         
    }
    return array;
} 

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initialize];
    self.selectedTreeNodes = [NSMutableArray array];
    
    self.treeNodes = [self getFirstLevel:allNodes];
    
    treeNodeTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	[treeNodeTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
	[treeNodeTableView setBackgroundColor:[UIColor colorWithRed:1 green:0.976 blue:0.957 alpha:1] /*#fff9f4*/];
	[treeNodeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[treeNodeTableView setRowHeight:65.0f];
	[treeNodeTableView setDelegate:(id<UITableViewDelegate>)self];
	[treeNodeTableView setDataSource:(id<UITableViewDataSource>)self];
    [self.view addSubview:treeNodeTableView]; 
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
//	[[[self treeNodeTableView] delegate] tableView:treeNodeTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return [self.treeNodes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	KOTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectingTableViewCell"];
	if (!cell)
		cell = [[KOTreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectingTableViewCell"];
    
    KOTreeNode *treeNode = [self.treeNodes objectAtIndex:indexPath.row];

    cell.treeNode = treeNode;
    
    [cell.iconButton setSelected:[self.selectedTreeNodes containsObject:cell.treeNode]];
    
    int count = [self getChildrenCount:allNodes ofNode:treeNode];
    NSString *label = count > 0 ? [NSString stringWithFormat:@"%d",count] : @"-";
  	[cell.countLabel setText:label];
      
 	[cell.titleTextField setText:[treeNode base]];
	[cell.titleTextField sizeToFit];
	
	[cell setDelegate:(id<KOTreeTableViewCellDelegate>)self];    
	[cell setLevel:[treeNode submersionLevel]];
    
    int status = [self isExpand:allNodes ofNode:treeNode showNodes:self.treeNodes];
    if(status == -1 ){
        [cell.iconButton setHidden:NO];
 		[cell.iconButton setSelected:YES];
    }
    else if(status == 1 ){
        [cell.iconButton setHidden:NO];
        [cell.iconButton setSelected:NO];
    }
    else {
        [cell.iconButton setHidden:YES];
    }
	return cell;
}

//- (void)selectingItemsToDelete:(KOTreeItem *)selItems saveToArray:(NSMutableArray *)deleteSelectingItems{
//	for (KOTreeItem *obj in selItems.ancestorSelectingItems) {
//		[self selectingItemsToDelete:obj saveToArray:deleteSelectingItems];
//	}
//	
//	[deleteSelectingItems addObject:selItems];
//}

- (NSMutableArray *)removeIndexPathForTreeItems:(NSMutableArray *)treeItemsToRemove {
	NSMutableArray *result = [NSMutableArray array];
    
    [treeNodeTableView visibleCells];
	
	for (NSInteger i = 0; i < [treeNodeTableView numberOfRowsInSection:0]; ++i) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];       
        
        KOTreeNode *treeNode = [self.treeNodes objectAtIndex:i];
        //ken:use self.treeNodes here because cellForRowAtIndexPath will return nil if invisible.
//		KOTreeTableViewCell *cell = (KOTreeTableViewCell *)[treeNodeTableView cellForRowAtIndexPath:indexPath]; 

		for (KOTreeNode *tmpTreeItem in treeItemsToRemove) {
			if ([treeNode isEqualToSelectingItem:tmpTreeItem])
				[result addObject:indexPath];
		}
	}	
	
	return result;
}
- (void)tableViewAction:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath {
	
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self tableViewAction:tableView withIndexPath:indexPath];
	
	KOTreeTableViewCell *cell = (KOTreeTableViewCell *)[treeNodeTableView cellForRowAtIndexPath:indexPath];
    
    NSInteger insertTreeItemIndex = [self.treeNodes indexOfObject:cell.treeNode];
	NSMutableArray *insertIndexPaths = [NSMutableArray array];
	NSMutableArray *insertselectingItems = [self getChildren:self.allNodes ofNode:cell.treeNode];     
	 	
	NSMutableArray *removeIndexPaths = [NSMutableArray array];
	NSMutableArray *treeItemsToRemove = [NSMutableArray array];
    
    for (KOTreeNode *tmpTreeItem in insertselectingItems) {
		//[tmpTreeItem setPath:[cell.treeItem.path stringByAppendingPathComponent:cell.treeItem.base]];
		//[tmpTreeItem setParentSelectingItem:cell.treeItem];
		
		//[cell.treeItem.ancestorSelectingItems removeAllObjects];
		//[cell.treeItem.ancestorSelectingItems addObjectsFromArray:insertselectingItems];
		
		insertTreeItemIndex++;
		
		BOOL contains = NO;
		
		for (KOTreeNode *tmp2TreeItem in self.treeNodes) {
			if ([tmp2TreeItem isEqualToSelectingItem:tmpTreeItem]) {
				contains = YES;
				
				//[self selectingItemsToDelete:tmp2TreeItem saveToArray:treeItemsToRemove];
                
                //if(treeItemsToRemove.count != 0){
                //    treeItemsToRemove = [NSMutableArray array];
                //}
                [treeItemsToRemove addObject:tmp2TreeItem];
                [self getOffsprings:allNodes ofNode:tmp2TreeItem saveToArray:treeItemsToRemove];
				
				removeIndexPaths = [self removeIndexPathForTreeItems:(NSMutableArray *)treeItemsToRemove];
			}
		}
		

		
		if (!contains) {
			//[tmpTreeItem setSubmersionLevel:tmpTreeItem.submersionLevel];
			
			[self.treeNodes insertObject:tmpTreeItem atIndex:insertTreeItemIndex];
			
			NSIndexPath *indexPth = [NSIndexPath indexPathForRow:insertTreeItemIndex inSection:0];
			[insertIndexPaths addObject:indexPth];
		}
	}
    
    for (KOTreeNode *tmpTreeItem in insertselectingItems) {
        for (KOTreeNode *tmp2TreeItem in treeItemsToRemove) {
			[self.treeNodes removeObject:tmp2TreeItem];
			
			for (KOTreeNode *tmp3TreeItem in self.selectedTreeNodes) {
				if ([tmp3TreeItem isEqualToSelectingItem:tmp2TreeItem]) {
					NSLog(@"%@", tmp3TreeItem.base);
					[self.selectedTreeNodes removeObject:tmp2TreeItem];
					break;
				}
			}
		}
    }
	
	if ([insertIndexPaths count])
        [treeNodeTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
	
	if ([removeIndexPaths count])
		[treeNodeTableView deleteRowsAtIndexPaths:removeIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
    
    [treeNodeTableView reloadData];
}

#pragma mark - Actions 

- (void)iconButtonAction:(KOTreeTableViewCell *)cell treeItem:(KOTreeNode *)tmpTreeItem {
	if ([self.selectedTreeNodes containsObject:cell.treeNode]) {
		[cell.iconButton setSelected:NO];
		[self.selectedTreeNodes removeObject:cell.treeNode];
	} else {
		[cell.iconButton setSelected:YES];
		
		[self.selectedTreeNodes removeAllObjects];
		[self.selectedTreeNodes addObject:cell.treeNode];
		
		[treeNodeTableView reloadData];
	}
}
#pragma mark - KOTreeTableViewCellDelegate

- (void)treeTableViewCell:(KOTreeTableViewCell *)cell didTapIconWithTreeItem:(KOTreeNode *)tmpTreeItem {
	NSLog(@"didTapIconWithselectingItem.base: %@", [tmpTreeItem base]);
	
	[self iconButtonAction:cell treeItem:tmpTreeItem];
}
@end
