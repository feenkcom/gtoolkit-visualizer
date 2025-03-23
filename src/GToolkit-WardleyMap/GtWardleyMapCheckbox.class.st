Class {
	#name : #GtWardleyMapCheckbox,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'checkbox',
		'disabledLabel',
		'enabledLabel',
		'tooltipAptitude'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapCheckbox >> checked: aBoolean [
	checkbox checked: aBoolean
]

{ #category : #initialization }
GtWardleyMapCheckbox >> disabledLabel: aString [
	disabledLabel text: aString
]

{ #category : #accessing }
GtWardleyMapCheckbox >> enabled: aBoolean [
	checkbox enabled: aBoolean.

	aBoolean
		ifTrue: [ checkbox visibility: BlVisibility visible.
			enabledLabel visibility: BlVisibility visible.
			disabledLabel visibility: BlVisibility gone ]
		ifFalse: [ checkbox visibility: BlVisibility gone.
			enabledLabel visibility: BlVisibility gone.
			disabledLabel visibility: BlVisibility visible ]
]

{ #category : #initialization }
GtWardleyMapCheckbox >> enabledLabel: aString [
	enabledLabel text: aString
]

{ #category : #initialization }
GtWardleyMapCheckbox >> initialize [
	super initialize.

	checkbox := BrCheckbox new
			aptitude: BrGlamorousCheckboxAptitude
					+ (tooltipAptitude := BrGlamorousWithExplicitTooltipAptitude text: 'Toggle');
			checked: false;
			whenCheckedDo: [ :anEvent |  ];
			whenUncheckedDo: [ :anEvent |  ];
			margin: (BlInsets right: 3).

	enabledLabel := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
			text: ''.

	disabledLabel := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new
					foreground: Color darkGray;
					italic);
			text: 'disabled';
			visibility: BlVisibility gone.

	self addChild: checkbox.
	self addChild: enabledLabel.
	self addChild: disabledLabel.

	self margin: GtWardleyMapUtility menuItemMarginInsets.
	self fitContent.
	self alignCenterLeft
]

{ #category : #initialization }
GtWardleyMapCheckbox >> tooltipLabel: aString [
	tooltipAptitude text: aString
]

{ #category : #initialization }
GtWardleyMapCheckbox >> whenCheckedDo: aBlock [
	"aBlock with one argument, receiving an event"
	checkbox whenCheckedDo: aBlock
]

{ #category : #initialization }
GtWardleyMapCheckbox >> whenUncheckedDo: aBlock [
	"aBlock with one argument, receiving an event"
	checkbox whenUncheckedDo: aBlock
]
