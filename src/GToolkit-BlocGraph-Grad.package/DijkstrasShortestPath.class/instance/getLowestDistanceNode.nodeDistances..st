calculating
getLowestDistanceNode: unsettledNodes nodeDistances: aNodeDistancesDict
	| lowestDistance lowestDistanceNode |
	
	lowestDistanceNode := nil.
	lowestDistance := SmallInteger maxVal.
	unsettledNodes do: [ :aNode |
		| aNodeDistance |
		aNodeDistance := aNodeDistancesDict at: aNode.
		aNodeDistance < lowestDistance
			ifTrue: [ 
				lowestDistance := aNodeDistance.
				lowestDistanceNode := aNode.	
			].
	].
	
	^ lowestDistanceNode
	