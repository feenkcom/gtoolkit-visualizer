api - geometry
maxDepthHeight
	"Return the maximum height of the nodes at the same depth as me"
	<return: #Number>
	| aMaxHeight |

	aMaxHeight := self height.

	self root
		nodesAt: self depth
		do: [ :aTreeNode | aMaxHeight := aMaxHeight max: aTreeNode height ].
		
	^ aMaxHeight