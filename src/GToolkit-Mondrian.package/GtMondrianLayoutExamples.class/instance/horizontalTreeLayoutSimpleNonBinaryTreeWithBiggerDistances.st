as yet unclassified
horizontalTreeLayoutSimpleNonBinaryTreeWithBiggerDistances
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [ :x | BlElement new size: 50@50; background: (Color black)]; with: (1 to: 15).
	mondrian edges connect: { 1->2 . 1->3 . 2->4 . 2->5 . 3->6 . 3->7 . 4->8 .
	4->9 . 4->10 . 5->11 . 6->12 . 6->13 . 6->14 . 6->15 } from: #key to: #value.
	mondrian layout horizontalTree nodeDistance: 70; levelDistance: 100.
	^ mondrian