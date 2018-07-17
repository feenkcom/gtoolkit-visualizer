api - geometry
maxDepthWidth
	"Return the maximum width of the nodes at the same depth as me"
	<return: #Number>
	| aMaxWidth |

	aMaxWidth := self width.

	self root
		nodesAt: self depth
		do: [ :aTreeNode | aMaxWidth := aMaxWidth max: aTreeNode width ].
		
	^ aMaxWidth