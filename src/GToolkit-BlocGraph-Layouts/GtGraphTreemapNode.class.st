Class {
	#name : #GtGraphTreemapNode,
	#superclass : #GtGraphTreemapRectangle,
	#instVars : [
		'weight'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphTreemapNode >> aspectRatio [
	^ self width / self height
]

{ #category : #printing }
GtGraphTreemapNode >> printOn: aStream [
	aStream nextPutAll: 'Node bounds: '.
	(self position isNil or: [ self extent isNil ]) 
		ifTrue: [ aStream nextPutAll: '<uninitialized>' ]
		ifFalse: [ aStream print: self bounds ].
]

{ #category : #accessing }
GtGraphTreemapNode >> weight [
	^ weight
]

{ #category : #accessing }
GtGraphTreemapNode >> weight: aNumber [
	self
		assert: [ aNumber between: 0 and: 1 ]
		description: [ 'Treemap node weight must be between 0 and 1' ].
	weight := aNumber
]
