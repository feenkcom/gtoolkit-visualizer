Class {
	#name : #GtWardleyMapEdgeBuilder,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'containerElement',
		'lineToAnchorElement',
		'lineElement'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapEdgeBuilder >> containerElement [
	^ containerElement
]

{ #category : #accessing }
GtWardleyMapEdgeBuilder >> containerElement: anObject [
	containerElement := anObject
]

{ #category : #'dnd handlers' }
GtWardleyMapEdgeBuilder >> dragEndEvent: anEvent [
	anEvent consumed: true.
	
	lineToAnchorElement
		ifNil: [ ^ self ].

	lineToAnchorElement removeFromParent.
	lineElement removeFromParent.

	self containerElement
		childrenAt: (self containerElement globalPointToLocal: anEvent position)
		do: [ :eachChild |
			eachChild graph isNode
				ifTrue: [
					^ self containerElement wardleyMapViewModel
						addNewEdgeFrom: anEvent currentTarget wardleyMapNodeViewModel
						to: eachChild wardleyMapNodeViewModel ] ]
]

{ #category : #'dnd handlers' }
GtWardleyMapEdgeBuilder >> dragEvent: anEvent [
	anEvent consumed: true.
	
	lineToAnchorElement
		ifNil: [ ^ self ].	
	
	self relocateLineAnchorTo: anEvent position
]

{ #category : #'dnd handlers' }
GtWardleyMapEdgeBuilder >> dragStartEvent: anEvent [
	anEvent consumed: true.
	
	lineToAnchorElement
		ifNotNil: [ lineToAnchorElement removeFromParent ].

	lineToAnchorElement := BlElement new
		size: self lineAnchorExtent;
		background: anEvent currentTarget wardleyMapNodeViewModel nodeColor;
		geometry: BlEllipseGeometry new;
		constraintsDo: [ :c | c ignoreByLayout ].
	self relocateLineAnchorTo: anEvent position.

	lineElement := BlLineElement new
		fromAnchor: (BlNearestPositionEllipseAnchor referenceElement: lineToAnchorElement relatedTo: anEvent currentTarget);
		toAnchor: (BlNearestPositionEllipseAnchor referenceElement: anEvent currentTarget relatedTo: lineToAnchorElement);
		border: (BlBorder paint: anEvent currentTarget wardleyMapNodeViewModel nodeColor width: 1).

	self containerElement addChildren: { lineToAnchorElement . lineElement }
]

{ #category : #'api - accessing' }
GtWardleyMapEdgeBuilder >> eventsToHandle [
	^ { BlDragStartEvent . BlDragEvent . BlDragEndEvent }
]

{ #category : #private }
GtWardleyMapEdgeBuilder >> lineAnchorExtent [
	^ 6@6
]

{ #category : #private }
GtWardleyMapEdgeBuilder >> relocateLineAnchorTo: aGlobalPosition [
	lineToAnchorElement relocate: (self containerElement globalPointToLocal: aGlobalPosition)- (self lineAnchorExtent / 2.0)
]

{ #category : #'api - event managing' }
GtWardleyMapEdgeBuilder >> wantsEvent: anEvent [
	(anEvent isKindOf: BlDragStartEvent)
		ifTrue: [ ^ anEvent modifiers isPrimaryModifier ].

	^ super wantsEvent: anEvent
]
