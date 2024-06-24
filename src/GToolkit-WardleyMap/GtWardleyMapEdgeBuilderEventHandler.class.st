Class {
	#name : #GtWardleyMapEdgeBuilderEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'containerElement',
		'lineToAnchorElement',
		'lineElement'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapEdgeBuilderEventHandler >> containerElement [
	^ containerElement
]

{ #category : #accessing }
GtWardleyMapEdgeBuilderEventHandler >> containerElement: anObject [
	containerElement := anObject
]

{ #category : #'dnd handlers' }
GtWardleyMapEdgeBuilderEventHandler >> dragEndEvent: anEvent [
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
GtWardleyMapEdgeBuilderEventHandler >> dragEvent: anEvent [
	anEvent consumed: true.
	
	lineToAnchorElement
		ifNil: [ ^ self ].	
	
	self relocateLineAnchorTo: anEvent position
]

{ #category : #'dnd handlers' }
GtWardleyMapEdgeBuilderEventHandler >> dragStartEvent: anEvent [
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
GtWardleyMapEdgeBuilderEventHandler >> eventsToHandle [
	^ { BlDragStartEvent . BlDragEvent . BlDragEndEvent }
]

{ #category : #private }
GtWardleyMapEdgeBuilderEventHandler >> lineAnchorExtent [
	^ 6@6
]

{ #category : #private }
GtWardleyMapEdgeBuilderEventHandler >> relocateLineAnchorTo: aGlobalPosition [
	lineToAnchorElement relocate: (self containerElement globalPointToLocal: aGlobalPosition)- (self lineAnchorExtent / 2.0)
]

{ #category : #'api - event managing' }
GtWardleyMapEdgeBuilderEventHandler >> wantsEvent: anEvent [
	(anEvent isKindOf: BlDragStartEvent)
		ifTrue: [ ^ anEvent modifiers isPrimaryModifier ].

	^ super wantsEvent: anEvent
]
