measure
formDFSTrees: theNodes
	| allTrees visitedList |
	
	visitedList := Set new.
	allTrees := OrderedCollection new.
	theNodes do: [ :aNodeElement |
		| connectedNodesDictionary |
		(visitedList includes: aNodeElement)
			ifFalse: [
				aNodeElement graph hasNodesAlongIncomingEdges
					ifFalse: [
						connectedNodesDictionary := IdentityDictionary new.
						self dfs: aNodeElement visited: visitedList tree: connectedNodesDictionary. 
						allTrees add: (GtGradDepthFirstSearchTree new
												root: aNodeElement;
												connectedNodes: connectedNodesDictionary).
					].
			].
	].
	
	^ allTrees
		

	