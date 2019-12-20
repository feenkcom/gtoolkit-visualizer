Class {
	#name : #GtGraphTreemapSquarifyNoRectangle,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #cleanup }
GtGraphTreemapSquarifyNoRectangle class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
GtGraphTreemapSquarifyNoRectangle class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
GtGraphTreemapSquarifyNoRectangle class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
GtGraphTreemapSquarifyNoRectangle >> bounds [
	^ 0@0 extent: 0@0
]

{ #category : #accessing }
GtGraphTreemapSquarifyNoRectangle >> extent [
	^ 0@0
]

{ #category : #'gt-inspector-extension' }
GtGraphTreemapSquarifyNoRectangle >> gtPreviewFor: aView [
	^ aView empty
]

{ #category : #testing }
GtGraphTreemapSquarifyNoRectangle >> isDefined [
	^ false
]

{ #category : #accessing }
GtGraphTreemapSquarifyNoRectangle >> name [
	^ 'Undefined'
]

{ #category : #accessing }
GtGraphTreemapSquarifyNoRectangle >> remainingBounds [
	^ self bounds
]
