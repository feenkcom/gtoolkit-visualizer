Class {
	#name : #GtWardleyMapScriptExporter,
	#superclass : #Object,
	#instVars : [
		'wardleyMap',
		'script',
		'stream',
		'targetCanvasExtent',
		'newLine',
		'isNewPipelineSyntax'
	],
	#category : #'GToolkit-WardleyMap-Exporter/Importer'
}

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> basicExportNode: aNode [
	stream
		nextPutAll: 'component ';
		nextPutAll: aNode label;
		nextPutAll: ' ['.
	self printNodeCoordinate: aNode.
	stream
		nextPutAll: '] label ['.
	self printLabelCoordinateInPixels: aNode.
	stream
		nextPutAll: ']'.
	self newLine.
	
	aNode isPipelineVisible ifTrue: [ 
		stream
			nextPutAll: 'pipeline ';
			nextPutAll: aNode label.
		isNewPipelineSyntax ifFalse: [
			stream nextPutAll: ' ['.
			self printPipelineCoordinate: aNode.
			stream nextPutAll: ']' ].
		self newLine. ]
]

{ #category : #'api - initialization' }
GtWardleyMapScriptExporter >> beCrLfNewLine [
	newLine := #crlf
]

{ #category : #'api - initialization' }
GtWardleyMapScriptExporter >> beCrNewLine [
	newLine := #cr
]

{ #category : #'api - initialization' }
GtWardleyMapScriptExporter >> beLfNewLine [
	newLine := #lf
]

{ #category : #'api - initialization' }
GtWardleyMapScriptExporter >> beNewPipelineSyntax [
	isNewPipelineSyntax := true
]

{ #category : #'api - initialization' }
GtWardleyMapScriptExporter >> beOldPipelineSyntax [
	isNewPipelineSyntax := false
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> computeInnerNodeY: anInnerNode [

	| aPipelineNode anOffset aPipelinePixelsY anInnerNodePixelsY |
	aPipelineNode := anInnerNode pipelineNode.

	aPipelinePixelsY := anInnerNode y * self targetCanvasExtent y.
	anOffset := GtWardleyMapUtility  
		computePipelineModelVerticalCenterOffset: aPipelineNode
		pipelineHeight: GtWardleyMapConstants  externalPipelineHeight.
	anInnerNodePixelsY := aPipelinePixelsY + anOffset.
	
	^ anInnerNodePixelsY / self targetCanvasExtent y
]

{ #category : #convenience }
GtWardleyMapScriptExporter >> edges [
	^ self wardleyMap edges
]

{ #category : #convenience }
GtWardleyMapScriptExporter >> evolveNodes [
	^ self nodes select: [ :each | each type isEvolveTargetType ]
]

{ #category : #'api - export' }
GtWardleyMapScriptExporter >> export [
	wardleyMap ifNil: [ 
		script := ''.
		^ self ].

	script := String streamContents: [ :aStream | 
		stream := aStream.

		self exportMap.
		
		self notes do: [ :eachNote | 
			self exportNote: eachNote ].
		self notes ifNotEmpty: [ self newLine ].
		
		self regularNodes do: [ :eachNode | 
			eachNode pipelineNode ifNil: [
				self exportNode: eachNode ] ].
		self newLine.
		
		self evolveNodes ifNotEmpty: [ :aCollection |
			aCollection do: [ :eachNode | 
				self exportEvolve: eachNode ].
			self newLine.
			self newLine.
		].
		self regularEdges do: [ :eachEdge | self exportEdge: eachEdge ].
		
		stream := nil ]
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> exportEdge: anEdge [
	stream
		nextPutAll: anEdge fromNode label;
		nextPutAll: '->';
		nextPutAll: anEdge toNode label.
	self newLine.
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> exportEvolve: anEvolveNode [
	| aSourceNode aLabel |
	self assert: [ anEvolveNode pipelineNode isNil ].
	
	aSourceNode := anEvolveNode type sourceNode.
	aLabel := aSourceNode label = anEvolveNode label 
		ifTrue: [ anEvolveNode label ]
		ifFalse: [ '{1} -> {2}' format: { aSourceNode label. anEvolveNode label } ].
	
	stream
		nextPutAll: 'evolve ';
		nextPutAll: aLabel;
		space;
		nextPutAll: (self roundedNodeCoordinate: anEvolveNode x);
		nextPutAll: ' label ['.
	self printLabelCoordinateInPixels: anEvolveNode.
	stream
		nextPutAll: ']'.
	self newLine.
]

{ #category : #'api - export' }
GtWardleyMapScriptExporter >> exportMap [
	stream nextPutAll: 'style wardley'.
	self newLine.
	self newLine.

	wardleyMap title ifNotNil: [ :aTitle |
		stream 
			nextPutAll: 'title ';
			nextPutAll: aTitle.
			
		self newLine.
		self newLine.
	]
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> exportNewSyntaxNode: aNode [
	"Export using new pipeline syntax"
	self assert: [ aNode pipelineNode isNil ].
	
	"First write down the pipeline (parent) node"
	self basicExportNode: aNode.
	
	"then write down inner nodes"
	aNode innerNodes ifNotEmpty: [
		stream nextPut: ${.
		self newLine.
		aNode innerNodes do: [ :eachInnerNode | 
			self basicExportNode: eachInnerNode.
		].
		stream nextPut: $}.
		self newLine
	].
	
	"and split the group by an empty line"
	self newLine.
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> exportNode: aNode [
	isNewPipelineSyntax
		ifTrue: [ self exportNewSyntaxNode: aNode ]
		ifFalse: [ self exportOldSyntaxNode: aNode ]
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> exportNote: aNote [
	stream
		nextPutAll: 'note ';
		nextPutAll: aNote label.
	self printCoordinate: aNote coordinate.
	self newLine.
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> exportOldSyntaxNode: aNode [
	"Export using old pipeline syntax"
	self assert: [ aNode pipelineNode isNil ].
	
	"First write down inner nodes"
	aNode innerNodes do: [ :eachInnerNode | 
		self basicExportNode: eachInnerNode.
	].
	
	"then the pipeline (parent) node"
	self basicExportNode: aNode.
	
	"and split the group by an empty line"
	self newLine.
]

{ #category : #initialization }
GtWardleyMapScriptExporter >> initialize [
	super initialize.
	
	newLine := #cr.
	isNewPipelineSyntax := true.
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> newLine [
	newLine value: stream
]

{ #category : #convenience }
GtWardleyMapScriptExporter >> nodes [
	^ self wardleyMap nodes
]

{ #category : #convenience }
GtWardleyMapScriptExporter >> notes [
	^ self wardleyMap notes
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> printCoordinate: aCoordinate [
	stream
		nextPutAll: ' [';
		nextPutAll: (self roundedNodeCoordinate: 1 - aCoordinate y);
		nextPutAll: ', ';
		nextPutAll: (self roundedNodeCoordinate: aCoordinate x);
		nextPutAll: ']'
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> printLabelCoordinateInPixels: aNode [
	"I label coordinate to pixels.
	I label coordinate is a relative position of the label center in node widget that has frame layout.
	If the node size is 12@12, 
		and label coordinate is 1@1, the pixel center coordinate is 12@12,
		which we need to transform to top-left label coordinate."
	
	| aCenterX aCenterY aLeftX aCharCount aCharWidth aCharHalfHeight aTopY |
	aCenterX := aNode size x * aNode labelModel x.
	aCenterY := aNode size y * aNode labelModel y.

	aCharCount := aNode label size.
	aCharWidth := 8.
	aCharHalfHeight := 5.
	
	aLeftX := aCenterX - (aCharCount / 2 * aCharWidth).
	aTopY := aCenterY + aCharHalfHeight.
	
	stream 
		nextPutAll: ((aLeftX roundTo: 1) printShowingDecimalPlaces: 0);
		nextPutAll: ', ';
		nextPutAll: ((aTopY roundTo: 1) printShowingDecimalPlaces: 0).
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> printNodeCoordinate: aNode [
	| aNormalizedY |
	aNormalizedY := aNode pipelineNode
			ifNotNil: [ 1 - (self computeInnerNodeY: aNode) ]
			ifNil: [ 1 - aNode y ].

	(isNewPipelineSyntax and: [ aNode pipelineNode isNotNil ]) ifFalse: [ 
		stream
			nextPutAll: (self roundedNodeCoordinate: aNormalizedY);
			nextPutAll: ', ' ].
	stream nextPutAll: (self roundedNodeCoordinate: aNode x)
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> printPipelineCoordinate: aNode [
	| aLeftValue aRightValue |
	
	aLeftValue := aNode pipelineCoordinate x" + GtWardleyMapConstants pipelineRelativeOffset".
	aRightValue := aNode pipelineCoordinate y" - GtWardleyMapConstants pipelineRelativeOffset".
	
	stream
		nextPutAll: (self roundedNodeCoordinate: aLeftValue);
		nextPutAll: ', ';
		nextPutAll: (self roundedNodeCoordinate: aRightValue).
]

{ #category : #convenience }
GtWardleyMapScriptExporter >> regularEdges [
	^ self edges select: [ :each | each toNode type isRegularType ]
]

{ #category : #convenience }
GtWardleyMapScriptExporter >> regularNodes [
	^ self nodes select: [ :each | each type isRegularType ]
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> roundedNodeCoordinate: aNumber [
	"#ceiling is used because if works in our tested examples.
	With more examples, we may find better way to calculate final value."

	| aRoundedValue |
	"aRoundedValue := aNumber roundTo: 0.001."
	aRoundedValue := (aNumber * 100) ceiling / 100.

	^ aRoundedValue printShowingDecimalPlaces: 2
]

{ #category : #accessing }
GtWardleyMapScriptExporter >> script [
	^ script
]

{ #category : #accessing }
GtWardleyMapScriptExporter >> targetCanvasExtent [
	"The default extent was taken from a https://onlinewardleymaps.com website,
	inspecting a HTML elements. It was an optimal canvas extent of a particular
	wardley map graph for which all nodes where nicely located."

	^ targetCanvasExtent ifNil: [ targetCanvasExtent := GtWardleyMapConstants externalCanvasExtent ]
]

{ #category : #accessing }
GtWardleyMapScriptExporter >> targetCanvasExtent: aPoint [
	targetCanvasExtent := aPoint
]

{ #category : #accessing }
GtWardleyMapScriptExporter >> wardleyMap [
	^ wardleyMap
]

{ #category : #accessing }
GtWardleyMapScriptExporter >> wardleyMap: anObject [
	wardleyMap := anObject
]
