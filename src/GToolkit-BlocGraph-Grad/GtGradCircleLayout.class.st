Class {
	#name : #GtGradCircleLayout,
	#superclass : #GtGradLayout,
	#instVars : [
		'distance'
	],
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #computation }
GtGradCircleLayout >> calculatePositionsFor: aCollectionOfNodes radius: aRadius center: aCenterPoint [
	| aSlice |
	<return: #Collection of: #Point>
	
	aCollectionOfNodes
		ifEmpty: [ ^ #() ].
	
	aCollectionOfNodes size = 1
		ifTrue: [ ^ aCenterPoint ].

	aCollectionOfNodes size = 2
		ifTrue: [ ^ {
			aCenterPoint x - (aRadius / 2.0) @ (aCenterPoint y).
			aCenterPoint x + (aRadius / 2.0) @ (aCenterPoint y).
		} ].
	
	aSlice := 2 * Float pi / aCollectionOfNodes size.
	
	^ aCollectionOfNodes collectWithIndex: [ :anElement :anIndex |
		| anAngle newX newY |
		
		anAngle := (anIndex - 1) * aSlice.
		newX := aCenterPoint x + (aRadius * anAngle cos).
		newY := aCenterPoint y + (aRadius * anAngle sin).
		
		(newX @ newY) asIntegerPoint ]
]

{ #category : #computation }
GtGradCircleLayout >> calculateRadiusFor: aCollectionOfNodes threshold: threshold [
	<return: #Number>

	| radius slice currentTheta previousTheta previousNode |
	aCollectionOfNodes size = 2
		ifTrue: [ ^ aCollectionOfNodes first width + aCollectionOfNodes second width + self distance ].
	
	radius := 0.
	slice := (2 * Float pi) / (aCollectionOfNodes size).
	currentTheta := 0.
	previousTheta := 0.
	previousNode := nil.
	aCollectionOfNodes doWithIndex: [ :each :i |
		|rx ry rCurrent angleCos angleSin|
		previousNode isNil
			ifFalse: [
					previousTheta := currentTheta.
					currentTheta := (i-1) * slice.
					(currentTheta > (2 * Float pi))
						ifTrue: [ currentTheta := 0].
					angleCos :=  2 * (((currentTheta cos) - (previousTheta cos)) abs).
					angleSin :=  2 * (((currentTheta sin) - (previousTheta sin)) abs).
					rx := 0.
					ry := 0.
					angleCos > 0.01
						ifTrue: [rx := ((each width) + (previousNode width) + threshold) / angleCos].
					angleSin > 0.01
						ifTrue: [ry := ((each height) + (previousNode height) + threshold) / angleSin].
					
					(rx >0  and: [ ry > 0 ])
						ifTrue: [rCurrent := rx min: ry]
						ifFalse: [rCurrent := rx max: ry].

					((radius = 0) or: [radius < rCurrent])
						ifTrue: [radius := rCurrent].
						].
			GtGradCircleLayoutRadiusSignal new
				element1: each;
				element2: previousNode;
				angle1: currentTheta;
				angle2: previousTheta;
				rx: rx;
				ry: ry;
				rCurrent: rCurrent;
				radius: radius;
				emit.

		previousNode := each. 
	].
	^ radius.
		
	 
]

{ #category : #accessing }
GtGradCircleLayout >> distance [
	<return: #Number>

	^ distance
]

{ #category : #accessing }
GtGradCircleLayout >> distance: aNumber [
	distance := aNumber
]

{ #category : #initialization }
GtGradCircleLayout >> initialize [
	super initialize.
	
	distance := 50
]

{ #category : #measure }
GtGradCircleLayout >> measureChildrenNodes: aParentLayoutNode [
	| aRadius thePosition |
	
	aRadius := self calculateRadiusFor: aParentLayoutNode children threshold: self distance.
	thePosition := self calculatePositionsFor: aParentLayoutNode children radius: aRadius center: 0@0.

	"SequenceableCollection"
	aParentLayoutNode children with: thePosition do: [ :aNodeElement :aPosition |
		"to change position of a node"
		aNodeElement position: aPosition ].

	aParentLayoutNode children normalizePositions
]
