private-layout
initializeLayout: theNodes
	| diameter L0 L width height num |

	"TODO"
	width := 1000.
	height := 1000.
	num := theNodes size.

	self distanceMatrix: (Matrix new: (theNodes size) tabulate: [ :i :j | 0]).
	self randomlyPositionNodes: theNodes maxVerticalValue: 1000 maxHorizontalValue: 1000.
	
	"Now we need to calculate the distances"
	diameter := self calculateDiameter: theNodes.
	L0 :=  height min: width.
	L := (L0 / diameter) * self lengthFactor.
	
	1 to: (num - 1) do: [  :i |
		( i + 1 ) to: num do: [  :j  |
			"set distances"		
		].
	 ].