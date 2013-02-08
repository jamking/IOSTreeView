IOSTreeView
===========

As a former android developer,I found a good treeview controller for android tree view. When I started with the IOS one, I found it's hard to find a powerful tree view as the android one. After some research,I decided to start from other people's work. To make things getting easier for others like me, I decide to contribute my source code online.

IOS Tree View. Thanks to KOTree(https://github.com/adamhoracek/KOTree), which is the best that I could have after googling. Based upon it, IOSTreeView supports more nodes with a simpler data structur with some small bugs fixed.  

The tree nodes store in an array,which are obtained through traversal the tree in Pre-order(root,left subtree,right subtree)
nodes has nodeId,depth,name information. [0,1,2,2,3,1,1] represents a tree structure as below: 0(1(2,2(3)),1,1) 


  
