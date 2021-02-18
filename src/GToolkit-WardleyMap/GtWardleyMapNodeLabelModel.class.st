Class {
	#name : #GtWardleyMapNodeLabelModel,
	#superclass : #Object,
	#traits : 'TGtWardleyMapWithCoordinate + TGtWardleyMapExportable',
	#classTraits : 'TGtWardleyMapWithCoordinate classTrait + TGtWardleyMapExportable classTrait',
	#instVars : [
		'label'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - export / import' }
GtWardleyMapNodeLabelModel >> asDictionaryForExport [
	"Answer the receiver as a dictionary ready for JSON serialisation.
	Users will override and add to the dictionary"

	^ OrderedDictionary new
		at: #x put: self coordinate x;
		at: #y put: self coordinate y;
		at: #text put: self label;
		yourself
]

{ #category : #initialization }
GtWardleyMapNodeLabelModel >> initialize [
	super initialize.
	
	label := 'Label'.
	coordinate := 0.5 @ 2.0
]

{ #category : #accessing }
GtWardleyMapNodeLabelModel >> label [
	<return: #String>

	^ label
]

{ #category : #accessing }
GtWardleyMapNodeLabelModel >> label: aString [
	label := aString
]
