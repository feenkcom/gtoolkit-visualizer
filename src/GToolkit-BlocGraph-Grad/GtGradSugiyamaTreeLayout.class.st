Class {
	#name : #GtGradSugiyamaTreeLayout,
	#superclass : #GtGradLayout,
	#instVars : [
		'labels',
		'cachedParents',
		'layers',
		'layerNrs',
		'cachedChildren',
		'verticalGap',
		'horizontalGap',
		'sortBlock',
		'connections',
		'parentWithoutCycles',
		'edges',
		'reverse'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> addDummyNodes [

	| layer layerNr |
	connections := RSIdentityMatrix new.
	self edgesDo: [ :edge |
		| layerFrom layerTo span fromNode toNode |
		"edge hints removeAll."
		layerFrom := layerNrs at: edge fromNode.
		layerTo := layerNrs at: edge toNode.
		span := layerTo - layerFrom.

		"Normal case where nodes are in adjacent layers"
		span abs = 1 ifTrue: [ connections at: edge fromNode at: edge toNode put: true ].

		fromNode := edge fromNode.
		[ span > 1 or: [ span < -1 ] ] whileTrue: [
			span := span > 0
				ifTrue: [ span - 1]
				ifFalse: [ span + 1].
			layerNr := layerTo - span.
			layer := layers at: layerNr.
			"toNode := RSDummyNode on: edge slot: layerFrom - span."
			toNode := GtGradDummyNode on: edge slot: layerFrom - span.
			layer add: toNode.
			layerNrs at: toNode put: layerNr.
			connections at: fromNode at: toNode put: true.
			fromNode := toNode ].

		(layerFrom - layerTo) abs > 1 ifTrue: [
			connections at: fromNode at: edge toNode put: true ] ]
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> assignEdges: children [
	edges := children 
		flatCollect: [:child | child connectedEdges ]
		as: IdentityDictionary.
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> assignLabels: aNodeCollection [
	"Initialize label dictionary"
	| label vertices parentLabels max |
	labels := IdentityDictionary new.
	label := 1.
	"Assign labels to the roots"
	(self rootNodesFor: aNodeCollection) do: [ :node | 
		labels at: node put: label.
		label := label + 1 ].
	max := self maxFloat.
	"Assign labels to the rest"
	[ labels keys size < aNodeCollection size ] whileTrue: [ 
		| index |
		vertices := SortedCollection sortBlock: self sortBlock.
		index := 0.
		aNodeCollection
			reject: [:node | index := index + 1. labels includesKey: node ]
			thenDo: [ :node | 
				parentLabels := ((self parentsWithoutCylesFor: node)
					collect: [ :parentNode | labels at: parentNode ifAbsent: [ max ] ])
					asSortedCollection.
				parentLabels last ~= max
					ifTrue: [ vertices add: node -> parentLabels ]  
		].
		labels at: vertices first key put: label.
		label := label + 1
	]
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> buildLayers: g [

	| w layerNr u vertices vertex layer done |
	w := self maxFloat.
	u := OrderedCollection new.
	layers := IdentityDictionary new.
	layerNrs := IdentityDictionary new. "Assign all nodes to layers"
	[ g isEmpty ] whileFalse: [
		vertices := g select: [ :e |
			            (self parentsWithoutCylesFor: e) allSatisfy: [ :node |
				            u includes: node ] ].
		vertex := vertices detectMax: [ :e | labels at: e ].
		done := false.
		layerNr := 1.
		[ done ] whileFalse: [
			layer := layers at: layerNr ifAbsentPut: [ OrderedCollection new ].
			(layer size >= w or: [
				 (self parentsWithoutCylesFor: vertex) anySatisfy: [ :n |
					 (layerNrs at: n) >= layerNr ] ])
				ifTrue: [ layerNr := layerNr + 1 ]
				ifFalse: [ done := true ] ].
		layer add: vertex.
		layerNrs at: vertex put: layerNr.
		u add: vertex.
		g remove: vertex ]
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> cachedChildren [
	cachedChildren ifNil: [cachedChildren := IdentityDictionary new: 1000].
	^ cachedChildren
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> cachedParents [
	cachedParents ifNil: [cachedParents := IdentityDictionary new: 1000].
	^ cachedParents
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> childrenFor: aNode [
	^ self cachedChildren
		at: aNode
		ifAbsentPut:
			[| nodes |
			nodes := OrderedCollection new.
			self edgesDo:
					[:edge | 
					(edge fromNode == aNode and: [edge toNode ~= aNode])
						ifTrue:
							[(nodes includes: edge fromNode) ifFalse: [nodes add: edge toNode]]].
			nodes]
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> cl: layer u: u v: v [
	"Calculates cuv. Di Battista, chapter 9.2.2, page 283"
	| partnersOfU partnersOfV c partnersOfUIndex partnersOfVIndex layerNr |
	layerNr := layerNrs at: u.	":= layerNrs at: v"
	partnersOfU := (connections at: u)
		select: [:each | (layerNrs at: each) = (layerNr - 1)].
	partnersOfV := (connections at: v)
		select: [:each | (layerNrs at: each) = (layerNr - 1)].
	c := 0.
	partnersOfUIndex := partnersOfU collect: [:node | layer indexOf: node].
	partnersOfVIndex := partnersOfV collect: [:node | layer indexOf: node].
	partnersOfUIndex
		do:
			[:uIndex | partnersOfVIndex do: [:vIndex | vIndex < uIndex ifTrue: [c := c + 1]]].
	^c
]

{ #category : #defaults }
GtGradSugiyamaTreeLayout >> defaultSortBlock [
	^ [:assocA :assocB | self sortBlockValue: assocA value: assocB ]
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> edgesDo: aBlock [
	"Iterates over all the edges of the receiver."
	edges ifNil: [ ^ self ].
	edges do: aBlock

]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> horizontalGap [
	"Return the horizontal space, in pixel, between two neighbors"
	^ horizontalGap 
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> horizontalGap: aNumber [
	horizontalGap := aNumber
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> initialize [
	super initialize.
	self 
		horizontalGap: 3.0;
		verticalGap: 20;
		sortBlock: self defaultSortBlock;
		reverse: false
		
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> layoutAt: aPoint [

	| treeWidth layerKeys layer layerWidth horizontalPosition 
	verticalPosition layerHeight hgap vgap|
	hgap := self horizontalGap.
	vgap := self verticalGap.
	treeWidth := layers values
		             inject: self maxFloat negated
		             into: [ :max :e |
			             max max:
				             (e sumNumbers: #width)
				             + ((e size - 1) * hgap) ].
	verticalPosition := hgap.
	layerKeys := layers keys asSortedCollection.
	reverse ifTrue: [ layerKeys := layerKeys reversed ].
	
	layerKeys do: [ :aKey |
		layer := layers at: aKey.
		layerWidth := (layer sum: #width) + ((layer size - 1) * hgap).
		layerHeight := (layer detectMax: #height) height.
		horizontalPosition := treeWidth / 2.0 + aPoint x - (layerWidth / 2.0).
		layer do: [ :node |
			node position: horizontalPosition @ verticalPosition.
			horizontalPosition := horizontalPosition + node width+ hgap
		].
		verticalPosition := verticalPosition + layerHeight + vgap ]
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> maxFloat [
	^ 1e10
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> measureChildrenPositions: aParentLayoutNode [
	"super measureChildrenPositions: aParentLayoutNode"
	| children|
	children := aParentLayoutNode withGraphEdges children.
	self assignEdges: children.
	self assignLabels: children.
	self buildLayers: (OrderedCollection withAll: children).
	self addDummyNodes.
	self reduceCrossing.
	self layoutAt: self horizontalGap @ self verticalGap.
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> parentsFor: aNode [
	^ self cachedParents
		at: aNode
		ifAbsentPut:
			[ | nodes |
			nodes := OrderedCollection new.
			self edgesDo:
					[:edge | edge toNode == aNode ifTrue: [ nodes add: edge fromNode ] ].
			nodes ]
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> parentsWithoutCylesFor: aNode [

	parentWithoutCycles ifNil: [ parentWithoutCycles := IdentityDictionary new ].
	^ parentWithoutCycles at: aNode ifAbsentPut: [ (self parentsFor: aNode) copy ]
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> reduceCrossing [
	"Crossing reduction"
	| layer2 u v c1 c2 layer1 done |
	2
		to: layers keys size
		do:
			[:index | 
			layer1 := layers at: index - 1.
			layer2 := layers at: index.
			done := false.
			[done]
				whileFalse:
					[done := true.
					2
						to: layer2 size
						do:
							[:i | 
							u := layer2 at: i - 1.
							v := layer2 at: i.
							c1 := self cl: layer1 u: u v: v.
							c2 := self cl: layer1 u: v v: u.
							c1 > c2
								ifTrue:
									[layer2 rsSwapElement: u withElement: v.
									done := false]]]]
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> reverse [
	^ reverse
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> reverse: aBoolean [
	reverse := aBoolean
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> rootNodesFor: aCollection [
	^ aCollection select: [:node | 
		(self parentsFor: node) isEmpty ].
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> sortBlock [
	^ sortBlock
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> sortBlock: aBlock [
	sortBlock := aBlock
]

{ #category : #defaults }
GtGradSugiyamaTreeLayout >> sortBlockValue: assocA value: assocB [
	"Return false if assocA is bigger than assocB.
	Return true if assocA is smaller than assocB.
	-> Inverted list with biggest elements first"
	
	| a b offset |
	offset := 0.
	a := assocA value.
	b := assocB value.
	[(a size > offset)
		and: [(b size > offset) and: [(a at: a size - offset) = (b at: b size - offset)]]]
		whileTrue: [offset := offset + 1].	"Corner cases"
	(a size = b size and: [b size = offset]) ifTrue: [ ^ true ].	"[3, 3], [3, 3]"
	(a size > offset and: [b size = offset]) ifTrue: [ ^ true ].	"[3, 3, 6], [3, 3]"
	(b size > offset and: [a size = offset]) ifTrue: [ ^ false ].	"[3, 3], [3, 3, 6]"	"Normal case"
	^(a at: a size - offset) >= (b at: b size - offset)
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> verticalGap [
	"Return the vertical space, in pixel, between a layer and a children layer"
	^ verticalGap
]

{ #category : #accessing }
GtGradSugiyamaTreeLayout >> verticalGap: aNumber [
	verticalGap := aNumber
]
