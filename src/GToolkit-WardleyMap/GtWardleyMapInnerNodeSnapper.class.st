"
I keep all inner nodes snapped vertically in their corresponding pipelines.
I must be attach only to {{gtClass: GtWardleyMapCanvasElement}}.

"
Class {
	#name : #GtWardleyMapInnerNodeSnapper,
	#superclass : #BlCustomEventHandler,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - event managing' }
GtWardleyMapInnerNodeSnapper >> elementExtentChangedEvent: anEvent [
	| aCanvas aCanvasHeight |
	aCanvas := anEvent currentTarget.
	aCanvasHeight := aCanvas height.
	(aCanvasHeight closeTo: 0 precision: 0.1) ifTrue: [ ^ self ].
	
	aCanvas pipelineChildrenDo: [ :aPipelineElement | 
		aPipelineElement hasWardleyMapNodeViewModel ifTrue: [ 
			| aPipelineViewModel innerNodeViewModels |
			aPipelineViewModel := aPipelineElement wardleyMapNodeViewModel.
			innerNodeViewModels := aPipelineViewModel innerNodeViewModels.
		
			innerNodeViewModels ifNotEmpty: [
				| aPipelineRectangle aMinY aMaxY aMiddleY |
				aPipelineRectangle := aPipelineElement bounds inParent asRectangle.
				aMinY := (aPipelineRectangle top) / aCanvasHeight.
				aMaxY := (aPipelineRectangle bottom) / aCanvasHeight.
				aMiddleY := (aMinY + ((aMaxY - aMinY) / 2)) asFloat.
		
				innerNodeViewModels do: [ :anInnerNodeViewModel | 
					aCanvas 
						nodeViewFor: anInnerNodeViewModel
						ifFound: [ :anInnerNodeElement | 
							anInnerNodeElement constraintsDo: [ :c | 
								c frame vertical alignCenterAt: aMiddleY ].
							GtWardleyMapBeaconInnerNodeSnapSignal new 
								innerNodeElement: anInnerNodeElement;
								pipelineElement: aPipelineElement;
								mapElement: aCanvas;
								emit ]
						ifNone: [ ].
				]
			]
		]
	]
]

{ #category : #'api - accessing' }
GtWardleyMapInnerNodeSnapper >> eventsToHandle [
	^ {BlElementExtentChangedEvent}
]
