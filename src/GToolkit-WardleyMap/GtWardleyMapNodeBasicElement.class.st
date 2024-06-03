Class {
	#name : #GtWardleyMapNodeBasicElement,
	#superclass : #BlElement,
	#traits : 'TGtWithWardleyMapNodeViewModel',
	#classTraits : 'TGtWithWardleyMapNodeViewModel classTrait',
	#instVars : [
		'labelElement',
		'labelContainer'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #initialization }
GtWardleyMapNodeBasicElement >> beEllipseGeometry [
	self geometry: BlEllipseGeometry new
]

{ #category : #initialization }
GtWardleyMapNodeBasicElement >> initialize [
	super initialize.
	self beEllipseGeometry.
	self clipChildren: false.
	self layout: BlFrameLayout new.
	labelElement := BrEditableLabel new
			fitContent;
			id: GtWardleyMapNodeLabelId;
			aptitude: BrGlamorousRegularEditorAptitude new;
			when: BrEditorAcceptWish
				do: [ :aWish | self wardleyMapNodeViewModel label: aWish text asString ];
			text: 'Label'.
			
	"we have to wrap the editable label in a pullable element to allow text selection with drag"
	labelContainer := BrHorizontalPane new
			fitContent;
			addEventHandler: (GtWardleyMapPullHandler new
					containerElement: self;
					whenPulled: [ :aPulledElement :aNormalizedPosition | 
						self wardleyMapNodeViewModel moveNodeLabelTo: aNormalizedPosition ]);
			addChild: labelElement.
	self addChild: labelContainer.
	
	self aptitude: (BrStyleCommonAptitude new
			focused: [ :s | s border: (BlBorder paint: self theme editor focusedBorderColor width: 1) ]).
	self
		when: BlClickEvent
		do: [ :anEvent | 
			(anEvent modifiers isPrimaryModifier not and: [ anEvent target = self ])
				ifTrue: [ anEvent consumed: true.
					self requestFocus ] ].
	self
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination backspace;
				action: [ :anEvent | anEvent currentTarget wardleyMapNodeViewModel removeFromMap ]).
	self
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination builder primary minus build;
				action: [ :anEvent | anEvent currentTarget wardleyMapNodeViewModel decreaseNodeSize ]).
	self
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination builder primary equal build;
				action: [ :anEvent | anEvent currentTarget wardleyMapNodeViewModel increaseNodeSize ])
]

{ #category : #accessing }
GtWardleyMapNodeBasicElement >> labelContainerDo: aBlock [
	labelContainer ifNotNil: aBlock
]

{ #category : #accessing }
GtWardleyMapNodeBasicElement >> labelElementDo: aBlock [
	labelElement ifNotNil: aBlock
]

{ #category : #'event handling' }
GtWardleyMapNodeBasicElement >> onHovered [
	self styleBuilder onHovered
]

{ #category : #'event handling' }
GtWardleyMapNodeBasicElement >> onNodeColored [
	self styleBuilder onNodeColored
]

{ #category : #'event handling' }
GtWardleyMapNodeBasicElement >> onNodeLabelMoved [
	labelContainer constraintsDo: [ :c |
		c frame horizontal alignCenterAt: self wardleyMapNodeViewModel labelCoordinateX.
		c frame vertical alignCenterAt: self wardleyMapNodeViewModel labelCoordinateY ].
]

{ #category : #'event handling' }
GtWardleyMapNodeBasicElement >> onNodeLabelTextChanged [
	labelElement text: self wardleyMapNodeViewModel label
]

{ #category : #'event handling' }
GtWardleyMapNodeBasicElement >> onNodeResized [
	self size: self wardleyMapNodeViewModel nodeSize
]

{ #category : #'event handling' }
GtWardleyMapNodeBasicElement >> onUnhovered [
	self styleBuilder onUnhovered
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeBasicElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"
	
	self subclassResponsibility
]

{ #category : #accessing }
GtWardleyMapNodeBasicElement >> styleBuilder [
	<return: #GtWardleyMapNodeStyleBuilder>
	^ self subclassResponsibility
]
