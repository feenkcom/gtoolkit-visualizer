calculating
findRoot: theNodeElements
	"Find and return a node element among given elements that plays a role of a tree root"
	<return: #BlElement>

	^ theNodeElements detect: [ :aNodeElement | aNodeElement graph hasNodesAlongIncomingEdges not ]