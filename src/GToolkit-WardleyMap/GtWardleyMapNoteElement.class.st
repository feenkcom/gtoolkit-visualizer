Class {
	#name : #GtWardleyMapNoteElement,
	#superclass : #BlElement,
	#traits : 'TGtWithWardleyMapNoteViewModel',
	#classTraits : 'TGtWithWardleyMapNoteViewModel classTrait',
	#instVars : [
		'labelElement'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #accessing }
GtWardleyMapNoteElement >> initialize [
	super initialize.
	
	self layout: BlFrameLayout new.
	self constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal fitContent ].
	self background: (BrGlamorousColors neutralBackgroundColor alpha: 0.5).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	labelElement := BrEditableLabel new
			fitContent;
			id: GtWardleyMapNoteLabelId;
			aptitude: (BrGlamorousRegularEditorAptitude new glamorousRegularSmallSize);
			padding: (BlInsets all: 3);
			when: BrEditorAcceptWish
				do: [ :aWish | self wardleyMapNoteViewModel label: aWish text asString ];
			text: 'Note'.
			
	self addChild: labelElement.
	
	self
		addAptitude: (BrStyleCommonAptitude new
				focused: [ :s | s border: (BlBorder 
					paint: self theme editor focusedBorderColor 
					width: 1) ]).
	self
		when: BlClickEvent
		do: [ :anEvent | 
			(anEvent modifiers isPrimaryModifier not and: [ anEvent target = self ])
				ifTrue: [ anEvent consumed: true.
					self requestFocus ] ].
	self
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination backspace;
				action: [ :anEvent | anEvent currentTarget wardleyMapNoteViewModel removeFromMap ]).
]

{ #category : #accessing }
GtWardleyMapNoteElement >> labelElementDo: aBlock [
	aBlock value: labelElement
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNoteElement >> onNoteColored [
	labelElement aptitude foreground: self wardleyMapNoteViewModel color.
]

{ #category : #'as yet unclassified' }
GtWardleyMapNoteElement >> onNoteLabelChanged [
	labelElement text: self wardleyMapNoteViewModel label.
	labelElement aptitude foreground: self wardleyMapNoteViewModel color.
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNoteElement >> onWardleyMapNoteViewModelChanged [
	"Is sent when a new WardleyMapNote view model is assigned to the element"
	
	self onNoteLabelChanged.
	self onNoteColored
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNoteElement >> subscribeToWardleyMapNoteViewModel [
	"Is sent after a new WardleyMapNote view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNoteViewModel if elements subscribe to them"
	
	self wardleyMapNoteViewModel weak
		when: GtWardleyMapNoteViewModelLabelChanged send: #onNoteLabelChanged to: self;
		when: GtWardleyMapNoteViewModelColored send: #onNoteColored to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNoteElement >> unsubscribeFromWardleyMapNoteViewModel [
	"Is sent before a new WardleyMapNote view model is assigned to the element.
	Elements that subscribe to WardleyMapNote view model in domain model are required to implement this methods"
	
	self wardleyMapNoteViewModel unsubscribe: self
]
