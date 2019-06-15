Class {
	#name : #GtTreeMap,
	#superclass : #BrStencil,
	#instVars : [
		'levelLayout',
		'traversalBlock',
		'leavesCreationBlock',
		'leavesSizeBlock',
		'roots',
		'leafEllipseBlock',
		'containerEllipseBlock'
	],
	#category : #'GToolkit-TreeMap'
}

{ #category : #api }
GtTreeMap >> containerEllipse: aBlock [
	containerEllipseBlock := aBlock
]

{ #category : #implementation }
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

{ #category : #implementation }
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

{ #category : #implementation }
GtTreeMap >> createFor: anObject [
	| element leaves children |
	element := self createContainerFor: anObject.
	leaves := self createLeavesFor: anObject.
	children := traversalBlock value: anObject.
	self setup: element withChildren: children andLeaves: leaves.
	^ element
]

{ #category : #implementation }
GtTreeMap >> createLeavesFor: anObject [
	^ (leavesCreationBlock value: anObject) collect: [ :leaf |
		| leafElement |
		leafElement := BlElement new
			geometry: BlEllipse new;
			size: ((leavesSizeBlock value: leaf) max: 1) asPoint;
			when: BlClickEvent do: [ :e | e target phlow spawnObject: leaf. e consumed: true ];
			background: (Color red darker alpha: 0.7);
			border: (BlBorder paint: (Color gray alpha: 0.2)).
		leafEllipseBlock value: leafElement.
		leafElement ]
]

{ #category : #api }
GtTreeMap >> deep: aBlock [
	traversalBlock := aBlock
]

{ #category : #initialization }
GtTreeMap >> initialize [
	super initialize.
	levelLayout := GtGraphCirclePackLayout new.
	leavesSizeBlock := [ :x | 10 ].
	traversalBlock := [ :x | {  } ].
	leavesCreationBlock := [ :x | {  } ].
	containerEllipseBlock := [ :ellipse | ellipse ].
	leafEllipseBlock := [ :ellipse | ellipse ]
]

{ #category : #api }
GtTreeMap >> leafEllipse: aBlock [
	leafEllipseBlock := aBlock
]

{ #category : #api }
GtTreeMap >> leaves: aBlock [
	leavesCreationBlock := aBlock
]

{ #category : #api }
GtTreeMap >> leavesSize: aBlock [
	leavesSizeBlock := aBlock
]

{ #category : #api }
GtTreeMap >> levelLayout: aLayout [
]

{ #category : #api }
GtTreeMap >> roots: aCollection [
	roots := aCollection
]

{ #category : #implementation }
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
