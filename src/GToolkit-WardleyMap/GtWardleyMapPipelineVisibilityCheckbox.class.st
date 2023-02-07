Class {
	#name : #GtWardleyMapPipelineVisibilityCheckbox,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'checkbox',
		'label',
		'disabledLabel'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapPipelineVisibilityCheckbox >> checked: aBoolean [
	checkbox checked: aBoolean
]

{ #category : #accessing }
GtWardleyMapPipelineVisibilityCheckbox >> enabled: aBoolean [
	checkbox enabled: aBoolean.

	aBoolean
		ifTrue: [ checkbox visibility: BlVisibility visible.
			label visibility: BlVisibility visible.
			disabledLabel visibility: BlVisibility gone ]
		ifFalse: [ checkbox visibility: BlVisibility gone.
			label visibility: BlVisibility gone.
			disabledLabel visibility: BlVisibility visible ]
]

{ #category : #initialization }
GtWardleyMapPipelineVisibilityCheckbox >> initialize [
	super initialize.

	checkbox := BrCheckbox new
			aptitude: BrGlamorousCheckboxAptitude
					+ (BrGlamorousWithLabelTooltipAptitude new text: 'Toggle pipeline visibility');
			checked: false;
			whenCheckedDo: [ :anEvent |  ];
			whenUncheckedDo: [ :anEvent |  ];
			margin: (BlInsets right: 3).

	label := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
			text: 'visible pipeline'.
			
	disabledLabel := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
			text: 'Inner nodes cannot have pipelines';
			visibility: BlVisibility gone.

	self addChild: checkbox.
	self addChild: label.
	self addChild: disabledLabel.

	self fitContent.
	self alignCenterLeft
]

{ #category : #initialization }
GtWardleyMapPipelineVisibilityCheckbox >> whenCheckedDo: aBlock [
	"aBlock with one argument, receiving an event"
	checkbox whenCheckedDo: aBlock
]

{ #category : #initialization }
GtWardleyMapPipelineVisibilityCheckbox >> whenUncheckedDo: aBlock [
	"aBlock with one argument, receiving an event"
	checkbox whenUncheckedDo: aBlock
]
