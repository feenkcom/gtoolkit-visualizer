Class {
	#name : #GtWardleyMapNodeLabelModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapWithParent + TGtWardleyMapWithCoordinate + TGtWardleyMapExportable + TGtWardleyMapVisitable',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapWithParent classTrait + TGtWardleyMapWithCoordinate classTrait + TGtWardleyMapExportable classTrait + TGtWardleyMapVisitable classTrait',
	#instVars : [
		'announcer',
		'label'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #comparing }
GtWardleyMapNodeLabelModel >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ label = anObject label
]

{ #category : #visiting }
GtWardleyMapNodeLabelModel >> accept: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMapNodeLabel: self
]

{ #category : #announcer }
GtWardleyMapNodeLabelModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - export / import' }
GtWardleyMapNodeLabelModel >> gtJSONFor: aView [
	<gtView>

	^ aView textEditor
		title: 'JSON';
		priority: 8;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ JSONParser gtStyler ];
		text: [ self asJSONForExport ];
		actionButtonLabel: 'Copy'
			action: [ Clipboard clipboardText: self asJSONForExport ]
]

{ #category : #comparing }
GtWardleyMapNodeLabelModel >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ label hash
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
	self label = aString
		ifTrue: [ ^ self ].

	label := aString.	
	self propagateAnnouncement: (GtWardleyMapNodeLabelModelTextChanged new nodeLabelModel: self)
]

{ #category : #'api - coordinate' }
GtWardleyMapNodeLabelModel >> notifyCoordinateChanged [
	self propagateAnnouncement: (GtWardleyMapNodeLabelModelMoved new nodeLabelModel: self)
]

{ #category : #'api - parent' }
GtWardleyMapNodeLabelModel >> notifyParentChanged [
	
]
