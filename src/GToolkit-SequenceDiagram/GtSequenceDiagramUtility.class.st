Class {
	#name : #GtSequenceDiagramUtility,
	#superclass : #Object,
	#category : #'GToolkit-SequenceDiagram-Utilities'
}

{ #category : #'api - constants' }
GtSequenceDiagramUtility class >> labelZIndex [
	^ 3
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
				background: Color white);
		margin: (BlInsets top: -1);
		text: ''
]
