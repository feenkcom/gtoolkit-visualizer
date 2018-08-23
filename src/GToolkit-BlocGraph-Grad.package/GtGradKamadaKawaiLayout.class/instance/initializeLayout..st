private-layout
initializeLayout: theNodes
	| diameter width height num dijkstra |

	"TODO"
	width := 1000.
	height := 1000.
	num := theNodes size.
	dijkstra := DijkstrasShortestPath new.	

	self distanceMatrix: (Matrix new: (theNodes size) tabulate: [ :i :j | 0]).
	self randomlyPositionNodes: theNodes maxVerticalValue: 1000 maxHorizontalValue: 1000.
	
	"Now we need to calculate the distances"
	diameter := self calculateDiameter: theNodes.
	self length: ((height min: width) / diameter) * self lengthFactor.
	
	1 to: (num - 1) do: [  :i |
		( i + 1 ) to: num do: [  :j  |
			| pathij pathji nodei nodej dist |
			nodei := theNodes at: i.
			nodej := theNodes at: j.
			pathij := dijkstra calculateShortestPathFromSourceToTargetUnweighted: theNodes source: nodei target: nodej.
			pathji := dijkstra calculateShortestPathFromSourceToTargetUnweighted: theNodes source: nodej target: nodei.
			dist := diameter * self disconnectedMultiplier.
			pathij isNotEmpty
				ifTrue: [ dist := dist min: (pathij size) ].
			pathji isNotEmpty
				ifTrue: [ dist := dist min: (pathji size) ].
			self distanceMatrix at: i at: j put: dist.
			self distanceMatrix at: j at: i put: dist.
				
		].
	 ].