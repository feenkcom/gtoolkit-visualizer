private-layout
initializeLayout: theNodes
"
This should set initial positions of nodes
and sets distances matrix
"
	self distanceMatrix: (Matrix new: (theNodes size) tabulate: [ :i :j | 0]).
