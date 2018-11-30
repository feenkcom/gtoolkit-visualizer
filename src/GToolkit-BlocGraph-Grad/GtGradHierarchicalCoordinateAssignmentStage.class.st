Class {
	#name : #GtGradHierarchicalCoordinateAssignmentStage,
	#superclass : #GtGradHierarchicalLayoutStage,
	#instVars : [
		'intraRankSpacing',
		'interRanksSpacing',
		'parallelEdgeSpacing',
		'nodesConnectionBuffer',
		'maxIterations',
		'preferredHorizontalEdgesSeparation',
		'prefferedVerticalEdgesOffset',
		'minEdgeJetty',
		'channelBuffer',
		'jettyPositionsDictionary',
		'initalX',
		'limitX',
		'currentXDelta',
		'topYPerRank',
		'bottomYPerRank',
		'widestRankValue',
		'rankWidths',
		'rankYvalues',
		'fineTuning',
		'nextLayerConnectedElementsCache',
		'previousLayerConnectedCache'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> bottomYPerRank [
	^ bottomYPerRank
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> bottomYPerRank: anObject [
	bottomYPerRank := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> channelBuffer [
	^ channelBuffer
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> channelBuffer: anObject [
	channelBuffer := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> currentXDelta [
	^ currentXDelta
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> currentXDelta: anObject [
	currentXDelta := anObject
]

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> execute: parent [
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> fineTuning [
	^ fineTuning
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> fineTuning: anObject [
	fineTuning := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> initalX [
	^ initalX
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> initalX: anObject [
	initalX := anObject
]

{ #category : #initialization }
GtGradHierarchicalCoordinateAssignmentStage >> initialize [
	self intraRankSpacing: 30.
	self interRanksSpacing: 30.
	self parallelEdgeSpacing: 4.
	self nodesConnectionBuffer: 0.
	self maxIterations: 8.
	self preferredHorizontalEdgesSeparation: 5.
	self prefferedVerticalEdgesOffset: 2.
	self minEdgeJetty: 12.
	self channelBuffer: 4.
	self jettyPositionsDictionary: IdentityDictionary new.
	self fineTuning: true.
	
	
	
	
	
	
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> interRanksSpacing [
	^ interRanksSpacing
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> interRanksSpacing: anObject [
	interRanksSpacing := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> intraRankSpacing [
	^ intraRankSpacing
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> intraRankSpacing: anObject [
	intraRankSpacing := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> jettyPositionsDictionary [
	^ jettyPositionsDictionary
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> jettyPositionsDictionary: anObject [
	jettyPositionsDictionary := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> limitX [
	^ limitX
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> limitX: anObject [
	limitX := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> maxIterations [
	^ maxIterations
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> maxIterations: anObject [
	maxIterations := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> minEdgeJetty [
	^ minEdgeJetty
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> minEdgeJetty: anObject [
	minEdgeJetty := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> nextLayerConnectedElementsCache [
	^ nextLayerConnectedElementsCache
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> nextLayerConnectedElementsCache: anObject [
	nextLayerConnectedElementsCache := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> nodesConnectionBuffer [
	^ nodesConnectionBuffer
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> nodesConnectionBuffer: anObject [
	nodesConnectionBuffer := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> parallelEdgeSpacing [
	^ parallelEdgeSpacing
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> parallelEdgeSpacing: anObject [
	parallelEdgeSpacing := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> preferredHorizontalEdgesSeparation [
	^ preferredHorizontalEdgesSeparation
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> preferredHorizontalEdgesSeparation: anObject [
	preferredHorizontalEdgesSeparation := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> prefferedVerticalEdgesOffset [
	^ prefferedVerticalEdgesOffset
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> prefferedVerticalEdgesOffset: anObject [
	prefferedVerticalEdgesOffset := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> previousLayerConnectedCache [
	^ previousLayerConnectedCache
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> previousLayerConnectedCache: anObject [
	previousLayerConnectedCache := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> rankWidths [
	^ rankWidths
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> rankWidths: anObject [
	rankWidths := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> rankYvalues [
	^ rankYvalues
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> rankYvalues: anObject [
	rankYvalues := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> topYPerRank [
	^ topYPerRank
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> topYPerRank: anObject [
	topYPerRank := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> widestRankValue [
	^ widestRankValue
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> widestRankValue: anObject [
	widestRankValue := anObject
]
