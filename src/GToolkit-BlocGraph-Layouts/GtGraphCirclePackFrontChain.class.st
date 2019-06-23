Class {
	#name : #GtGraphCirclePackFrontChain,
	#superclass : #DoubleLinkedList,
	#instVars : [
		'origin',
		'nearestCircle',
		'nextCircle'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Circle'
}

{ #category : #enumeration }
GtGraphCirclePackFrontChain >> aroundLink: aLink detect: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	self aroundLink: aLink do: [ :eachLink :eachIndex |
		(aBlock value: eachLink)
			ifTrue: [ ^ aFoundBlock value: eachLink value: eachIndex ] ].
	^ anExceptionBlock value
]

{ #category : #enumeration }
GtGraphCirclePackFrontChain >> aroundLink: aLink do: block [
	"Execute block for each of the links that I hold internally
	taking one to the left of the link, one to the right of the link"
	| currentLeft currentRight leftIndex rightIndex |	
	
	currentLeft := aLink hasPredecessor
		ifFalse: [ tail ]
		ifTrue: [ aLink previousLink ].
	
	currentRight := aLink hasSuccessor
		ifFalse: [ head ]
		ifTrue: [ aLink nextLink ].
	
	leftIndex := -1.
	rightIndex := 1.
	
	[
		| newPrevious newNext |
			
		currentLeft == currentRight
			ifTrue: [
				block value: currentLeft value: leftIndex.
				^ self
			].
		
		block value: currentLeft value: leftIndex.
		block value: currentRight value: rightIndex.

		newPrevious := currentLeft hasPredecessor
			ifFalse: [ tail ]
			ifTrue: [ currentLeft previousLink ]. 
	
		newNext := currentRight hasSuccessor
			ifFalse: [ head ]
			ifTrue: [ currentRight nextLink ].
		
		newPrevious == currentRight
			ifTrue: [ ^ self ].
			
		newNext == currentLeft
			ifTrue: [ ^ self ].
		
		currentLeft := newPrevious.
		currentRight := newNext.
		
		leftIndex := leftIndex - 1.
		rightIndex := rightIndex + 1.
	
	
	] repeat
]

{ #category : #accessing }
GtGraphCirclePackFrontChain >> enclosureCircle [
	| theCircles |
	
	theCircles := Array streamContents: [ :aStream | (self linksDo: [ :eachLink | aStream nextPut: eachLink circle ]) ].
	^ (GtGraphCircleEnclosure new circles: theCircles) enclosureCircle
]

{ #category : #'gt-inspector-extension' }
GtGraphCirclePackFrontChain >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		stencil: [
			| theCircles theCircleElements theEdges aContainer |
			
			theCircles := Array streamContents: [ :aStream | self linksDo: [ :aCircle | aStream nextPut: aCircle ] ].
			theCircleElements := theCircles withIndexCollect: [ :eachCircle :eachIndex |
				BlScalableElement new
					background: (eachCircle == self nearestCircle
						ifTrue: [ Color blue alpha: 0.15 ]
						ifFalse: [ eachCircle == self nextCircle
							ifTrue: [ Color green alpha: 0.15 ]
							ifFalse: [ Color transparent ] ]);
					geometry: BlCircle new;
					size: eachCircle radius * 2 asPoint;
					relocate: eachCircle center - eachCircle radius asPoint;
					border: (BlBorder paint: (Color black alpha: 0.5) width: 2);
					addChild: (BlTextElement new text: eachIndex asRopedText glamorousRegularFont; padding: (BlInsets all: 10)) ].
				
			theEdges := Array streamContents: [ :aStream | theCircleElements overlappingPairsDo: [ :from :to | 
				aStream nextPut: (BlParabollaArcElement new
						curvatureFraction: 0.3;
					constraintsDo: [ :c | c ignoreByLayout ];
					fromAnchor: (BlElementCenterAnchor element: from);
					toAnchor: (BlElementCenterAnchor element: to);
					border: (BlBorder paint: (Color red alpha: 0.5) width: 3);
					toHead: (BlArrowheadSimpleArrow new
						arrowLengthFraction: 6;
						arrowNoseAngle: 60;
						border: (BlBorder paint: (Color red alpha: 0.5) width: 3);
						background: (Color red alpha: 0.5))) ] ].
			
			aContainer := BlElement new.
			aContainer layout: BlFitLayout new.
			aContainer addChildren: theCircleElements.
			aContainer addChildren: theEdges.
			aContainer asScalableElement ]
]

{ #category : #accessing }
GtGraphCirclePackFrontChain >> nearestCircle [
	^ nearestCircle
]

{ #category : #accessing }
GtGraphCirclePackFrontChain >> nearestCircle: anObject [
	nearestCircle := anObject
]

{ #category : #accessing }
GtGraphCirclePackFrontChain >> nextCircle [
	^ nextCircle
]

{ #category : #accessing }
GtGraphCirclePackFrontChain >> nextCircle: anObject [
	nextCircle := anObject
]

{ #category : #accessing }
GtGraphCirclePackFrontChain >> origin [
	^ origin
]

{ #category : #removing }
GtGraphCirclePackFrontChain >> removeFrom: aNodeLink to: anotherNodeLink [
	"does not remove aNodeLink and anotherNodeLink"
	| aCurrentLink aFirstLink |
	
	aCurrentLink := anotherNodeLink previousLink.	
	aFirstLink := aNodeLink.

	[ aCurrentLink ~~ aFirstLink ]
		whileTrue: [
			| aPreviousLink |
			aPreviousLink := aCurrentLink hasPredecessor
				ifFalse: [ tail ]
				ifTrue: [ aCurrentLink previousLink ].
		
			self removeLink: aCurrentLink.
			aCurrentLink := aPreviousLink ]
]
