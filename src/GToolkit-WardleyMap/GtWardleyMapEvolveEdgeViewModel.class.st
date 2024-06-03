Class {
	#name : #GtWardleyMapEvolveEdgeViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'evolveViewModel',
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
	^ evolveViewModel
]

{ #category : #accessing }
GtWardleyMapEvolveEdgeViewModel >> evolveViewModel: anObject [
	evolveViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapEvolveEdgeViewModel >> fromNodeViewModel [
	^ evolveViewModel nodeViewModel
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
	^ evolveViewModel nodeColor
]

{ #category : #'api - edge' }
GtWardleyMapEvolveEdgeViewModel >> lineWidth [
	^ GtWardleyMapConstants edgeWidth
]

{ #category : #accessing }
GtWardleyMapEvolveEdgeViewModel >> toNodeViewModel [
	^ evolveViewModel
]

{ #category : #accessing }
GtWardleyMapEvolveEdgeViewModel >> wardleyMapViewModel [
	^ wardleyMapViewModel
]

{ #category : #accessing }
GtWardleyMapEvolveEdgeViewModel >> wardleyMapViewModel: anObject [
	wardleyMapViewModel := anObject
]
