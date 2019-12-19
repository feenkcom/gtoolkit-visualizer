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
GtGraphTreemapSquarifyNoRectangle >> extent [
	^ 0@0
]
