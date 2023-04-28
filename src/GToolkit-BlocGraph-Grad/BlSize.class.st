Class {
	#name : #BlSize,
	#superclass : #Object,
	#instVars : [
		'height',
		'width'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - layout' }
BlSize class >> height: sizeHeight width: sizeWidth [
	^self new height: sizeHeight width: sizeWidth
]

{ #category : #'private - layout' }
BlSize >> height: sizeHeight width: sizeWidth [
	height := sizeHeight.
	width := sizeWidth
]
