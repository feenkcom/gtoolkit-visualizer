Class {
	#name : #GtTreeMap,
	#superclass : #BrStencil,
	#instVars : [
		'levelLayout',
		'traversalBlock',
		'leavesCreationBlock',
		'leavesSizeBlock',
		'roots'
	],
	#category : #'GToolkit-TreeMap'
}

{ #category : #'api - instantiation' }
GtTreeMap >> create [
	<return: #BlElement>
	^ self 
		createFor: roots 
		withChildren: (traversalBlock value: roots)
]

{ #category : #'api - instantiation' }
GtTreeMap >> createFor: anObject withChildren: children [
	| element leaves |
	element := BlElement new
		geometry: BlEllipse new;
		when: BlClickEvent do: [ :e | e target phlow spawnObject: anObject. e consumed: true ];
		border: (BlBorder paint: (Color gray alpha: 0.2)).
	leaves := self createLeavesFor: anObject.
	(children isEmpty and: [ leaves isEmpty ])
		ifTrue: [ 
			element size: 1 asPoint ]
		ifFalse: [ 
			element
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent ];
				layout: GtGraphCirclePackLayout new;
				addChildren: leaves;
				addChildren: (children collect: [ :aChild | 
					self 
						createFor: aChild 
						withChildren: (traversalBlock value: aChild) ]) ].
	^ element
]

{ #category : #'api - instantiation' }
GtTreeMap >> createLeavesFor: anObject [
	^ (leavesCreationBlock value: anObject) collect: [ :leaf |
		BlElement new
			geometry: BlEllipse new;
			size: ((leavesSizeBlock value: leaf) max: 1) asPoint;
			when: BlClickEvent do: [ :e | e target phlow spawnObject: leaf. e consumed: true ];
			background: Color red;
			border: (BlBorder paint: (Color gray alpha: 0.2))]
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
	traversalBlock := [ :x | {  } ].
	leavesCreationBlock := [ :x | {  } ]
]

{ #category : #accessing }
GtTreeMap >> leaves: aBlock [
	leavesCreationBlock := aBlock
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
