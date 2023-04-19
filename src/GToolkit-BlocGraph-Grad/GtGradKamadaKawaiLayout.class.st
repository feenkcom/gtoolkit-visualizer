"
This is an implementation of the Kamada-Kawai force-directed algorithm. The algorithm was designed with the intention of laying out general undirected graphs.

It is a spring algorithm whose main idea is that graph theoretic distances between vertices in a graph is related to the geomentri distances between them in the drawing.


"
Class {
	#name : #GtGradKamadaKawaiLayout,
	#superclass : #GtGradLayout,
	#instVars : [
		'lengthFactor',
		'disconnectedMultiplier',
		'maxIterations',
		'currentIteration',
		'adjustForGravity',
		'exchangeNodes',
		'distanceMatrix',
		'length',
		'arbitraryConstantK',
		'epsilon',
		'width',
		'height'
	],
	#category : #'GToolkit-BlocGraph-Grad-Force-Directed'
}

{ #category : #accessing }
GtGradKamadaKawaiLayout >> adjustForGravity: aBool [
	adjustForGravity := aBool
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> arbitraryConstantK: anObject [
	arbitraryConstantK := anObject
]

{ #category : #'private-layout' }
GtGradKamadaKawaiLayout >> calculateDeltaAtNode: theNodes node: aNode nodeIndex: nodeIndex [
	| nodePosition dxSum dySum |
	nodePosition := aNode position.
	dxSum := 0.
	dySum := 0.

	theNodes
		doWithIndex: [ :currentNode :currentIndex | 
			currentIndex ~= nodeIndex
				ifTrue: [ | dist dx dy d l k currentNodePosition common |
					dist := self distanceMatrix at: nodeIndex at: currentIndex.
					currentNodePosition := currentNode position.
					dx := nodePosition x - currentNodePosition x.
					dy := nodePosition y - currentNodePosition y.
					d := (dx squared + dy squared) sqrt.
					l := self length * dist.
					k := arbitraryConstantK / dist squared.
					common := k * (1 - (l / d)).
					dxSum := dxSum + (common * dx).
					dySum := dySum + (common * dy) ] ].
	^ (dxSum squared + dySum squared) sqrt
]

{ #category : #'private-layout' }
GtGradKamadaKawaiLayout >> calculateDeltaPositionNode: theNodes node: aNode nodeIndex: nodeIndex [
	"Determines a step to a new position of the given node"

	| nodePosition dEx dEy d2Ex d2Ey d2Exy denominator deltaX deltaY |
	nodePosition := aNode position.
	dEx := 0.
	dEy := 0.
	d2Ex := 0.
	d2Ey := 0.
	d2Exy := 0.

	theNodes
		doWithIndex: [ :currentNode :currentIndex | 
			currentIndex ~= nodeIndex
				ifTrue: [ | currentPosition dist l k dx dy d dCube dxSquared dySquared |
					currentPosition := currentNode position.
					dist := self distanceMatrix at: nodeIndex at: currentIndex.
					l := length * dist.
					k := arbitraryConstantK / dist squared.
					dx := nodePosition x - currentPosition x.
					dy := nodePosition y - currentPosition y.
					dxSquared := dx squared.
					dySquared := dy squared.
					d := (dxSquared + dySquared) sqrt.
					dCube := d * d * d.

					dEx := dEx + (k * (1 - (l / d)) * dx).
					dEy := dEy + (k * (1 - (l / d)) * dy).
					d2Ex := d2Ex + (k * (1 - (l * dySquared / dCube))).
					d2Exy := d2Exy + (k * l * dx * dy / dCube).
					d2Ey := d2Ey + (k * (1 - (l * dxSquared / dCube))) ] ].
	denominator := d2Ex * d2Ey - d2Exy squared.
	deltaX := (d2Exy * dEy - (d2Ey * dEx)) / denominator.
	deltaY := (d2Exy * dEx - (d2Ex * dEy)) / denominator.
	^ deltaX @ deltaY
]

{ #category : #'private-layout' }
GtGradKamadaKawaiLayout >> calculateDiameter: theNodes [
	| dijkstra diameterVal |
	dijkstra := DijkstrasShortestPath new.
	diameterVal := 0.
	theNodes
		do: [ :firstNode | 
			| paths |
			paths := dijkstra
					calculateShortestPathFromSourceUnweighted: theNodes
					source: firstNode.
			theNodes
				allButFirstDo: [ :secondNode | 
					| path |
					path := paths at: secondNode.
					path isNotEmpty ifTrue: [ diameterVal := diameterVal max: path size ] ] ].
	^ diameterVal
]

{ #category : #'private-layout' }
GtGradKamadaKawaiLayout >> calculateEnergy: theNodes [
	| energy num |
	energy := 0.

	num := theNodes size.
	1
		to: num - 1
		do: [ :i | 
			i + 1
				to: num
				do: [ :j | 
					| theFirstNode theSecondNode distance lij kij dx dy d position1 position2 |
					theFirstNode := theNodes at: i.
					theSecondNode := theNodes at: j.
					distance := self distanceMatrix at: i at: j.
					lij := self length * distance.
					kij := arbitraryConstantK / distance squared.
					position1 := theFirstNode position.
					position2 := theSecondNode position.
					dx := position1 x - position2 x.
					dy := position1 y - position2 y.
					d := (dx squared + dy squared) sqrt.
					energy := (energy + (kij / 2))
							* (dx squared + dy squared + lij squared - (2 * lij * d)) ] ].

	^ energy
]

{ #category : #'private-layout' }
GtGradKamadaKawaiLayout >> calculateEnergyIfExchanged: theNodes firstNodeIndex: firstIndex secondNodeIndex: secondIndex [
	" Calculates the energy function E as if positions of the specified nodes are exchanged."

	| energy nodesNum dist l k dx dy d |
	energy := 0.
	nodesNum := theNodes size.
	1
		to: nodesNum - 1
		do: [ :i | 
			i + 1
				to: nodesNum
				do: [ :j | 
					| ii jj nodePosition1 nodePosition2 |
					ii := i.
					jj := j.
					i = firstIndex ifTrue: [ ii := secondIndex ].
					j = secondIndex ifTrue: [ jj := firstIndex ].
					dist := self distanceMatrix at: i at: j.
					l := self length * dist.
					k := arbitraryConstantK / dist squared.
					nodePosition1 := (theNodes at: ii) position.
					nodePosition2 := (theNodes at: jj) position.
					dx := nodePosition1 x - nodePosition2 x.
					dy := nodePosition1 y - nodePosition2 y.
					d := (dx squared + dy squared) sqrt.
					energy := (energy + (k / 2))
							* (dx squared + dy squared + l squared - (2 * l * d)) ] ].

	^ energy
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> disconnectedMultiplier: aNumber [
	disconnectedMultiplier := aNumber
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> distanceMatrix [
	^ distanceMatrix
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> distanceMatrix: anObject [
	distanceMatrix := anObject
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> epsilon [
	^ epsilon
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> epsilon: anObject [
	epsilon := anObject
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> exchangeNodes [
	^ exchangeNodes
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> exchangeNodes: aBool [
	exchangeNodes := aBool
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> height [
	^ height
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> height: anObject [
	height := anObject
]

{ #category : #initialization }
GtGradKamadaKawaiLayout >> initialize [
	super initialize.
	currentIteration := 1.
	lengthFactor := 0.9.
	disconnectedMultiplier := 0.5.
	maxIterations := 2000.
	adjustForGravity := true.
	exchangeNodes := true.
	arbitraryConstantK := 1.
	epsilon := 0.1.
	height := 500.
	width := 500.

]

{ #category : #'private-layout' }
GtGradKamadaKawaiLayout >> initializeLayout: theNodes [
	"Initialization of the layout "

	| diameter num dijkstra paths |
	num := theNodes size.
	dijkstra := DijkstrasShortestPath new.
	distanceMatrix := Array2D new: num tabulate: [ :i :j | 0 ].
	self
		randomlyPositionNodes: theNodes
		maxVerticalValue: height
		maxHorizontalValue: width.	
		
	"Now we need to calculate the distances"
	diameter := self calculateDiameter: theNodes.
	length := (height min: width) / diameter * lengthFactor.

	paths := IdentityDictionary new.
	theNodes
		do: [ :node | 
			paths
				at: node
				put: (dijkstra calculateShortestPathFromSourceUnweighted: theNodes source: node) ].

	1
		to: num - 1
		do: [ :i | 
			i + 1
				to: num
				do: [ :j | 
					| pathij pathji nodei nodej dist |
					nodei := theNodes at: i.
					nodej := theNodes at: j.
					pathij := (paths at: nodei) at: nodej.
					pathji := (paths at: nodej) at: nodei.
					dist := diameter * disconnectedMultiplier.
					pathij isNotEmpty ifTrue: [ dist := dist min: pathij size ].
					pathji isNotEmpty ifTrue: [ dist := dist min: pathji size ].
					distanceMatrix
						at: i
						at: j
						put: dist.
					distanceMatrix
						at: j
						at: i
						put: dist ] ].
	GtGradKamadaKawaiDistanceMatrixSignal new
		distanceMatrix: distanceMatrix;
		emit
]

{ #category : #'private-layout' }
GtGradKamadaKawaiLayout >> layoutDone [
	^ currentIteration > self maxIterations
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> length [
	^ length
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> length: anObject [
	length := anObject
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> lengthFactor [
	^ lengthFactor
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> lengthFactor: aNumber [
	lengthFactor := aNumber
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> maxIterations [
	^ maxIterations
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> maxIterations: aNumber [
	maxIterations := aNumber
]

{ #category : #measure }
GtGradKamadaKawaiLayout >> measureChildrenPositions: aParentLayoutNode [
	| aParentGraphNode |

	aParentGraphNode := aParentLayoutNode withGraphNodes withGraphEdges.

	self initializeLayout: aParentGraphNode children.
	[ self layoutDone ] whileFalse: [ self step: aParentGraphNode children ].
	aParentGraphNode children normalizePositions
]

{ #category : #'private-layout' }
GtGradKamadaKawaiLayout >> randomlyPositionNodes: theNodes maxVerticalValue: maxX maxHorizontalValue: maxY [
	| positions |
	positions := OrderedCollection new.
	theNodes do: [ :aNodeElement |
		| position positionSet |
		positionSet := false.
		[ positionSet ]
			whileFalse: [ 
				position := (maxX atRandom)@(maxY atRandom).
				(positions includes: position)
					ifFalse: [ 
						positions add: position.
						aNodeElement position: position.
						GtGradKamadaKawaiInitialPositionSetSignal new
							node: aNodeElement;
							position: position;
							emit.
						positionSet := true.
					].
			].
	].

]

{ #category : #initialization }
GtGradKamadaKawaiLayout >> setDefaultParameterValues: theNodes [
	| maxNodeSize factor |
	"This is experimental. Created it like that based on previous experimentation
	using an editor with nodes of different default sizes. There is definitely room
	for improvement, but this is the basic idea"
	maxNodeSize := 0.
	theNodes do: [ :aNode |
		maxNodeSize := maxNodeSize max: aNode extent max. 
	].

	factor := 1 max: (maxNodeSize / 70).
	theNodes size < 4
		ifTrue: [ 
			self lengthFactor: 0.4 * factor.
			self disconnectedMultiplier: 0.8 * factor.
			^ self
		].
	theNodes size < 10
		ifTrue: [ 
			self lengthFactor: 0.8 * factor.
			self disconnectedMultiplier: 4 * factor.
			^ self
		].
	factor := 1 max: (maxNodeSize / 100).
	theNodes size < 20
		ifTrue: [ 
			self lengthFactor: factor.
			self disconnectedMultiplier: 5 * factor.	
		]
		ifFalse: [ 
			self lengthFactor: 1.2 * factor.
			self disconnectedMultiplier: 10 * factor.
		].

]

{ #category : #'private-layout' }
GtGradKamadaKawaiLayout >> shiftNodesToTheCenterOfGavity: theNodes [
	| gx gy nodesNum diffx diffy |
	gx := 0.
	gy := 0.
	nodesNum := theNodes size.

	theNodes
		do: [ :aNode | 
			| nodePosition |
			nodePosition := aNode position.
			gx := gx + nodePosition x.
			gy := gy + nodePosition y ].

	gx := gx / nodesNum.
	gy := gy / nodesNum.
	diffx := width / 2 - gx.
	diffy := self height / 2 - gy.	"set new postions of nodes"
	theNodes
		do: [ :aNode | 
			| currentPosition |
			currentPosition := aNode position.
			aNode position: (currentPosition x + diffx) @ (currentPosition y + diffy) ]
]

{ #category : #'private-layout' }
GtGradKamadaKawaiLayout >> step: theNodes [
	| maxDeltaNode nodeWithMaxDelta nodeWithMaxDeltaIndex loopIndex thresholdReached energy nodesNum aNumber |
	aNumber := currentIteration + 1.
	currentIteration := aNumber.
	maxDeltaNode := 0.
	nodeWithMaxDeltaIndex := -1.
	theNodes
		doWithIndex: [ :aNode :index | 
			| deltaNode |
			deltaNode := self
					calculateDeltaAtNode: theNodes
					node: aNode
					nodeIndex: index.
			deltaNode > maxDeltaNode
				ifTrue: [ maxDeltaNode := deltaNode.
					nodeWithMaxDelta := aNode.
					nodeWithMaxDeltaIndex := index ] ].
	nodeWithMaxDeltaIndex > -1 ifFalse: [ ^ self ].
	loopIndex := 1.
	thresholdReached := false.
	[ loopIndex <= 100 and: [ thresholdReached not ] ]
		whileTrue: [ | dxy nodePosition deltaAtNode |
			loopIndex := loopIndex + 1.
			dxy := self
					calculateDeltaPositionNode: theNodes
					node: nodeWithMaxDelta
					nodeIndex: nodeWithMaxDeltaIndex.
			nodePosition := nodeWithMaxDelta position.
			nodeWithMaxDelta
				position: (nodePosition x + dxy x) @ (nodePosition y + dxy y).
			deltaAtNode := self
					calculateDeltaAtNode: theNodes
					node: nodeWithMaxDelta
					nodeIndex: nodeWithMaxDeltaIndex.
			thresholdReached := deltaAtNode < epsilon ].
	adjustForGravity ifTrue: [ self shiftNodesToTheCenterOfGavity: theNodes ].
	(exchangeNodes and: [ maxDeltaNode < epsilon ]) ifFalse: [ ^ self ].

	energy := self calculateEnergy: theNodes.
	nodesNum := theNodes size.
	1
		to: nodesNum - 1
		do: [ :i | 
			i + 1
				to: nodesNum
				do: [ :j | 
					| exenergy firstNode secondNode position1 position2 |
					exenergy := self
							calculateEnergyIfExchanged: theNodes
							firstNodeIndex: i
							secondNodeIndex: j.
					energy > exenergy
						ifTrue: [ firstNode := theNodes at: i.
							secondNode := theNodes at: j.
							position1 := firstNode position.
							position2 := secondNode position.
							firstNode position: position2 x @ position2 y.
							secondNode position: position1 x @ position1 y.
							^ self ] ] ]
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> width [
	^ width
]

{ #category : #accessing }
GtGradKamadaKawaiLayout >> width: anObject [
	width := anObject
]
