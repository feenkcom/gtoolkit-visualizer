Class {
	#name : #GtWardleyMapEdgeLabelModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapWithParent + TGtWardleyMapWithCoordinate + TGtWardleyMapExportable + TGtWardleyMapVisitable',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapWithParent classTrait + TGtWardleyMapWithCoordinate classTrait + TGtWardleyMapExportable classTrait + TGtWardleyMapVisitable classTrait',
	#instVars : [
		'announcer',
		'label',
		'isVisible'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #comparing }
GtWardleyMapEdgeLabelModel >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].

	self class = anObject class
		ifFalse: [ ^ false ].

	^ self coordinate = anObject coordinate
		and: [ self label = anObject label
			and: [ self isVisible = anObject isVisible ] ]
]

{ #category : #visiting }
GtWardleyMapEdgeLabelModel >> accept: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMapEdgeLabel: self
]

{ #category : #announcer }
GtWardleyMapEdgeLabelModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - export / import' }
GtWardleyMapEdgeLabelModel >> gtJSONFor: aView [
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
GtWardleyMapEdgeLabelModel >> hash [
	^ self coordinate hash
		bitXor: (self label hash
			bitXor: self isVisible hash)
]

{ #category : #initialization }
GtWardleyMapEdgeLabelModel >> initialize [
	super initialize.
	
	label := 'Edge label'.
	coordinate := GtWardleyMapConstants edgeLabelCoordinate.
	isVisible := false.
]

{ #category : #accessing }
GtWardleyMapEdgeLabelModel >> isVisible [
	"Return true if label should be displayed, false otherwise."

	^ isVisible ifNil: [ false ]
]

{ #category : #accessing }
GtWardleyMapEdgeLabelModel >> isVisible: aBoolean [
	self isVisible = aBoolean
		ifTrue: [ ^ self ].

	isVisible := aBoolean.
	self propagateAnnouncement: (GtWardleyMapEdgeLabelModelVisibilityChanged new edgeLabelModel: self)
]

{ #category : #accessing }
GtWardleyMapEdgeLabelModel >> label [
	<return: #String>

	^ label
]

{ #category : #accessing }
GtWardleyMapEdgeLabelModel >> label: aString [
	self label = aString
		ifTrue: [ ^ self ].

	label := aString.
	self propagateAnnouncement: (GtWardleyMapEdgeLabelModelTextChanged new edgeLabelModel: self)
]

{ #category : #'api - coordinate' }
GtWardleyMapEdgeLabelModel >> notifyCoordinateChanged [
	self propagateAnnouncement: (GtWardleyMapEdgeLabelModelMoved new edgeLabelModel: self)
]

{ #category : #'api - parent' }
GtWardleyMapEdgeLabelModel >> notifyParentChanged [
	
]
