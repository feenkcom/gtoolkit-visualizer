as yet unclassified
verticalTreeLayoutWithCenterAlignment
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