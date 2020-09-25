Class {
	#name : #GtGraphDirectLayoutTranslator,
	#superclass : #GtGraphLayoutTranslator,
	#category : #'GToolkit-BlocGraph-Layouts-Basic'
}

{ #category : #accessing }
GtGraphDirectLayoutTranslator class >> isDefault [
	^ true
]

{ #category : #hook }
GtGraphDirectLayoutTranslator >> translate: element to: newPosition [
	element position: newPosition asFloatPoint
]
