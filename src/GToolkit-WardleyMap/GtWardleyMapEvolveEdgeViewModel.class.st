Class {
	#name : #GtWardleyMapEvolveEdgeViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWithWardleyMapNodeViewModel',
	#classTraits : 'TGtAnnouncer classTrait + TGtWithWardleyMapNodeViewModel classTrait',
	#instVars : [
		'announcer',
		'wardleyMapViewModel'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #announcer }
GtWardleyMapEvolveEdgeViewModel >> announcer [
	<return: #Announcer>
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GtWardleyMapEvolveEdgeViewModel >> evolveViewModel [
	^ self wardleyMapNodeViewModel
]

{ #category : #accessing }
GtWardleyMapEvolveEdgeViewModel >> evolveViewModel: anObject [
	self wardleyMapNodeViewModel: anObject
]

{ #category : #accessing }
GtWardleyMapEvolveEdgeViewModel >> fromNodeViewModel [
	^ self wardleyMapNodeViewModel nodeViewModel
]

{ #category : #'api - edge' }
GtWardleyMapEvolveEdgeViewModel >> hasLineArrow [
	^ true
]

{ #category : #'api - edge' }
GtWardleyMapEvolveEdgeViewModel >> isLabelVisible [
	^ false
]

{ #category : #'api - edge' }
GtWardleyMapEvolveEdgeViewModel >> isToNodeEvolveTargetType [
	"Compatibility with the old evolve implemenation"

	^ true
]

{ #category : #'api - edge' }
GtWardleyMapEvolveEdgeViewModel >> label [
	^ 'Evolve'
]

{ #category : #'api - edge' }
GtWardleyMapEvolveEdgeViewModel >> labelColor [
	^ self lineColor darker
]

{ #category : #'api - edge' }
GtWardleyMapEvolveEdgeViewModel >> labelCoordinate [
	^ GtWardleyMapConstants edgeLabelCoordinate
]

{ #category : #'api - edge' }
GtWardleyMapEvolveEdgeViewModel >> labelCoordinateX [
	^ self labelCoordinate x
]

{ #category : #'api - edge' }
GtWardleyMapEvolveEdgeViewModel >> labelCoordinateY [
	^ self labelCoordinate y
]

{ #category : #'api - edge' }
GtWardleyMapEvolveEdgeViewModel >> lineColor [
	^ self wardleyMapNodeViewModel nodeColor
]

{ #category : #'api - edge' }
GtWardleyMapEvolveEdgeViewModel >> lineWidth [
	^ GtWardleyMapConstants edgeWidth
]

{ #category : #'event handling' }
GtWardleyMapEvolveEdgeViewModel >> onEvolveColored: anAnnouncement [
	self announce: (GtWardleyMapEdgeViewModelColored new edgeViewModel: self)
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapEvolveEdgeViewModel >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"

	
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapEvolveEdgeViewModel >> subscribeToWardleyMapNodeViewModel [
	"Is sent after a new WardleyMapNode view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeViewModel if elements subscribe to them"
	
	self wardleyMapNodeViewModel weak
		when: GtWardleyMapEvolveViewModelColored 
		send: #onEvolveColored:
		to: self
]

{ #category : #accessing }
GtWardleyMapEvolveEdgeViewModel >> toNodeViewModel [
	^ self wardleyMapNodeViewModel
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapEvolveEdgeViewModel >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
	
	self wardleyMapNodeViewModel unsubscribe: self
]

{ #category : #accessing }
GtWardleyMapEvolveEdgeViewModel >> wardleyMapViewModel [
	^ wardleyMapViewModel
]

{ #category : #accessing }
GtWardleyMapEvolveEdgeViewModel >> wardleyMapViewModel: anObject [
	wardleyMapViewModel := anObject
]
