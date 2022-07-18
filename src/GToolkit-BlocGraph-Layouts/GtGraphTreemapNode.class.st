"
I represent a {{gtClass:GtGraphTreemap}} node.
I keep my weight and the {{gtClass:GtGraphTreemap}} is responsible for computing my position and extent.


"
Class {
	#name : #GtGraphTreemapNode,
	#superclass : #GtGraphTreemapRectangle,
	#instVars : [
		'weight',
		'value',
		'totalValue'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #converting }
GtGraphTreemapNode >> asElement [
	^ super asElement
		addChild: (BrLabel new
				text: (self value asRopedText foreground: Color lightGray);
				constraintsDo: [ :c | 
					c ignoreByLayout.
					c ignored horizontal alignCenter.
					c ignored vertical alignCenter ])
]

{ #category : #accessing }
GtGraphTreemapNode >> aspectRatio [
	^ (self width / self height) max: (self height / self width)
]

{ #category : #'gt-extension' }
GtGraphTreemapNode >> gtWeightFor: aView [
	<gtView>
	self weight ifNil: [ ^ aView empty ].
	^ (self weight gtPreviewFor: aView)
		priority: 1;
		title: 'Weight'
]

{ #category : #initialization }
GtGraphTreemapNode >> initialize [
	super initialize.
	weight := 0.
]

{ #category : #printing }
GtGraphTreemapNode >> printOn: aStream [
	aStream nextPutAll: 'Node bounds: '.
	self hasBounds
		ifFalse: [ aStream nextPutAll: '<uninitialized>' ]
		ifTrue: [ 
				aStream 
					print: self bounds;
					nextPutAll: ', ratio ';
					print: (self aspectRatio asFloat round: 1) ].
]

{ #category : #accessing }
GtGraphTreemapNode >> totalValue [
	"Return a sum of all nodes values involved in treemap layout computation"
	<return: #Number>
	^ totalValue
]

{ #category : #accessing }
GtGraphTreemapNode >> totalValue: aNumber [
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Treemap node total value must be a positive number' ].
	totalValue := aNumber
]

{ #category : #accessing }
GtGraphTreemapNode >> value [
	<return: #Number>
	^ value
]

{ #category : #accessing }
GtGraphTreemapNode >> value: aNumber [
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Treemap node value must be a positive number' ].
	value := aNumber
]

{ #category : #accessing }
GtGraphTreemapNode >> weight [
	"Return a number in the interval [0..1] that represent percentage that a node should occupy"
	<return: #Number>
	^ weight
]

{ #category : #accessing }
GtGraphTreemapNode >> weight: aNumber [
	self
		assert: [ aNumber between: 0 and: 1 ]
		description: [ 'Treemap node weight must be between 0 and 1' ].
	weight := aNumber
]
