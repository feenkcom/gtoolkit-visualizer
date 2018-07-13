measure
formDFSTrees: theNodes
	| allTrees visitedList |
	
	visitedList := OrderedCollection new.
	allTrees := OrderedCollection new.
	theNodes do: [ :aNodeElement |
		| connectedNodesDictionary |
		(visitedList includes: aNodeElement)
			ifFalse: [
				(aNodeElement graph connectedNodesAlongIncomingEdgesCount isZero)
					ifTrue: [
						connectedNodesDictionary := IdentityDictionary new.
						self dfs: aNodeElement visited: visitedList tree: connectedNodesDictionary. 
						allTrees add: (DFSTree new
												root: aNodeElement;
												connectedNodes: connectedNodesDictionary).
					].
			].
	].
	
	^ allTrees
		

	