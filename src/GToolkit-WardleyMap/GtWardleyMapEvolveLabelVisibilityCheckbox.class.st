Class {
	#name : #GtWardleyMapEvolveLabelVisibilityCheckbox,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'checkbox',
		'label'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapEvolveLabelVisibilityCheckbox >> checked: aBoolean [
	checkbox checked: aBoolean
]

{ #category : #accessing }
GtWardleyMapEvolveLabelVisibilityCheckbox >> enabled: aBoolean [
	checkbox enabled: aBoolean.
]

{ #category : #initialization }
GtWardleyMapEvolveLabelVisibilityCheckbox >> initialize [
	super initialize.

	checkbox := BrCheckbox new
			aptitude: BrGlamorousCheckboxAptitude
					+ (BrGlamorousWithExplicitTooltipAptitude text: 'Toggle evolve label visibility');
			checked: false;
			whenCheckedDo: [ :anEvent |  ];
			whenUncheckedDo: [ :anEvent |  ];
			margin: (BlInsets right: 3).

	label := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
			text: 'visible evolve label'.

	self addChild: checkbox.
	self addChild: label.

	self fitContent.
	self alignCenterLeft
]

{ #category : #initialization }
GtWardleyMapEvolveLabelVisibilityCheckbox >> whenCheckedDo: aBlock [
	"aBlock with one argument, receiving an event"
	checkbox whenCheckedDo: aBlock
]

{ #category : #initialization }
GtWardleyMapEvolveLabelVisibilityCheckbox >> whenUncheckedDo: aBlock [
	"aBlock with one argument, receiving an event"
	checkbox whenUncheckedDo: aBlock
]
