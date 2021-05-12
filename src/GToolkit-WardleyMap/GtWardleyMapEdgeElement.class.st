Class {
	#name : #GtWardleyMapEdgeElement,
	#superclass : #BlLineElement,
	#traits : 'TGtWithWardleyMapEdgeViewModel',
	#classTraits : 'TGtWithWardleyMapEdgeViewModel classTrait',
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #initialization }
GtWardleyMapEdgeElement >> initialize [
	super initialize.
	self
		aptitude:
			(BrStyleCommonAptitude new
				unfocused: [ :s | s border: (BlBorder paint: Color red width: 1) ];
				focused: [ :s | 
					s
						border: (BlBorder paint: self theme editor focusedBorderColor width: 1) ]).
	self
		when: BlClickEvent
		do: [ :anEvent | 
			(anEvent modifiers isPrimaryModifier not
				and: [ anEvent target = anEvent currentTarget ])
				ifTrue: [ anEvent consumed: true.
					anEvent currentTarget requestFocus ] ].
	self
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination backspace;
				action: [ self wardleyMapEdgeViewModel removeFromMap ]).
	self
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination builder primary minus build;
				action: [ self wardleyMapEdgeViewModel decreaseWidth ]).
	self
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination builder primary equal build;
				action: [ self wardleyMapEdgeViewModel increaseWidth ])
]

{ #category : #'event handling' }
GtWardleyMapEdgeElement >> onEdgeArrowChanged: anAnnouncement [
	self updateLineArrow
]

{ #category : #'event handling' }
GtWardleyMapEdgeElement >> onEdgeColored: anAnnouncement [
	self updateLineLook.
	self updateLineArrow
]

{ #category : #'event handling' }
GtWardleyMapEdgeElement >> onEdgeResized: anAnnouncement [
	self updateLineLook
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgeElement >> onWardleyMapEdgeViewModelChanged [
	"Is sent when a new wardleyMapEdge view model is assigned to the element"
	
	self updateLineLook.
	self updateLineArrow
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgeElement >> subscribeToWardleyMapEdgeViewModel [
	"Is sent after a new wardleyMapEdge view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapEdgeViewModel if elements subscribe to them"
	
	self wardleyMapEdgeViewModel weak
		when: GtWardleyMapEdgeViewModelResized send: #onEdgeResized: to: self;
		when: GtWardleyMapEdgeViewModelColored send: #onEdgeColored: to: self;
		when: GtWardleyMapEdgeViewModelArrowChanged send: #onEdgeArrowChanged: to: self
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgeElement >> unsubscribeFromWardleyMapEdgeViewModel [
	"Is sent before a new wardleyMapEdge view model is assigned to the element.
	Elements that subscribe to wardleyMapEdge view model in domain model are required to implement this methods"
	
	self wardleyMapEdgeViewModel unsubscribe: self
]

{ #category : #private }
GtWardleyMapEdgeElement >> updateLineArrow [

	self toHead: (self wardleyMapEdgeViewModel hasLineArrow
		ifTrue: [
			BlArrowheadSimpleArrow new
				arrowLengthFraction: 4;
				arrowNoseAngle: 50;
				background: (self wardleyMapEdgeViewModel lineColor) ]
		ifFalse: [ BlArrowheadNone new ])
]

{ #category : #private }
GtWardleyMapEdgeElement >> updateLineLook [
	self aptitude
		unfocused: [ :s | 
			s
				border:
					(BlBorder
						paint: self wardleyMapEdgeViewModel lineColor
						width: self wardleyMapEdgeViewModel lineWidth) ];
		focused: [ :s | 
			s
				border:
					(BlBorder
						paint: self theme editor focusedBorderColor
						width: self wardleyMapEdgeViewModel lineWidth) ];
		propagateStylesToWidget
]
