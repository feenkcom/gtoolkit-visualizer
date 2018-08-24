Class {
	#name : #GtMondrianLayoutExamples,
	#superclass : #Object,
	#category : 'GToolkit-Mondrian-Examples'
}

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> horizontalTreeLayoutBinaryTree15Nodes [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [ :x | BlElement new size: 50@50; background: (Color black)]; with: (1 to: 15).
	mondrian edges connectFrom: [:x |x // 2].
	mondrian layout horizontalTree.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> horizontalTreeLayoutGraphWithCycles [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [ :x | BlElement new size: 50@50; background: (Color black)]; with: (1 to: 7).
	mondrian edges connect: { 1->2 . 1->3 . 2->4 . 2->5 . 3->6 . 3->7 . 6->2 . 5-> 3} from: #key to: #value.
	mondrian layout horizontalTree nodeDistance: 5.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> horizontalTreeLayoutSimpleNonBinaryTree [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [ :x | BlElement new size: 50@50; background: (Color black)]; with: (1 to: 15).
	mondrian edges connect: { 1->2 . 1->3 . 2->4 . 2->5 . 3->6 . 3->7 . 4->8 .
	4->9 . 4->10 . 5->11 . 6->12 . 6->13 . 6->14 . 6->15 } from: #key to: #value.
	mondrian layout horizontalTree nodeDistance: 5.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> horizontalTreeLayoutSimpleNonBinaryTreeReversed [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [ :x | BlElement new size: 50@50; background: (Color black)]; with: (1 to: 15).
	mondrian edges connect: { 1->2 . 1->3 . 2->4 . 2->5 . 3->6 . 3->7 . 4->8 .
	4->9 . 4->10 . 5->11 . 6->12 . 6->13 . 6->14 . 6->15 } from: #key to: #value.
	mondrian layout horizontalTree nodeDistance: 5; reverse: true.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> horizontalTreeLayoutSimpleNonBinaryTreeWithBiggerDistances [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [ :x | BlElement new size: 50@50; background: (Color black)]; with: (1 to: 15).
	mondrian edges connect: { 1->2 . 1->3 . 2->4 . 2->5 . 3->6 . 3->7 . 4->8 .
	4->9 . 4->10 . 5->11 . 6->12 . 6->13 . 6->14 . 6->15 } from: #key to: #value.
	mondrian layout horizontalTree nodeDistance: 70; levelDistance: 100.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> horizontalTreeLayoutWithBottomAlignment [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [:x | BlElement new zIndex: 10; background: Color black; size: (3*x+3)@3]; with: (1 to: 20).
	mondrian edges 
		fromCenterBottom; 
		toCenterTop;
		connectFrom: [:x |x // 5].
	mondrian layout horizontalTree nodesAlignment: GtGradTreeNodesBottomAlignment new.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> horizontalTreeLayoutWithCenterAlignment [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [:x | BlElement new zIndex: 10; background: Color black; size: (3*x+3)@3]; with: (1 to: 20).
	mondrian edges 
		fromCenterBottom;
		toCenterTop;
		connectFrom: [:x |x // 5].
	mondrian layout horizontalTree nodesAlignment: GtGradTreeNodesCenterAlignment new.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> horizontalTreeLayoutWithNodeAndLevelDistances [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [:x | BlElement new zIndex: 10; background: Color black; size: (3*x+3)@3]; with: (1 to: 20).
	mondrian edges 
		fromCenterBottom;
		toCenterTop;
		connectFrom: [:x |x // 5].
	mondrian layout horizontalTree levelDistance: 10; nodeDistance: 1.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> verticalTreeLayoutBinaryTree15Nodes [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [ :x | BlElement new size: 50@50; background: (Color black)]; with: (1 to: 15).
	mondrian edges connectFrom: [:x |x // 2].
	mondrian layout tree.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> verticalTreeLayoutGraphWithCycles [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [ :x | BlElement new size: 50@50; background: (Color black)]; with: (1 to: 7).
	mondrian edges connect: { 1->2 . 1->3 . 2->4 . 2->5 . 3->6 . 3->7 . 6->2 . 5-> 3} from: #key to: #value.
	mondrian layout tree.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> verticalTreeLayoutSimpleNonBinaryTree [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [ :x | BlElement new size: 50@50; background: (Color black)]; with: (1 to: 15).
	mondrian edges connect: { 1->2 . 1->3 . 2->4 . 2->5 . 3->6 . 3->7 . 4->8 .
	4->9 . 4->10 . 5->11 . 6->12 . 6->13 . 6->14 . 6->15 } from: #key to: #value.
	mondrian layout tree nodeDistance: 5.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> verticalTreeLayoutSimpleNonBinaryTreeReversed [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [ :x | BlElement new size: 50@50; background: (Color black)]; with: (1 to: 15).
	mondrian edges connect: { 1->2 . 1->3 . 2->4 . 2->5 . 3->6 . 3->7 . 4->8 .
	4->9 . 4->10 . 5->11 . 6->12 . 6->13 . 6->14 . 6->15 } from: #key to: #value.
	mondrian layout tree nodeDistance: 5; reverse: true.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> verticalTreeLayoutSimpleNonBinaryTreeWithBiggerDistances [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [ :x | BlElement new size: 50@50; background: (Color black)]; with: (1 to: 15).
	mondrian edges connect: { 1->2 . 1->3 . 2->4 . 2->5 . 3->6 . 3->7 . 4->8 .
	4->9 . 4->10 . 5->11 . 6->12 . 6->13 . 6->14 . 6->15 } from: #key to: #value.
	mondrian layout tree nodeDistance: 70; levelDistance: 100.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> verticalTreeLayoutWithBottomAlignment [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [:x | BlElement new zIndex: 10; background: Color black; size: 3@(3*x+3)]; with: (1 to: 20).
	mondrian edges 
		fromCenterBottom;
		toCenterTop;
		connectFrom: [:x |x // 5].
	mondrian layout tree nodesAlignment: GtGradTreeNodesBottomAlignment new.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> verticalTreeLayoutWithCenterAlignment [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [:x | BlElement new zIndex: 10; background: Color black; size: 3@(3*x+3)]; with: (1 to: 20).
	mondrian edges 
		fromCenterBottom;
		toCenterTop;
		connectFrom: [:x |x // 5].
	mondrian layout tree nodesAlignment: GtGradTreeNodesCenterAlignment new.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutExamples >> verticalTreeLayoutWithNodeAndLevelDistances [
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [:x | BlElement new zIndex: 10; background: Color black; size: 3@(3*x+3)]; with: (1 to: 20).
	mondrian edges 
		fromCenterBottom;
		toCenterTop;
		connectFrom: [:x |x // 5].
	mondrian layout tree levelDistance: 10; nodeDistance: 1.
	^ mondrian
]
