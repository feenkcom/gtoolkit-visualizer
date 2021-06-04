"
I allow users to pick a number from an interval


"
Class {
	#name : #GtDiagrammerNumberPicker,
	#superclass : #GtDiagrammerPicker,
	#instVars : [
		'printBlock'
	],
	#category : #'GToolkit-Diagrammer-UI-Pickers'
}

{ #category : #printing }
GtDiagrammerNumberPicker >> format: aBlock [
	printBlock := aBlock
]

{ #category : #initialization }
GtDiagrammerNumberPicker >> initialize [
	super initialize.

	printBlock := #asString.

	self display: [ { 
		0 . 1 . 2 . 3 . 4 . 5 . 6 . 7 . 8 . 9 . 10.
		12 . 14 . 16 . 18 . 20. 24 . 28 . 32.
		36. 40. 48 . 56 . 64 . 72. 96
	 } ].

	self shape: [ :aNumber | BrToggle new
		margin: (BlInsets all: 3);
		aptitude: BrMaterialToggleLabelledAptitude;
		label: (printBlock value: aNumber) ]
]
