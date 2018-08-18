private-layout
initializeLayout: theNodes
"
This should set initial positions of nodes
and sets distances matrix
"
	self distanceMatrix: (Matrix new: (theNodes size) tabulate: [ :i :j | 0]).
	self randomlyPositionNodes: theNodes maxVerticalValue: 1000 maxHorizontalValue: 1000.
	
	"Now we need to calculate the distances
	Use Dijkstra's shortest path
	"