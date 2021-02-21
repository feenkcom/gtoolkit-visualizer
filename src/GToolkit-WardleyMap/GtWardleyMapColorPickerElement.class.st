Class {
	#name : #GtWardleyMapColorPickerElement,
	#superclass : #BrHorizontalGrid,
	#instVars : [
		'whenColorPicked'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapColorPickerElement >> colors: aCollectionOfColors [
	self removeChildren.
	self addChildren: (aCollectionOfColors collect: [ :eachColor |
		(self createColorElementFor: eachColor)
			when: BlClickEvent do: [ :anEvent |
				anEvent consumed: true.
				whenColorPicked value: eachColor ] ])
]

{ #category : #initialization }
GtWardleyMapColorPickerElement >> createColorElementFor: aColor [
	^ BlElement new
		size: 16@16;
		background: aColor;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
		addLook: (BrStyleCommonLook new
			default: [ :s | s border: (aColor luminance >= Color lightGray luminance
				ifTrue: [ BlBorder paint: Color darkGray width: 1 ]
				ifFalse: [ BlBorder empty ]) ];
			hovered: [ :s | s border: (BlBorder paint: Color black width: 1) ])
]

{ #category : #initialization }
GtWardleyMapColorPickerElement >> initialize [
	super initialize.
	
	whenColorPicked := [ :aColor | ]
]

{ #category : #accessing }
GtWardleyMapColorPickerElement >> whenColorPickedDo: aBlockClosure [
	whenColorPicked := aBlockClosure
]
