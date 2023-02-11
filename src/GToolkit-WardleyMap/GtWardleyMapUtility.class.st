Class {
	#name : #GtWardleyMapUtility,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - views' }
GtWardleyMapUtility class >> computePipelineVerticalCenterOffset: aPipelineNodeViewModel [
	"I compute a pipeline element offset that should be used to
	place the pipeline element below its node element.
	I am used as the second argument for {{gtMethod: BlFrameLayoutConstraintsVertical >> #alignCenterAt:offset:}}.
	Note that same offset is used for inner-nodes."

	| aHalfOfNodeHeight aHalfOfPipelineHeight |
	aHalfOfNodeHeight := aPipelineNodeViewModel nodeSize y / 2.
	aHalfOfPipelineHeight := GtWardleyMapConstants pipelineHeight / 2.
	
	^ (aHalfOfNodeHeight + aHalfOfPipelineHeight) asFloat
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> computePipelineVerticalTopOffset: aPipelineNodeViewModel [
	"I compute a pipeline element offset that should be used to
	place the pipeline element below its node element.
	The offset is expected to represent top y-coordinate (bounds)."

	| aHalfOfNodeHeight |
	aHalfOfNodeHeight := aPipelineNodeViewModel nodeSize y / 2.
	
	^ aHalfOfNodeHeight asFloat
]

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
	"I ensure a minimum pipeline width.
	aPoint x is the left pipeline coordinate.
	aPoint y is the right pipeline coordinate."
	
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
	"I compute a pipeline relative width (in 0-1 coordinates).
	I use the pipeline model coordinate and its inner node coordinates.
	I may ignore a specific inner node to compute new pipeline coordinate.
	The new pipeline coordinate may be smaller compared to the pipeline width without inner nodes."

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
GtWardleyMapUtility class >> updateNodeElement: aNodeElement nodeViewModel: aNodeViewModel [
	"I update node element layout constraints, based on model values.
	If it is an inner node, we know that the y-cordinate is same as 
	its parent (pipeline) node. We therefore offset the y-coordinate 
	accordingly to be visually placed inside of a pipeline widget."

	aNodeElement constraintsDo: [ :c | 
		c frame horizontal alignCenterAt: aNodeViewModel coordinateX.
		
		aNodeViewModel pipelineNodeViewModel
			ifNil: [ c frame vertical alignCenterAt: aNodeViewModel coordinateY ]
			ifNotNil: [ :aPipelineNodeViewModel | 
				"Inner nodes has the same y-coordinates as their pipeline nodes.
				We add an offset to be in the middle of the pipelines widgets."
				c frame vertical 
					alignCenterAt: aNodeViewModel coordinateY 
					offset: (self computePipelineVerticalCenterOffset: aPipelineNodeViewModel) ].
		 ]
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> updatePipelineElement: aPipelineElement nodeViewModel: aNodeViewModel [
	"I update pipeline element layout constraints, based on model values.
	I use its node y-coordinate to place it vertically. 
	For that reason I offset the pipeline element position accordingly."

	aPipelineElement
		constraintsDo: [ :c | 
			
			"Pipeline y-coordinate."
			c frame vertical
				alignCenterAt: aNodeViewModel coordinateY
				offset: (self computePipelineVerticalCenterOffset: aNodeViewModel).

			"Pipeline x-coordinate"
			c frame horizontal alignLeftAt: aNodeViewModel pipelineCoordinateLeft.
			
			"Pipeline width"
			c frame horizontal weight: aNodeViewModel pipelineCoordinateWeight.
			c horizontal matchParent ]
]
