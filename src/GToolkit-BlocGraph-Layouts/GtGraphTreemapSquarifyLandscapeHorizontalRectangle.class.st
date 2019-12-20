"
I am a copy of class GtGraphTreemapSquarifyLandscapeRectangle. This comment is copied from there, and might not be entirely accurate

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
	#name : #GtGraphTreemapSquarifyLandscapeHorizontalRectangle,
	#superclass : #GtGraphTreemapSquarifyAreaRectangle,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'instance creation' }
GtGraphTreemapSquarifyLandscapeHorizontalRectangle class >> newOtherDirection [
	^ GtGraphTreemapSquarifyLandscapeVerticalRectangle new
]

{ #category : #accessing }
GtGraphTreemapSquarifyLandscapeHorizontalRectangle >> aspectRatioForWeightRatio: aWeightRatio occupiedExtent: anOccupiedExtent [ 
	| aLenght |
	aLenght := aWeightRatio * anOccupiedExtent y.
	^ (aLenght / anOccupiedExtent x) max: (anOccupiedExtent x / aLenght).
]

{ #category : #accessing }
GtGraphTreemapSquarifyLandscapeHorizontalRectangle >> extentOccupiedBy: aRow [
	^ self extent * (aRow occupiedWeight @ 1)
]

{ #category : #accessing }
GtGraphTreemapSquarifyLandscapeHorizontalRectangle >> layoutRow: aRow [
	| anExtentToOccupy aNextNodePosition aRemainingRectangle anOriginalArea anOccupiedArea anOccupiedRectangle |
	self ifNoSpace: [ ^ self layoutRowInNoSpace: aRow ].
	anOriginalArea := self original volume.
	anOccupiedArea := anOriginalArea * aRow occupiedWeight.
	anExtentToOccupy := (anOccupiedArea / self height) @ self height.
	aNextNodePosition := self position.
	aRow nodes do: [ :eachNode | 
		| aHeight aWidth |
		aHeight := anExtentToOccupy y.
		aWidth := anOriginalArea * eachNode weight / aHeight.
		eachNode extent: (aWidth @ aHeight).
		eachNode position: aNextNodePosition.
		aNextNodePosition := eachNode topRight ].
	aRemainingRectangle := self class
		position: self position + (anExtentToOccupy x @ 0)
		extent: self extent - (anExtentToOccupy x @ 0).
	aRemainingRectangle original: self original.
	self remainingRectangle: aRemainingRectangle.
	anOccupiedRectangle := self class
		position: self position
		extent: anExtentToOccupy.
	anOccupiedRectangle original: self original.
	self occupiedRectangle: anOccupiedRectangle.
]

{ #category : #accessing }
GtGraphTreemapSquarifyLandscapeHorizontalRectangle >> length [
	"gives the length of the shortest side of the remaining subrectangle in which the current row is placed"
	<return: #Number>
	^ self height
]

{ #category : #accessing }
GtGraphTreemapSquarifyLandscapeHorizontalRectangle >> name [
	^ 'Landscape Horizontal'
]
