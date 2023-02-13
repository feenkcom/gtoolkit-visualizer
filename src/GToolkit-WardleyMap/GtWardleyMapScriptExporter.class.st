Class {
	#name : #GtWardleyMapScriptExporter,
	#superclass : #Object,
	#instVars : [
		'wardleyMap',
		'script',
		'stream',
		'targetCanvasExtent'
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
		nextPutAll: ']';
		lf.
	
	aNode isPipelineVisible ifTrue: [ 
		stream
			nextPutAll: 'pipeline ';
			nextPutAll: aNode label;
			nextPutAll: ' ['.
		self printPipelineCoordinate: aNode.
		stream
			nextPutAll: ']';
			lf ]
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> computeInnerNodeY: anInnerNode [

	| aPipelineNode anOffset aPipelinePixelsY anInnerNodePixelsY |
	aPipelineNode := anInnerNode pipelineNode.

	aPipelinePixelsY := anInnerNode y * self targetCanvasExtent y.
	anOffset := GtWardleyMapUtility  computePipelineModelVerticalCenterOffset: aPipelineNode.
	anInnerNodePixelsY := aPipelinePixelsY + anOffset.
	
	^ anInnerNodePixelsY / self targetCanvasExtent y
]

{ #category : #convenience }
GtWardleyMapScriptExporter >> edges [
	^ self wardleyMap edges
]

{ #category : #'api - export' }
GtWardleyMapScriptExporter >> export [
	wardleyMap ifNil: [ 
		script := ''.
		^ self ].

	script := String streamContents: [ :aStream | 
		stream := aStream.

		self exportMap.
		
		self nodes do: [ :eachNode | 
			eachNode pipelineNode ifNil: [
				self exportNode: eachNode ] ].
				
		stream lf.
		self edges do: [ :eachEdge | self exportEdge: eachEdge ].
		
		stream := nil ]
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> exportEdge: anEdge [
	^ stream
		nextPutAll: anEdge fromNode label;
		nextPutAll: '->';
		nextPutAll: anEdge toNode label;
		lf
]

{ #category : #'api - export' }
GtWardleyMapScriptExporter >> exportMap [
	stream nextPutAll: 'style wardley'; cr; cr.

	wardleyMap title ifNotNil: [ :aTitle |
		stream 
			nextPutAll: 'title ';
			nextPutAll: aTitle;
			lf;
			lf
	]
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> exportNode: aNode [
	
	aNode innerNodes do: [ :eachInnerNode | 
		self basicExportNode: eachInnerNode.
	].
	
	self basicExportNode: aNode.
	
	aNode pipelineNode ifNotNil: [ stream lf; lf ]
]

{ #category : #convenience }
GtWardleyMapScriptExporter >> nodes [
	^ self wardleyMap nodes
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

	stream
		nextPutAll: (self roundedNodeCoordinate: aNormalizedY);
		nextPutAll: ', ';
		nextPutAll: (self roundedNodeCoordinate: aNode x)
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> printPipelineCoordinate: aNode [
	| aLeftValue aRightValue |
	
	aLeftValue := aNode pipelineCoordinate x + GtWardleyMapConstants pipelineRelativeOffset.
	aRightValue := aNode pipelineCoordinate y - GtWardleyMapConstants pipelineRelativeOffset.
	
	stream
		nextPutAll: (self roundedNodeCoordinate: aLeftValue);
		nextPutAll: ', ';
		nextPutAll: (self roundedNodeCoordinate: aRightValue).
]

{ #category : #'private - exporting' }
GtWardleyMapScriptExporter >> roundedNodeCoordinate: aNumber [
	| aRoundedValue |
	aRoundedValue := aNumber roundTo: 0.01.
	
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

	^ targetCanvasExtent ifNil: [ targetCanvasExtent := 1024 @ 716 "958 @ 705" ]
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
