Class {
	#name : #GtSequenceDiagramUtility,
	#superclass : #Object,
	#category : #'GToolkit-SequenceDiagram-Utilities'
}

{ #category : #'api - constants' }
GtSequenceDiagramUtility class >> hoveredBackgroundColor [
	^ BrGlamorousColors hoveredButtonBorderColor
]

{ #category : #'api - constants' }
GtSequenceDiagramUtility class >> labelZIndex [
	^ 3
]

{ #category : #'api - instance creation' }
GtSequenceDiagramUtility class >> messageLabelDefaultForegroudColor [
	^ Color black
]

{ #category : #'api - constants' }
GtSequenceDiagramUtility class >> messageLineWidth [
	^ 1
]

{ #category : #'api - constants' }
GtSequenceDiagramUtility class >> messageNameTextSize [
	"Message name text size"

	^ 8
]

{ #category : #'api - constants' }
GtSequenceDiagramUtility class >> messageSendLineDefaultBackgroundColor [
	^ Color black
]

{ #category : #'api - constants' }
GtSequenceDiagramUtility class >> messageZIndex [
	^ 2
]

{ #category : #'api - instance creation' }
GtSequenceDiagramUtility class >> newMessageLabel [
	^ BrLabel new
		fitContent;
		aptitude: (BrGlamorousLabelAptitude new
				fontSize: 9;
				foreground: self messageLabelDefaultForegroudColor;
				background: Color white);
		margin: (BlInsets top: -1);
		text: '';
		zIndex: self labelZIndex
]

{ #category : #'api - constants' }
GtSequenceDiagramUtility class >> verticalLineDefaultBackgroundColor [
	"Object activity vertical line color"

	^ Color lightGray
]

{ #category : #'api - constants' }
GtSequenceDiagramUtility class >> verticalLineSegmetHeight [
	"Object activity vertical line width"

	^ 27
]

{ #category : #'api - constants' }
GtSequenceDiagramUtility class >> verticalLineWidth [
	"Object activity vertical line width"

	^ 1
]
