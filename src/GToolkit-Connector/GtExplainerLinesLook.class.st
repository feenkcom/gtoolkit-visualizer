Class {
	#name : #GtExplainerLinesLook,
	#superclass : #BrLook,
	#instVars : [
		'isForTarget',
		'addedLines'
	],
	#category : #'GToolkit-Connector-Explainer'
}

{ #category : #private }
GtExplainerLinesLook >> allChildrenWithSameExplanationModel: aWidget do: aBlock [
	isForTarget
		ifFalse: [
			aWidget explainer firstExplanationHolderParent explainer
				allTargetChildrenWithModel: aWidget explainer model
				do: aBlock ]
		ifTrue: [
			aWidget explainer firstExplanationHolderParent explainer
				allExplanationChildrenWithModel: aWidget explainer model
				do: aBlock ]
]

{ #category : #accessing }
GtExplainerLinesLook >> beForExplanation [
	isForTarget := false
]

{ #category : #accessing }
GtExplainerLinesLook >> beForTarget [
	isForTarget := true
]

{ #category : #initialization }
GtExplainerLinesLook >> initialize [
	super initialize.
	
	addedLines := OrderedCollection new.
	isForTarget := true
]

{ #category : #initialization }
GtExplainerLinesLook >> initializeListeners [
	super initializeListeners.
	
	self when: BlElementHoveredEvent do: [ :anEvent | self onHovered: anEvent element ].
	self when: BlElementUnhoveredEvent do: [ :anEvent | self onUnhovered: anEvent element ].
]

{ #category : #initialization }
GtExplainerLinesLook >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	anElement states withHover
]

{ #category : #private }
GtExplainerLinesLook >> onHovered: aWidget [
	self
		allChildrenWithSameExplanationModel: aWidget
		do: [ :explanationTargetElement |
			| aNewLine |
			
			aNewLine := BlLineElement new
				fromAnchor: (BlNearestPositionTightCircleAnchor
						referenceElement: aWidget
						relatedTo: explanationTargetElement);
				toAnchor: (BlNearestPositionTightCircleAnchor
						referenceElement: explanationTargetElement
						relatedTo: aWidget);
				zIndex: 10;
				border: (BlBorder paint: (BrGlamorousColors textHighlightColor alpha: 0.7) width: 2);
				constraintsDo: [ :c | c ignoreByLayout ];
				yourself.

			aWidget 
				firstCommonParent: explanationTargetElement
				ifFound: [ :aCommonParent |
					addedLines add: aNewLine.
					aCommonParent addChild: aNewLine.
					explanationTargetElement fireEvent: GtExplanationLinkConnectedEvent new ]
				ifNone: [  ] ] 
]

{ #category : #private }
GtExplainerLinesLook >> onUnhovered: anElement [
	addedLines do: [ :eachLine |
		eachLine removeFromParent.
		eachLine toAnchor referenceElement fireEvent: GtExplanationLinkDisconnectedEvent new ].
	addedLines removeAll
]
