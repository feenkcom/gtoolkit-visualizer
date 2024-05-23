Class {
	#name : #GtWardleyMapEdgeElement,
	#superclass : #BlLineElement,
	#traits : 'TGtWithWardleyMapEdgeViewModel',
	#classTraits : 'TGtWithWardleyMapEdgeViewModel classTrait',
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #private }
GtWardleyMapEdgeElement >> createDefaultBorder [
	^ BlBorder builder
		paint: self wardleyMapEdgeViewModel lineColor;
		width: self wardleyMapEdgeViewModel lineWidth;
		in: [ :aBuilder | 
			self wardleyMapEdgeViewModel isToNodeEvolveTargetType
				ifTrue: [ aBuilder dashed ] ];
		build
]

{ #category : #private }
GtWardleyMapEdgeElement >> createHoveredBorder [
	^ BlBorder builder
		paint: GtWardleyMapConstants hoverColor;
		width: self wardleyMapEdgeViewModel lineWidth;
		in: [ :aBuilder | 
			self wardleyMapEdgeViewModel isToNodeEvolveTargetType
				ifTrue: [ aBuilder dashed ] ];
		build
]

{ #category : #initialization }
GtWardleyMapEdgeElement >> initialize [
	super initialize.
	self aptitude: BrStyleCommonAptitude new.
	self
		when: BlClickEvent
		do: [ :anEvent | 
			(anEvent modifiers isPrimaryModifier not
				and: [ anEvent target = anEvent currentTarget ])
				ifTrue: [ anEvent consumed: true.
					anEvent currentTarget requestFocus ] ].
	self
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination backspace;
				action: [ self wardleyMapEdgeViewModel removeFromMap ]).
	self
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination builder primary minus build;
				action: [ self wardleyMapEdgeViewModel decreaseWidth ]).
	self
		addShortcut: (BlShortcutWithAction new
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

{ #category : #'event handling' }
GtWardleyMapEdgeElement >> onEdgeTypeChanged: anAnnouncement [.
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
		when: GtWardleyMapEdgeViewModelArrowChanged send: #onEdgeArrowChanged: to: self;
		when: GtWardleyMapEdgeViewModelTypeChanged send: #onEdgeTypeChanged: to: self
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
		default: [ :aStyle | aStyle border: self createDefaultBorder ];
		hovered: [ :aStyle | 
			aStyle
				do: [ :theElement | 
					theElement border: self createHoveredBorder.
					theElement toHead ifNotNil: [ :aHead | 
						aHead background: GtWardleyMapConstants hoverColor ] ]
				after: [ :theElement | 
					theElement border: self createDefaultBorder.
					theElement toHead ifNotNil: [ :aHead | 
						aHead background: self wardleyMapEdgeViewModel lineColor ] ] ];
		propagateStylesToWidget
]
