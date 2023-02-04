Class {
	#name : #GtWardleyMapPipelineVisibilityCheckbox,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'checkbox',
		'label'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapPipelineVisibilityCheckbox >> checked: aBoolean [
	checkbox checked: aBoolean
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

	self addChild: checkbox.
	self addChild: label.

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
