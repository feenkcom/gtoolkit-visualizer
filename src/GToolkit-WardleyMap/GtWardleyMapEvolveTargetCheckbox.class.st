Class {
	#name : #GtWardleyMapEvolveTargetCheckbox,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'checkbox',
		'label',
		'disabledLabel'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapEvolveTargetCheckbox >> checked: aBoolean [
	checkbox checked: aBoolean
]

{ #category : #accessing }
GtWardleyMapEvolveTargetCheckbox >> enabled: aBoolean [
	checkbox enabled: aBoolean.

	aBoolean
		ifTrue: [ 
			checkbox visibility: BlVisibility visible.
			label visibility: BlVisibility visible.
			disabledLabel visibility: BlVisibility gone ]
		ifFalse: [
			checkbox visibility: BlVisibility gone.
			label visibility: BlVisibility gone.
			disabledLabel visibility: BlVisibility visible ]
]

{ #category : #initialization }
GtWardleyMapEvolveTargetCheckbox >> initialize [
	super initialize.

	checkbox := BrCheckbox new
			aptitude: BrGlamorousCheckboxAptitude
					+ (BrGlamorousWithExplicitTooltipAptitude text: 'Toggle evolve target posibility');
			checked: false;
			whenCheckedDo: [ :anEvent |  ];
			whenUncheckedDo: [ :anEvent |  ];
			margin: (BlInsets right: 3).

	label := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
			text: 'evolve node'.

	disabledLabel := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new
					foreground: Color darkGray;
					italic);
			text: 'Cannot become an evolve node';
			visibility: BlVisibility gone.

	self addChild: checkbox.
	self addChild: label.
	self addChild: disabledLabel.

	self fitContent.
	self alignCenterLeft
]

{ #category : #initialization }
GtWardleyMapEvolveTargetCheckbox >> whenCheckedDo: aBlock [
	"aBlock with one argument, receiving an event"
	checkbox whenCheckedDo: aBlock
]

{ #category : #initialization }
GtWardleyMapEvolveTargetCheckbox >> whenUncheckedDo: aBlock [
	"aBlock with one argument, receiving an event"
	checkbox whenUncheckedDo: aBlock
]
