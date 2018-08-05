as yet unclassified
horizontalTreeLayoutBinaryTree15Nodes
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [ :x | BlElement new size: 50@50; background: (Color black)]; with: (1 to: 15).
	mondrian edges connectFrom: [:x |x // 2].
	mondrian layout horizontalTree.
	^ mondrian