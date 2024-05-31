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
	self == anObject
		ifTrue: [ ^ true ].

	self class = anObject class
		ifFalse: [ ^ false ].

	^ self coordinate = anObject coordinate
		and: [ self label = anObject label ]
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
	^ self coordinate hash
		bitXor: (self label hash)
]

{ #category : #initialization }
GtWardleyMapNodeLabelModel >> initialize [
	super initialize.
	
	label := 'Label'.
	coordinate := GtWardleyMapConstants labelCoordinate.
]

{ #category : #'api - label' }
GtWardleyMapNodeLabelModel >> label [
	<return: #String>

	^ label
]

{ #category : #'api - label' }
GtWardleyMapNodeLabelModel >> label: aString [
	self label = aString ifTrue: [ ^ self ].

	label := aString.
	self notifyLabelTextChanged
]

{ #category : #'api - coordinate' }
GtWardleyMapNodeLabelModel >> notifyCoordinateChanged [
	self propagateAnnouncement: (GtWardleyMapNodeLabelModelMoved new nodeLabelModel: self)
]

{ #category : #'api - label' }
GtWardleyMapNodeLabelModel >> notifyLabelTextChanged [
	self
		propagateAnnouncement: (GtWardleyMapNodeLabelModelTextChanged new nodeLabelModel: self)
]

{ #category : #'api - parent' }
GtWardleyMapNodeLabelModel >> notifyParentChanged [
	
]
