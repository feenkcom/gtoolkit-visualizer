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
	^ roots size = 1 
		ifTrue: [ self createFor: roots anyOne ]
		ifFalse: [
			| element|
			element := self createContainerFor: roots.
			self 
				setup: element 
				withChildren: roots 
				andLeaves: {}.
			element ]
]

{ #category : #'api - instantiation' }
GtTreeMap >> createContainerFor: anObject [
	| element |
	element := BlElement new
		geometry: BlEllipse new;
		when: BlClickEvent
			do: [ :e | 
			e target phlow spawnObject: anObject.
			e consumed: true ];
		border: (BlBorder paint: (Color gray alpha: 0.5) width: 2).
	^ element
]

{ #category : #'api - instantiation' }
GtTreeMap >> createFor: anObject [
	| element leaves children |
	element := self createContainerFor: anObject.
	leaves := self createLeavesFor: anObject.
	children := traversalBlock value: anObject.
	self setup: element withChildren: children andLeaves: leaves.
	^ element
]

{ #category : #'api - instantiation' }
GtTreeMap >> createLeavesFor: anObject [
	^ (leavesCreationBlock value: anObject) collect: [ :leaf |
		BlElement new
			geometry: BlEllipse new;
			size: ((leavesSizeBlock value: leaf) max: 1) asPoint;
			when: BlClickEvent do: [ :e | e target phlow spawnObject: leaf. e consumed: true ];
			background: (Color red darker alpha: 0.7);
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

{ #category : #'api - instantiation' }
GtTreeMap >> setup: element withChildren: children andLeaves: leaves [
	(children isEmpty and: [ leaves isEmpty ])
		ifTrue: [ element size: 1 asPoint ]
		ifFalse: [ element
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent ];
				layout: GtGraphCirclePackLayout new;
				addChildren: leaves;
				addChildren: (children collect: [ :aChild | self createFor: aChild ]) ]
]
