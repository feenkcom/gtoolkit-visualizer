Class {
	#name : #GtWardleyMapNodePullDirection,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'event handling' }
GtWardleyMapNodePullDirection class >> fromDragDelta: aDragDelta [
	| anX anY |
	anX := aDragDelta x abs.
	anY := aDragDelta y abs.

	(anX <= anY and: [ anY < 7 ])
		ifTrue: [ ^ GtWardleyMapNodeHorizontalPullDirection ].

	^ GtWardleyMapNodeVerticalPullDirection
]

{ #category : #'event handling' }
GtWardleyMapNodePullDirection class >> onPullFinished: aNodeElement mapElement: aMapElement [
	self subclassResponsibility
]
