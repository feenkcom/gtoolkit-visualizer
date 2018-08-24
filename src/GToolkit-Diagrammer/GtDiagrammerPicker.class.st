"
I am a scriptable toogle group to display a uniform collection of selectable values.

[[[
| picker |
picker := GtDiagrammerPicker new.
picker layout: BlFlowLayout horizontal.
picker display: [ { 'Hello' . 'World' . 'I' . 'am' . 'a' . 'picker' } ].
picker shape: [ :aString | BrToggle new
	look: BrMaterialToggleLabelledLook;
	margin: (BlInsets all: 3);
	label: aString ].
picker constraintsDo: [ :c |
	c horizontal exact: 400.
	c vertical fitContent ].
picker when: BrToggleActivatedEvent do: [ :anEvent | self inform: anEvent model ].
picker
]]]
"
Class {
	#name : #GtDiagrammerPicker,
	#superclass : #BrToggleGroup,
	#instVars : [
		'displayBlock',
		'entities',
		'shapeBlock',
		'selected'
	],
	#category : 'GToolkit-Diagrammer-UI'
}

{ #category : #accessing }
GtDiagrammerPicker >> display: aBlock [
	displayBlock := aBlock.
	
	self initializeEntities
]

{ #category : #testing }
GtDiagrammerPicker >> hasSelected [
	^ selected isNotNil
]

{ #category : #initialization }
GtDiagrammerPicker >> initialize [
	super initialize.
	
	entities := #().
	displayBlock := [ #() ].	
	shapeBlock := [ BrToggle new look: BrMaterialToggleLabelledLook new ].
	
	self layout: BlFlowLayout horizontal.
	self padding: (BlInsets all: 10).
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
]

{ #category : #initialization }
GtDiagrammerPicker >> initializeEntities [
	self removeToggles.
	
	entities := displayBlock value.
	self addToggles: (entities collect: [ :anEntity |
		| anElement |

		anElement := shapeBlock cull: anEntity.
		anElement viewModel model: anEntity.
		anElement ]).
	
	self initializeSelection
]

{ #category : #initialization }
GtDiagrammerPicker >> initializeSelection [
	self hasSelected
		ifFalse: [ ^ self ].

	self
		toggleFor: self selected
		ifFound: [ :aToggle | aToggle activate ]
]

{ #category : #enumerating }
GtDiagrammerPicker >> select: anEntity [
	self
		assert: [ anEntity isNotNil ]
		description: [ 'Selected entity must not be nil' ].

	selected = anEntity
		ifTrue: [ ^ self ].

	selected := anEntity.
	self initializeSelection
]

{ #category : #enumerating }
GtDiagrammerPicker >> selectFirst [
	entities ifNotEmpty: [ self select: entities first ]
]

{ #category : #accessing }
GtDiagrammerPicker >> selected [
	self
		assert: [ self hasSelected ]
		description: [ 'Can not access selected object if nothing selected' ].
		
	^ selected
]

{ #category : #accessing }
GtDiagrammerPicker >> shape: aBlock [
	shapeBlock := aBlock.
	
	self initializeEntities
]

{ #category : #accessing }
GtDiagrammerPicker >> toggleFor: aModel ifFound: aBlockClosure [
	self viewModel toggles
		detect: [ :aToggleModel | aToggleModel model = aModel  ]
		ifFound: aBlockClosure
]
