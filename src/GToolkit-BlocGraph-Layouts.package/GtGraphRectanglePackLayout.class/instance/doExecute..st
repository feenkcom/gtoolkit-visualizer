hook
doExecute: elements
	| sortedElements maxSpace |
	bounds := 0@0.
	
	maxSpace := elements inject: 0@0 into: [ :sum :el |
			sum + el measuredExtent ].
		
	padding := maxSpace / elements size * gap / 2.
	
	maxSpace := 1 + gap * maxSpace.
	
	freeSpace := Set new.
	freeSpace add: (0@0 corner: maxSpace).
	
	sortedElements := SortedCollection sortBlock:  [ :larger :smaller |
		larger  boundsInLocal gtHalfPerimeter >
		smaller boundsInLocal gtHalfPerimeter ].
	sortedElements addAll: elements.
	
	sortedElements
		do: [ :el | self packIn: el ]