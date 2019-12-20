"
I am a copy of class GtGraphTreemapSquarifyPortraitRectangle. This comment is copied from there, and might not be entirely accurate

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #GtGraphTreemapSquarifyPortraitVerticalRectangle,
	#superclass : #GtGraphTreemapSquarifyAreaRectangle,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'instance creation' }
GtGraphTreemapSquarifyPortraitVerticalRectangle class >> newOtherDirection [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyPortraitVerticalRectangle >> aspectRatioForWeightRatio: aWeightRatio occupiedExtent: anOccupiedExtent [ 
	| aLenght |
	aLenght := aWeightRatio * anOccupiedExtent x.
	^ (aLenght / anOccupiedExtent y) max: (anOccupiedExtent y / aLenght).
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyPortraitVerticalRectangle >> extentOccupiedBy: aRow [
	^ self extent * (1 @ aRow occupiedWeight)
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyPortraitVerticalRectangle >> layoutRow: aRow [
	| anOriginalArea anOccupiedArea anExtentToOccupy aNextNodePosition aRemainingRectangle anOccupiedRectangle |
	self ifNoSpace: [ ^ self layoutRowInNoSpace: aRow ].
	anOriginalArea := self original volume.
	anOccupiedArea := anOriginalArea * aRow occupiedWeight.
	anExtentToOccupy := self width @ (anOccupiedArea / self width).
	aNextNodePosition := self position.
	aRow nodes do: [ :eachNode | 
		| aHeight aWidth |
		aWidth := anExtentToOccupy x.
		aHeight := anOriginalArea * eachNode weight / aWidth.
		eachNode extent: (aWidth @ aHeight).
		eachNode position: aNextNodePosition.
		aNextNodePosition := eachNode topRight ].
	aRemainingRectangle := self class
		position: self position + (0 @ anExtentToOccupy y)
		extent: self extent - (0 @ anExtentToOccupy y).
	aRemainingRectangle original: self original.
	self remainingRectangle: aRemainingRectangle.
	anOccupiedRectangle := self class
		position: self position
		extent: anExtentToOccupy.
	anOccupiedRectangle original: self original.
	self occupiedRectangle: anOccupiedRectangle.
]

{ #category : #accessing }
GtGraphTreemapSquarifyPortraitVerticalRectangle >> length [
	"gives the length of the shortest side of the remaining subrectangle in which the current row is placed"
	<return: #Number>
	^ self width
]

{ #category : #accessing }
GtGraphTreemapSquarifyPortraitVerticalRectangle >> name [
	^ 'Portrait Vertical'
]
