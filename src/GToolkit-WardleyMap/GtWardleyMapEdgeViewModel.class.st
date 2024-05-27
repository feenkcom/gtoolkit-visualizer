Class {
	#name : #GtWardleyMapEdgeViewModel,
	#superclass : #Object,
	#traits : 'TGtWithWardleyMapEdgeModel + TGtAnnouncer',
	#classTraits : 'TGtWithWardleyMapEdgeModel classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'wardleyMapViewModel',
		'fromNodeViewModel',
		'toNodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> addLineArrow [
	self wardleyMapEdgeModel arrow: true
]

{ #category : #announcer }
GtWardleyMapEdgeViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> changeColorTo: aColor [
	self wardleyMapEdgeModel color: aColor
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> decreaseWidth [
	self lineWidth: ((self lineWidth - self lineWidthStep) roundTo: 0.01)
]

{ #category : #accessing }
GtWardleyMapEdgeViewModel >> fromNodeViewModel [
	^ fromNodeViewModel
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> hasLineArrow [
	^ self wardleyMapEdgeModel arrow
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> increaseWidth [
	self lineWidth: ((self lineWidth + self lineWidthStep) roundTo: 0.01)
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> isLabelVisible [
	^ self wardleyMapEdgeModel isLabelVisible
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> isToNodeEvolveTargetType [
	^ self toNodeViewModel isEvolveTargetType
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> label [
	^ self wardleyMapEdgeModel label
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> label: aString [
	self wardleyMapEdgeModel label: aString
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> labelColor [
	^ self lineColor darker
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> labelCoordinate [
	^ self wardleyMapEdgeModel labelModel coordinate
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> labelCoordinateX [
	^ self labelCoordinate x
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> labelCoordinateY [
	^ self labelCoordinate y
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> lineColor [
	^ self wardleyMapEdgeModel color
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> lineWidth [
	^ self wardleyMapEdgeModel width
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> lineWidth: aNumber [
	self wardleyMapEdgeModel width: (aNumber max: 0)
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> lineWidthStep [
	^ ((self lineWidth // 10 + 1) max: 1)
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> moveEdgeLabelTo: aNormalizedPoint [
	self wardleyMapEdgeModel labelModel coordinate: aNormalizedPoint
]

{ #category : #'event handling' }
GtWardleyMapEdgeViewModel >> onEdgeArrowChanged: anAnnouncement [
	self announce: (GtWardleyMapEdgeViewModelColored new edgeViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapEdgeViewModel >> onEdgeColored: anAnnouncement [
	self announce: (GtWardleyMapEdgeViewModelColored new edgeViewModel: self)
]

{ #category : #'api - wardley map edge model' }
GtWardleyMapEdgeViewModel >> onEdgeLabelMoved: anAnnouncement [
	self announce: (GtWardleyMapEdgeViewModelLabelMoved new edgeViewModel: self)
]

{ #category : #'api - wardley map edge model' }
GtWardleyMapEdgeViewModel >> onEdgeLabelTextChanged: anAnnouncement [
	self announce: (GtWardleyMapEdgeViewModelLabelTextChanged new edgeViewModel: self)
]

{ #category : #'api - wardley map edge model' }
GtWardleyMapEdgeViewModel >> onEdgeLabelVisibilityChanged: anAnnouncement [
	self announce: (GtWardleyMapEdgeViewModelLabelVisibilityChanged new edgeViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapEdgeViewModel >> onEdgeResized: anAnnouncement [
	self announce: (GtWardleyMapEdgeViewModelResized new edgeViewModel: self)
]

{ #category : #'api - wardley map edge model' }
GtWardleyMapEdgeViewModel >> onTargetNodeViewModelTypeChanged: anAnnouncement [
	self announce: (GtWardleyMapEdgeViewModelTypeChanged new edgeViewModel: self)
]

{ #category : #'api - wardley map edge model' }
GtWardleyMapEdgeViewModel >> onWardleyMapEdgeModelChanged [
	"Is sent when a new wardleyMapEdge model is assigned to the view model"
	
	fromNodeViewModel := self wardleyMapViewModel
		nodeViewModelFor: self wardleyMapEdgeModel fromNode
		ifFound: [ :aNodeViewModel | aNodeViewModel ]
		ifNone: [ nil ].
		
	self unsubscribeFromTargetNode.
	toNodeViewModel := self wardleyMapViewModel
		nodeViewModelFor: self wardleyMapEdgeModel toNode
		ifFound: [ :aNodeViewModel | aNodeViewModel ]
		ifNone: [ nil ].
	self subscribeToTargetNodeViewModel
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> removeFromMap [
	self wardleyMapViewModel removeEdgeViewModel: self
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> removeLineArrow [
	self wardleyMapEdgeModel arrow: false
]

{ #category : #'api - edge' }
GtWardleyMapEdgeViewModel >> reverse [
	self wardleyMapEdgeModel reverse
]

{ #category : #'api - wardley map edge model' }
GtWardleyMapEdgeViewModel >> subscribeToTargetNodeViewModel [
	toNodeViewModel weak
		when: GtWardleyMapNodeViewModelTypeChanged
		send: #onTargetNodeViewModelTypeChanged:
		to: self
]

{ #category : #'api - wardley map edge model' }
GtWardleyMapEdgeViewModel >> subscribeToWardleyMapEdgeModel [
	"Is sent after a new wardleyMapEdge model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromWardleyMapEdgeModel if view model subscribes to them"
	
	self wardleyMapEdgeModel weak
		when: GtWardleyMapEdgeModelColored send: #onEdgeColored: to: self;
		when: GtWardleyMapEdgeModelResized send: #onEdgeResized: to: self;
		when: GtWardleyMapEdgeModelArrowChanged send: #onEdgeArrowChanged: to: self.
		
	self wardleyMapEdgeModel weak
		when: GtWardleyMapEdgeLabelModelMoved send: #onEdgeLabelMoved: to: self;
		when: GtWardleyMapEdgeLabelModelTextChanged send: #onEdgeLabelTextChanged: to: self;
		when: GtWardleyMapEdgeLabelModelVisibilityChanged send: #onEdgeLabelVisibilityChanged: to: self
]

{ #category : #accessing }
GtWardleyMapEdgeViewModel >> toNodeViewModel [
	^ toNodeViewModel
]

{ #category : #'api - wardley map edge model' }
GtWardleyMapEdgeViewModel >> unsubscribeFromTargetNode [
	toNodeViewModel ifNotNil: [ :aViewModel | aViewModel unsubscribe: self ].
]

{ #category : #'api - wardley map edge model' }
GtWardleyMapEdgeViewModel >> unsubscribeFromWardleyMapEdgeModel [
	"Is sent before a new wardleyMapEdge model is assigned to the view model.
	View models that subscribe to wardleyMapEdge model are required to implement this methods"
	
	self wardleyMapEdgeModel unsubscribe: self
]

{ #category : #accessing }
GtWardleyMapEdgeViewModel >> wardleyMapViewModel [
	^ wardleyMapViewModel
]

{ #category : #accessing }
GtWardleyMapEdgeViewModel >> wardleyMapViewModel: anObject [
	wardleyMapViewModel := anObject
]
