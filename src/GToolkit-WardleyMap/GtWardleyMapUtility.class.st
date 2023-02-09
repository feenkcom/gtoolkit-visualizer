Class {
	#name : #GtWardleyMapUtility,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - import and export' }
GtWardleyMapUtility class >> convertWardleyScriptNodeModel: aNodeModel labelCoordiante: aPoint [ 
	"Conversion is just an estimate. 
	It is not possible to get two visually identical outputs, 
	because the values are affected by variables such as the size of the Wardley area, 
	the used font, etc."

	| aCharCount aCharWidth aCharHalfHeight aLabelX aLabelY aNodeSize |
	aCharCount := aNodeModel label size.
	aCharWidth := 8.
	aCharHalfHeight := 5.
	aNodeSize := GtWardleyMapConstants nodeSize.
	
	aLabelX := aPoint x + (aCharCount / 2 * aCharWidth).
	aLabelY := aPoint y - aCharHalfHeight.
	
	^ ((aLabelX @ aLabelY) / aNodeSize) asFloatPoint
]

{ #category : #'api - import and export' }
GtWardleyMapUtility class >> estimateInnerNodesFor: aPipelineNode among: allNodes [
	| candidateNodes aMinX aMaxX aMinY aMaxY aPipelineBounds |
	aPipelineNode isPipelineVisible ifFalse: [ ^ #() ].

	candidateNodes := allNodes select: [ :eachNode | 
		eachNode isPipelineVisible not and: [ 
			eachNode pipelineNode isNil ] ].
			
	candidateNodes ifEmpty: [ ^ #() ].
			
	aMinX := aPipelineNode pipelineCoordinate x.
	aMaxX := aPipelineNode pipelineCoordinate y.
	
	aMinY := aPipelineNode coordinate y.
	aMaxY := aMinY + (GtWardleyMapConstants pipelineRelativeOffset * 2). 
	
	aPipelineBounds := (aMinX @ aMinY) corner: (aMaxX @ aMaxY).
			
	^ candidateNodes select: [ :eachNode | 
		(aPipelineBounds containsPoint: eachNode coordinate) ].
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> isNodeElement: aNodeElement insidePipelineElement: aPipelineElement [
	^ aPipelineElement bounds inParent asRectangle
		containsRect: aNodeElement bounds inParent asRectangle

	"^ aPipelineElement bounds inParent asRectangle
		containsPoint: aNodeElement bounds inParent asRectangle center"
]

{ #category : #'event handling' }
GtWardleyMapUtility class >> snapInnerNodeViewModel: anInnerNodeViewModel inPipelineViewModel: aPipelineViewModel inCanvasElement: aCanvas [

	| aCanvasHeight aPipelineElement anInnerNodeElement aPipelineRectangle aMinY aMaxY aMiddleY |
	aCanvasHeight := aCanvas height.
	(aCanvasHeight closeTo: 0 precision: 0.1) ifTrue: [ ^ self ].
	
	aPipelineElement := aCanvas 
		pipelineViewFor: aPipelineViewModel 
		ifFound: [ :thePipelineElement | thePipelineElement ] 
		ifNone: [ ^ self ].
	
	anInnerNodeElement := aCanvas 
		nodeViewFor: anInnerNodeViewModel 
		ifFound: [ :theElement | theElement ] 
		ifNone: [ ^ self ].
		
	aPipelineRectangle := aPipelineElement bounds inParent asRectangle.
	aMinY := (aPipelineRectangle top) / aCanvasHeight.
	aMaxY := (aPipelineRectangle bottom) / aCanvasHeight.
	aMiddleY := (aMinY + ((aMaxY - aMinY) / 2)) asFloat.
	
	anInnerNodeElement constraintsDo: [ :c | 
		c frame vertical alignCenterAt: aMiddleY ]
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> updatePipelineElement: aPipelineElement nodeViewModel: aPipelineViewModel [
	aPipelineElement
		constraintsDo: [ :c | 
			c frame horizontal alignLeftAt: aPipelineViewModel pipelineCoordinateLeft.
			c frame vertical alignTopAt: aPipelineViewModel pipelineCoordinateTop.
			c frame horizontal
				weight: aPipelineViewModel pipelineCoordinateRight - aPipelineViewModel pipelineCoordinateLeft.
			c horizontal matchParent ]
]
