measure
formDFSTrees: aRootElement nodes: theNodes
	| allTrees visitedList |
	
	visitedList := OrderedCollection new.
	allTrees := OrderedCollection new.
	theNodes do: [ :aNodeElement |
		| aDFSTree |
		(visitedList includesKey: aNodeElement)
			ifFalse: [
				(aNodeElement connectedNodesAlongIncomingEdgesCount isZero)
					ifTrue: [
						aDFSTree := IdentityDictionary new.
						self dfs: aRootElement visited: visitedList tree: aDFSTree.
						allTrees add: aDFSTree
					].
			].
	].
	
	^ allTrees
		

	