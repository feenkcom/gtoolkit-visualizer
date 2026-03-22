Class {
	#name : #GtMondrianLayoutExamples,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #tree }
GtMondrianLayoutExamples >> centeredDominanceSimpleVerticalTree [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 5).
	mondrian edges
		connect: {1 -> 2.
				1 -> 3.
				1 -> 4.
				2 -> 5.
				2 -> 5.
				3 -> 5.
				4 -> 5}
		from: #key
		to: #value.
	mondrian layout custom: GtGradVerticalDominanceCenteredTreeLayout new.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> centeredDominanceVerticalTree [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 11).
	mondrian edges
		connect: {1 -> 2.
				1 -> 3.
				1 -> 4.
				1 -> 5.
				2 -> 6.
				3 -> 6.
				4 -> 6.
				5 -> 6.
				6 -> 7.
				6 -> 8.
				2 -> 10.
				10 -> 11.
				11 -> 9.
				7 -> 9.
				8 -> 9}
		from: #key
		to: #value.
	mondrian layout custom: GtGradVerticalDominanceCenteredTreeLayout new.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> horizontalDominanceTree [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 9).
	mondrian edges
		connect: {1 -> 2.
				1 -> 3.
				2 -> 4.
				1 -> 7.
				2 -> 9.
				3 -> 5.
				5 -> 6.
				6 -> 7.
				7 -> 8.
				9 -> 8}
		from: #key
		to: #value.
	mondrian layout custom: GtGradHorizontalDominanceTreeLayout new.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> horizontalTreeLayoutBinaryTree15Nodes [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 15).
	mondrian edges connectFrom: [ :x | x // 2 ].
	mondrian layout horizontalTree.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> horizontalTreeLayoutGraphWithCycles [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 7).
	mondrian edges
		connect: {1 -> 2.
				1 -> 3.
				2 -> 4.
				2 -> 5.
				3 -> 6.
				3 -> 7.
				6 -> 2.
				5 -> 3}
		from: #key
		to: #value.
	mondrian layout horizontalTree nodeDistance: 5.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> horizontalTreeLayoutSeparateSubtrees [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | BlTextElement new text: x asString asRopedText ];
		with: (0 to: 20).
	mondrian edges connectFrom: [ :x | x // 3 ].
	mondrian layout custom: (GtGradHorizontalTreeLayout new separateSubtrees: true).

	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> horizontalTreeLayoutSimpleNonBinaryTree [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 15).
	mondrian edges
		connect: {1 -> 2.
				1 -> 3.
				2 -> 4.
				2 -> 5.
				3 -> 6.
				3 -> 7.
				4 -> 8.
				4 -> 9.
				4 -> 10.
				5 -> 11.
				6 -> 12.
				6 -> 13.
				6 -> 14.
				6 -> 15}
		from: #key
		to: #value.
	mondrian layout horizontalTree nodeDistance: 5.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> horizontalTreeLayoutSimpleNonBinaryTreeReversed [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 15).
	mondrian edges
		connect: {1 -> 2.
				1 -> 3.
				2 -> 4.
				2 -> 5.
				3 -> 6.
				3 -> 7.
				4 -> 8.
				4 -> 9.
				4 -> 10.
				5 -> 11.
				6 -> 12.
				6 -> 13.
				6 -> 14.
				6 -> 15}
		from: #key
		to: #value.
	mondrian layout
		custom: (GtGradHorizontalTreeLayout new
				nodeDistance: 5;
				reverse: true).
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> horizontalTreeLayoutSimpleNonBinaryTreeWithBiggerDistances [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 15).
	mondrian edges
		connect: {1 -> 2.
				1 -> 3.
				2 -> 4.
				2 -> 5.
				3 -> 6.
				3 -> 7.
				4 -> 8.
				4 -> 9.
				4 -> 10.
				5 -> 11.
				6 -> 12.
				6 -> 13.
				6 -> 14.
				6 -> 15}
		from: #key
		to: #value.
	mondrian layout horizontalTree
		nodeDistance: 70;
		levelDistance: 100.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> horizontalTreeLayoutWithBottomAlignment [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				zIndex: 10;
				background: Color black;
				size: (3 * x + 3) @ 3 ];
		with: (1 to: 20).
	mondrian edges
		fromCenterBottom;
		toCenterTop;
		connectFrom: [ :x | x // 5 ].
	mondrian layout
		custom: (GtGradHorizontalTreeLayout new nodesAlignment: GtGradTreeNodesLeafAlignment new).
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> horizontalTreeLayoutWithCenterAlignment [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				zIndex: 10;
				background: Color black;
				size: (3 * x + 3) @ 3 ];
		with: (1 to: 20).
	mondrian edges
		fromCenterBottom;
		toCenterTop;
		connectFrom: [ :x | x // 5 ].
	mondrian layout
		custom: (GtGradHorizontalTreeLayout new
				nodesAlignment: GtGradTreeNodesCenterAlignment new).
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> horizontalTreeLayoutWithNodeAndLevelDistances [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				zIndex: 10;
				background: Color black;
				size: (3 * x + 3) @ 3 ];
		with: (1 to: 20).
	mondrian edges
		fromCenterBottom;
		toCenterTop;
		connectFrom: [ :x | x // 5 ].
	mondrian layout horizontalTree
		levelDistance: 10;
		nodeDistance: 1.
	^ mondrian
]

{ #category : #force }
GtMondrianLayoutExamples >> simpleTreeForceDirectedExample [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 7).
	mondrian edges connectFrom: [ :x | x // 2 ].
	mondrian layout custom: GtGradKamadaKawaiLayout new.
	^ mondrian
]

{ #category : #accessing }
GtMondrianLayoutExamples >> sugiyamaTreeLayout [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :cls | 
			BlElement new
				zIndex: 10;
				background: (Color black alpha: 0.4);
				size: (cls linesOfCode sqrt + 1) asPoint ];
		with: ArrayedCollection withAllSubclasses.
	mondrian edges
		fromCenterBottom;
		toCenterTop;
		connectFrom: #superclass.
	mondrian layout sugiyama.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> verticalDominanceTree [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 9).
	mondrian edges
		connect: {1 -> 2.
				1 -> 3.
				2 -> 4.
				1 -> 7.
				2 -> 9.
				3 -> 5.
				5 -> 6.
				6 -> 7.
				7 -> 8.
				9 -> 8}
		from: #key
		to: #value.
	mondrian layout custom: GtGradVerticalDominanceTreeLayout new.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> verticalTreeLayoutBinaryTree15Nodes [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 15).
	mondrian edges connectFrom: [ :x | x // 2 ].
	mondrian layout tree.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> verticalTreeLayoutGraphWithCycles [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 7).
	mondrian edges
		connect: {1 -> 2.
				1 -> 3.
				2 -> 4.
				2 -> 5.
				3 -> 6.
				3 -> 7.
				6 -> 2.
				5 -> 3}
		from: #key
		to: #value.
	mondrian layout tree.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> verticalTreeLayoutSeparateSubtrees [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | BlTextElement new text: x asString asRopedText ];
		with: (0 to: 20).
	mondrian edges connectFrom: [ :x | x // 3 ].
	mondrian layout tree separateSubtrees: true.

	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> verticalTreeLayoutSimpleNonBinaryTree [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 15).
	mondrian edges
		connect: {1 -> 2.
				1 -> 3.
				2 -> 4.
				2 -> 5.
				3 -> 6.
				3 -> 7.
				4 -> 8.
				4 -> 9.
				4 -> 10.
				5 -> 11.
				6 -> 12.
				6 -> 13.
				6 -> 14.
				6 -> 15}
		from: #key
		to: #value.
	mondrian layout tree nodeDistance: 5.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> verticalTreeLayoutSimpleNonBinaryTreeReversed [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 15).
	mondrian edges
		connect: {1 -> 2.
				1 -> 3.
				2 -> 4.
				2 -> 5.
				3 -> 6.
				3 -> 7.
				4 -> 8.
				4 -> 9.
				4 -> 10.
				5 -> 11.
				6 -> 12.
				6 -> 13.
				6 -> 14.
				6 -> 15}
		from: #key
		to: #value.
	mondrian layout tree
		nodeDistance: 5;
		reverse: true.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> verticalTreeLayoutSimpleNonBinaryTreeWithBiggerDistances [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 15).
	mondrian edges
		connect: {1 -> 2.
				1 -> 3.
				2 -> 4.
				2 -> 5.
				3 -> 6.
				3 -> 7.
				4 -> 8.
				4 -> 9.
				4 -> 10.
				5 -> 11.
				6 -> 12.
				6 -> 13.
				6 -> 14.
				6 -> 15}
		from: #key
		to: #value.
	mondrian layout tree
		nodeDistance: 70;
		levelDistance: 100.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> verticalTreeLayoutWithBottomAlignment [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				zIndex: 10;
				background: Color black;
				size: 3 @ (3 * x + 3) ];
		with: (1 to: 20).
	mondrian edges
		fromCenterBottom;
		toCenterTop;
		connectFrom: [ :x | x // 5 ].
	mondrian layout tree nodesAlignment: GtGradTreeNodesLeafAlignment new.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> verticalTreeLayoutWithCenterAlignment [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				zIndex: 10;
				background: Color black;
				size: 3 @ (3 * x + 3) ];
		with: (1 to: 20).
	mondrian edges
		fromCenterBottom;
		toCenterTop;
		connectFrom: [ :x | x // 5 ].
	mondrian layout tree nodesAlignment: GtGradTreeNodesCenterAlignment new.
	^ mondrian
]

{ #category : #tree }
GtMondrianLayoutExamples >> verticalTreeLayoutWithNodeAndLevelDistances [
	<gtExample>
	<return: #GtMondrian>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes
		stencil: [ :x | 
			BlElement new
				zIndex: 10;
				background: Color black;
				size: 3 @ (3 * x + 3) ];
		with: (1 to: 20).
	mondrian edges
		fromCenterBottom;
		toCenterTop;
		connectFrom: [ :x | x // 5 ].
	mondrian layout tree
		levelDistance: 10;
		nodeDistance: 1.
	^ mondrian
]
