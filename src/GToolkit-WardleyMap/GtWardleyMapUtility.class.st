Class {
	#name : #GtWardleyMapUtility,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - views' }
GtWardleyMapUtility class >> isNodeElement: aNodeElement insidePipelineElement: aPipelineElement [
	^ aPipelineElement bounds inParent asRectangle
		containsRect: aNodeElement bounds inParent asRectangle

	"^ aPipelineElement bounds inParent asRectangle
		containsPoint: aNodeElement bounds inParent asRectangle center"
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
