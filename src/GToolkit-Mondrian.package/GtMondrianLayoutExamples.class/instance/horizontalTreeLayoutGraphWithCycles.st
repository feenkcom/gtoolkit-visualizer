as yet unclassified
horizontalTreeLayoutGraphWithCycles
	<gtExample>
	| mondrian |
	mondrian := GtMondrian new.
	mondrian nodes shape: [ :x | BlElement new size: 50@50; background: (Color black)]; with: (1 to: 7).
	mondrian edges connect: { 1->2 . 1->3 . 2->4 . 2->5 . 3->6 . 3->7 . 6->2 . 5-> 3} from: #key to: #value.
	mondrian layout horizontalTree nodeDistance: 5.
	^ mondrian