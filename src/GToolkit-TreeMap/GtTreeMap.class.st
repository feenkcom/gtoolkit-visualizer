Class {
	#name : #GtTreeMap,
	#superclass : #BrStencil,
	#instVars : [
		'levelLayout',
		'traversalBlock',
		'leavesSizeBlock',
		'roots'
	],
	#category : #'GToolkit-TreeMap'
}

{ #category : #'api - instantiation' }
GtTreeMap >> create [
	<return: #BlElement>
	^ self 
		createFor: { roots } 
		withChildren: roots
]

{ #category : #'api - instantiation' }
GtTreeMap >> createFor: anObject withChildren: children [
	| element |
	element := BlElement new
		geometry: BlEllipse new;
		padding: (BlInsets all: 10);
		border: (BlBorder paint: Color gray).
	children isEmpty
		ifTrue: [ 
			element
				size: (leavesSizeBlock value: anObject) asPoint;
				background: Color red ]
		ifFalse: [ 
			element 
				constraintsDo: [ :c | c horizontal fitContent. c vertical fitContent ];
				layout: GtGraphCirclePackLayout new;
				addChildren: (self createForChildren: children) ].
	^ element
]

{ #category : #'api - instantiation' }
GtTreeMap >> createForChildren: aCollection [
	^ aCollection
		collect: [ :anObject | 
			| children |
			children := traversalBlock value: anObject.
			self createFor: anObject withChildren: children ]
]

{ #category : #accessing }
GtTreeMap >> deep: aBlock [
	traversalBlock := aBlock
]

{ #category : #initialization }
GtTreeMap >> initialize [
	super initialize.
	levelLayout := GtGraphCirclePackLayout new.
	leavesSizeBlock := [ :x | 10 ].
	traversalBlock := [ :x | {  } ]
]

{ #category : #accessing }
GtTreeMap >> leavesSize: aBlock [
	leavesSizeBlock := aBlock
]

{ #category : #accessing }
GtTreeMap >> levelLayout: aLayout [
]

{ #category : #accessing }
GtTreeMap >> roots: aCollection [
	roots := aCollection
]
