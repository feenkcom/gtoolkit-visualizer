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
	labelElement := BrEditableLabel new
			fitContent;
			id: GtWardleyMapNoteLabelId;
			aptitude: BrGlamorousRegularEditorAptitude new;
			when: BrEditorAcceptWish
				do: [ :aWish | self wardleyMapNoteViewModel label: aWish text asString ];
			text: 'Note'.
			
	self addChild: labelElement.
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

{ #category : #'event handling' }
GtWardleyMapNoteElement >> onNoteLabelTextChanged [
	labelElement text: self wardleyMapNoteViewModel label
]
