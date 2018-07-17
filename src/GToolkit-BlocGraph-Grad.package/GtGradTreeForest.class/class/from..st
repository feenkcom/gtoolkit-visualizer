instance creation
from: aCollectionOfElements
	"Create a forest of node trees using depth-first-search algorithm"
	| allTrees visitedDictionary |

	allTrees := OrderedDictionary new.
	visitedDictionary := IdentityDictionary new.

	aCollectionOfElements do: [ :aNodeElement |
		((visitedDictionary includesKey: aNodeElement) or: [ aNodeElement graph hasNodesAlongIncomingEdges ])
			ifFalse: [
				| aTreeNode |
				aTreeNode := GtGradTreeNode on: aNodeElement.
				self dfs: aTreeNode visited: visitedDictionary.
				allTrees at: aTreeNode root put: #root ] ].

	^ self new trees: allTrees keys