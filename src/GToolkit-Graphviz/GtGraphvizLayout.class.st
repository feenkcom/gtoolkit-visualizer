"
A native Bloc graph layout backed by Graphviz. Sends measured child extents and graph edges as DOT, reads plain node geometry, and measures/positions the original layout children. One Bloc unit corresponds to one Graphviz point (72 per inch). Edge drawing remains the scene's responsibility.
"
Class {
	#name : #GtGraphvizLayout,
	#superclass : #GtGraphEdgeDrivenLayout,
	#instVars : [
		'engine',
		'graphAttributes',
		'nodeAttributes',
		'edgeAttributes',
		'edgeRoutes'
	],
	#category : #'GToolkit-Graphviz-Layouts'
}

{ #category : #layout }
GtGraphvizLayout >> doExecute: nodes with: anExtentSpec [
	| geometry plain |
	plain := (self plainLayoutFor: (self dotFor: nodes)) utf8Decoded.
	geometry := self geometryFromPlain: plain.
	edgeRoutes := self edgeRoutesFromPlain: plain.
	nodes withIndexDo: [ :node :index | | rectangle |
		rectangle := geometry at: 'n', index asString.
		node userData at: #graphvizSourceCenter put: rectangle center.
		node measure: (BlExtentMeasurementSpec exact: rectangle extent).
		self translator translate: node to: rectangle origin ]
]

{ #category : #private }
GtGraphvizLayout >> dotFor: nodes [
	| ids defaults |
	ids := IdentityDictionary new.
	nodes withIndexDo: [ :node :index | ids at: node put: 'n', index asString ].
	defaults := OrderedDictionary new.
	defaults at: 'shape' put: 'box'.
	nodeAttributes keysAndValuesDo: [ :key :value | defaults at: key put: value ].
	defaults at: 'fixedsize' put: 'true'; at: 'label' put: ''.
	^ String streamContents: [ :stream |
		stream nextPutAll: 'digraph {'; cr; nextPutAll: 'graph '.
		self writeAttributes: graphAttributes on: stream.
		stream nextPutAll: 'node '.
		self writeAttributes: defaults on: stream.
		stream nextPutAll: 'edge '.
		self writeAttributes: edgeAttributes on: stream.
		nodes do: [ :node |
			stream nextPutAll: (ids at: node); nextPutAll: ' [width="';
				nextPutAll: ((node extent x max: 1) / 72.0) asString;
				nextPutAll: '",height="'; nextPutAll: ((node extent y max: 1) / 72.0) asString;
				nextPutAll: '"];'; cr ].
		self edgesDo: [ :edge |
			stream nextPutAll: (ids at: edge fromNode); nextPutAll: ' -> ';
				nextPutAll: (ids at: edge toNode); nextPutAll: ';'; cr ].
		stream nextPutAll: '}' ]
]

{ #category : #options }
GtGraphvizLayout >> edgeAttribute: name value: value [
	edgeAttributes at: name asString put: value asString
]

{ #category : #private }
GtGraphvizLayout >> edgeRoutesFromPlain: plain [
	"Endpoint ids map to ordered collections of routes, including parallel edges. Labels and styles are ignored."
	| height routes |
	height := nil.
	plain linesDo: [ :line | | tokens |
		tokens := line substrings.
		(tokens notEmpty and: [ tokens first = 'graph' ]) ifTrue: [ height := tokens fourth asNumber * 72 ] ].
	height ifNil: [ self error: 'Graphviz plain output has no graph bounds' ].
	routes := Dictionary new.
	plain linesDo: [ :line | | tokens count points key |
		tokens := line substrings.
		(tokens notEmpty and: [ tokens first = 'edge' ]) ifTrue: [
			count := tokens fourth asInteger.
			points := (1 to: count) collect: [ :i |
				((tokens at: 3 + (i * 2)) asNumber * 72) @ (height - ((tokens at: 4 + (i * 2)) asNumber * 72)) ].
			key := tokens second -> tokens third.
			(routes at: key ifAbsentPut: [ OrderedCollection new ]) add: points ] ].
	^ routes
]

{ #category : #accessing }
GtGraphvizLayout >> engine [
	^ engine
]

{ #category : #options }
GtGraphvizLayout >> engine: aString [
	(#('dot' 'neato' 'fdp' 'sfdp' 'circo' 'twopi' 'osage' 'patchwork') includes: aString asString)
		ifFalse: [ self error: 'Unsupported Graphviz layout engine' ].
	engine := aString asString
]

{ #category : #private }
GtGraphvizLayout >> geometryFromPlain: plain [
	"Map synthetic ids to rectangles. Plain coordinates are inches, with a bottom-left origin."
	| height records geometry |
	height := nil.
	records := OrderedCollection new.
	plain linesDo: [ :line | | tokens |
		tokens := line substrings.
		tokens ifNotEmpty: [
			tokens first = 'graph' ifTrue: [ height := tokens fourth asNumber * 72 ].
			tokens first = 'node' ifTrue: [ records add: tokens ] ] ].
	height ifNil: [ self error: 'Graphviz plain output has no graph bounds' ].
	geometry := Dictionary new.
	records do: [ :tokens | | center extent |
		center := (tokens third asNumber * 72) @ (tokens fourth asNumber * 72).
		extent := (tokens fifth asNumber * 72) @ (tokens sixth asNumber * 72).
		geometry at: tokens second put:
			((center x - (extent x / 2)) @ (height - center y - (extent y / 2)) extent: extent) ].
	^ geometry
]

{ #category : #options }
GtGraphvizLayout >> graphAttribute: name value: value [
	"Values are literal DOT attribute values, not raw DOT expressions. Numeric units follow Graphviz documentation (usually inches)."
	graphAttributes at: name asString put: value asString
]

{ #category : #initialization }
GtGraphvizLayout >> initialize [
	super initialize.
	engine := 'dot'.
	graphAttributes := OrderedDictionary new.
	nodeAttributes := OrderedDictionary new.
	edgeAttributes := OrderedDictionary new
]

{ #category : #layout }
GtGraphvizLayout >> measure: element with: extentSpec [
	| layoutNodes ids centers |
	edgeRoutes := Dictionary new.
	super measure: element with: extentSpec.
	layoutNodes := (element userData at: #layoutNode) children.
	ids := IdentityDictionary new.
	centers := IdentityDictionary new.
	layoutNodes withIndexDo: [ :node :i |
		ids at: node element put: 'n', i asString.
		centers at: node element put: (node userData at: #graphvizSourceCenter) ].
	element children do: [ :child |
		(child respondsTo: #graphvizApplyRoutes:nodeIds:sourceCenters:) ifTrue: [
			child graphvizApplyRoutes: edgeRoutes nodeIds: ids sourceCenters: centers ] ].
	self measureIgnored: element with: extentSpec
]

{ #category : #options }
GtGraphvizLayout >> nodeAttribute: name value: value [
	"Default node attributes. Geometry and labels remain controlled by Bloc."
	(#('width' 'height' 'fixedsize' 'label') includes: name asString)
		ifTrue: [ self error: 'Node geometry and labels are controlled by Bloc' ].
	nodeAttributes at: name asString put: value asString
]

{ #category : #options }
GtGraphvizLayout >> nodeSeparation: inches [
	self graphAttribute: 'nodesep' value: inches
]

{ #category : #options }
GtGraphvizLayout >> overlap: value [
	self graphAttribute: 'overlap' value: value
]

{ #category : #'private - native layout' }
GtGraphvizLayout >> plainDataForGraph: graph context: context library: gvc [
	| dataSlot lengthSlot data status |
	dataSlot := ExternalAddress allocate: ExternalAddress wordSize.
	^ [
		dataSlot pointerAt: 1 put: ExternalAddress null.
		lengthSlot := ExternalAddress allocate: 4.
		[
			lengthSlot unsignedLongAt: 1 put: 0.
			[
				status := gvc render: graph context: context format: 'plain' data: dataSlot length: lengthSlot.
				status = 0 ifFalse: [ self error: 'Graphviz geometry export failed' ].
				data := dataSlot pointerAt: 1.
				data isNull ifTrue: [ self error: 'Graphviz returned no geometry data' ].
				data copyFrom: 1 to: (lengthSlot unsignedLongAt: 1)
			] ensure: [
				data := dataSlot pointerAt: 1.
				data isNull ifFalse: [ gvc freeRenderData: data ] ]
		] ensure: [ lengthSlot free ]
	] ensure: [ dataSlot free ]
]

{ #category : #'private - native layout' }
GtGraphvizLayout >> plainLayoutFor: dot [
	"Return owned geometry bytes. Native pointers remain local. Call serially."
	| gvc cgraph context graph input |
	(dot includes: Character null) ifTrue: [ self error: 'DOT input contains a null character' ].
	gvc := GtGraphvizGvcLibrary uniqueInstance.
	cgraph := GtGraphvizCgraphLibrary uniqueInstance.
	context := gvc createContext.
	context isNull ifTrue: [ self error: 'Graphviz could not create a context' ].
	^ [
		input := ExternalAddress fromString: dot.
		graph := [ cgraph read: input ] ensure: [ input free ].
		graph isNull ifTrue: [ self error: 'Graphviz could not parse DOT input' ].
		[
			(gvc layout: graph context: context engine: engine) = 0
				ifFalse: [ self error: 'Graphviz layout failed: ', engine ].
			[ self plainDataForGraph: graph context: context library: gvc ]
				ensure: [ gvc freeLayout: graph context: context ]
		] ensure: [ cgraph close: graph ]
	] ensure: [ gvc freeContext: context ]
]

{ #category : #private }
GtGraphvizLayout >> quotedDotValue: value [
	^ String streamContents: [ :stream |
		stream nextPut: $".
		value asString do: [ :character |
			(character = $" or: [ character = $\ ]) ifTrue: [ stream nextPut: $\ ].
			character = Character lf
				ifTrue: [ stream nextPutAll: '\n' ]
				ifFalse: [ character = Character cr
					ifTrue: [ stream nextPutAll: '\r' ]
					ifFalse: [ stream nextPut: character ] ] ].
		stream nextPut: $" ]
]

{ #category : #options }
GtGraphvizLayout >> rankDirection: direction [
	(#('TB' 'BT' 'LR' 'RL') includes: direction asString)
		ifFalse: [ self error: 'Expected TB, BT, LR or RL' ].
	self graphAttribute: 'rankdir' value: direction
]

{ #category : #options }
GtGraphvizLayout >> rankSeparation: inches [
	self graphAttribute: 'ranksep' value: inches
]

{ #category : #options }
GtGraphvizLayout >> splines: value [
	"Select Graphviz routing. Routes are applied to BlGraphvizEdgeElement children; ordinary lines retain their own anchors."
	self graphAttribute: 'splines' value: value
]

{ #category : #private }
GtGraphvizLayout >> writeAttributes: attributes on: stream [
	stream nextPut: $[.
	attributes keysAndValuesDo: [ :key :value |
		stream nextPutAll: (self quotedDotValue: key); nextPut: $=;
			nextPutAll: (self quotedDotValue: value); nextPut: $; ].
	stream nextPutAll: '];'; cr
]
