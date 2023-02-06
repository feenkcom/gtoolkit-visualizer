Class {
	#name : #GtWardleyMapUtility,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - views' }
GtWardleyMapUtility class >> isNodeElement: aNodeElement insidePipelineElement: aPipelineElement [
	^ aPipelineElement bounds inParent asRectangle
		containsRect: aNodeElement bounds inParent asRectangle
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> updatePipelineElement: aPipelineElement nodeViewModel: aNodeViewModel [
	aPipelineElement
		constraintsDo: [ :c | 
			c frame horizontal alignLeftAt: aNodeViewModel pipelineCoordinateLeft.
			c frame vertical alignTopAt: aNodeViewModel pipelineCoordinateTop.
			c frame horizontal
				weight: aNodeViewModel pipelineCoordinateRight - aNodeViewModel pipelineCoordinateLeft.
			c horizontal matchParent ]
]
