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
	"^ aPipelineElement bounds inParent asRectangle
		containsRect: aNodeElement bounds inParent asRectangle"

	^ aPipelineElement bounds inParent asRectangle
		containsPoint: aNodeElement bounds inParent asRectangle center
]

{ #category : #'api - model' }
GtWardleyMapUtility class >> normalizePipelineCoordinate: aPoint [ 
	"I ensure a minimum pipeline width"
	
	| aWidth anIncrease aLeft aRight |
	aWidth := aPoint y - aPoint x.
	aWidth >= GtWardleyMapConstants minPipelineRelativeWidth ifTrue: [ ^ aPoint ].
	
	anIncrease := GtWardleyMapConstants minPipelineRelativeWidth - aWidth.
		
	aLeft := aPoint x - (anIncrease / 2).
	aRight := aPoint y + (anIncrease / 2).
	aLeft < 0 ifTrue: [
		aRight := (aRight - aLeft) min: 1.0.
		aLeft := 0 ].
	aRight > 1 ifTrue: [ 
		aLeft := aLeft - (aRight - 1.0) max: 0.0.
		aRight := 1.0
	].
	
	^ aLeft @ aRight
]

{ #category : #'api - model' }
GtWardleyMapUtility class >> normalizePipelineWidthOfNodeModel: aPipelineModel ignoring: anInnerNodeModelOrNil [

	| aConstant aMinInnerNodeModel aMaxInnerNodeModel |
	aConstant := GtWardleyMapConstants pipelineRelativeOffset.

	aMinInnerNodeModel := aPipelineModel.
	aMaxInnerNodeModel := aPipelineModel.
	aPipelineModel innerNodes
		do: [ :eachNodeModel | 
			eachNodeModel == anInnerNodeModelOrNil ifFalse: [
				eachNodeModel x < aMinInnerNodeModel x 
					ifTrue: [ aMinInnerNodeModel := eachNodeModel ].
				eachNodeModel x > aMaxInnerNodeModel x 
					ifTrue: [ aMaxInnerNodeModel := eachNodeModel ] ] ].
	
	^ (aMinInnerNodeModel x - aConstant max: 0) @ (aMaxInnerNodeModel x + aConstant min: 1).
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> snapInnerNodeElement: anInnerNodeElement inPipelineElement: aPipelineElement inCanvasElement: aCanvas [
	"The problem with this implementation is that we expect that a canvas height value is a correct one.
	The same for the pipeline element bounds. Imagine situation in which we request to move the pipeline element,
	setting new constraints, and we immediately call this method to snap inner nodes. 
	It may happen that we will use old pipeline bounds to compute the inner node element position."
	
	| aCanvasHeight aPipelineRectangle aMinY aMaxY aMiddleY |

	aCanvas space ifNil: [ ^ self ].
	
	aCanvasHeight := aCanvas height.
	(aCanvasHeight closeTo: 0 precision: 0.1) ifTrue: [ ^ self ].
	
	aPipelineRectangle := aPipelineElement bounds inParent asRectangle.
	aMinY := (aPipelineRectangle top) / aCanvasHeight.
	aMaxY := (aPipelineRectangle bottom) / aCanvasHeight.
	aMiddleY := (aMinY + ((aMaxY - aMinY) / 2)) asFloat.
	
	anInnerNodeElement constraintsDo: [ :c | 
		c frame vertical alignCenterAt: aMiddleY ].
		
	GtWardleyMapBeaconInnerNodeSnapSignal new 
		innerNodeElement: anInnerNodeElement;
		pipelineElement: aPipelineElement;
		mapElement: aCanvas;
		emit
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> snapInnerNodeElementsInPipelineElement: aPipelineElement inCanvasElement: aCanvas [
	| aCanvasHeight aPipelineRectangle aMinY aMaxY aMiddleY |

	aCanvas space ifNil: [ ^ self ].
	(aCanvas height closeTo: 0 precision: 0.1) ifTrue: [ ^ self ].
	
	aPipelineElement wardleyMapNodeViewModel innerNodeViewModels do: [ :anInnerNodeViewModel | 
		aCanvas 
			nodeViewFor: anInnerNodeViewModel 
			ifFound: [ :anInnerNodeElement | 
				self
					snapInnerNodeElement: anInnerNodeElement 
					inPipelineElement: aPipelineElement 
					inCanvasElement: aCanvas ] 
			ifNone: [ ] ]
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> snapInnerNodeViewModel: anInnerNodeViewModel inPipelineViewModel: aPipelineViewModel inCanvasElement: aCanvas [
	| aPipelineElement anInnerNodeElement |
	
	aCanvas space ifNil: [ ^ self ].
	(aCanvas height closeTo: 0 precision: 0.1) ifTrue: [ ^ self ].

	aPipelineElement := aCanvas 
		pipelineViewFor: aPipelineViewModel 
		ifFound: [ :thePipelineElement | thePipelineElement ] 
		ifNone: [ ^ self ].
	
	anInnerNodeElement := aCanvas 
		nodeViewFor: anInnerNodeViewModel 
		ifFound: [ :theElement | theElement ] 
		ifNone: [ ^ self ].
		
	self 
		snapInnerNodeElement: anInnerNodeElement 
		inPipelineElement: aPipelineElement 
		inCanvasElement: aCanvas
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> updatePipelineElement: aPipelineElement nodeViewModel: aPipelineViewModel [
	aPipelineElement
		constraintsDo: [ :c | 
			c frame horizontal alignLeftAt: aPipelineViewModel pipelineCoordinateLeft.
			c frame vertical alignTopAt: aPipelineViewModel pipelineCoordinateTop.
			c frame horizontal weight: 
				aPipelineViewModel pipelineCoordinateRight - aPipelineViewModel pipelineCoordinateLeft.
			c horizontal matchParent ].
			
	GtWardleyMapBeaconPipelineMovedSignal new 
		nodeElement: aPipelineElement;
		mapElement: aPipelineElement parent;
		emit
]
