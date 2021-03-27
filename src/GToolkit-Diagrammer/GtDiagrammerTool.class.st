Class {
	#name : #GtDiagrammerTool,
	#superclass : #BlEventListener,
	#instVars : [
		'style',
		'diagrammer'
	],
	#category : #'GToolkit-Diagrammer-Tools'
}

{ #category : #comparing }
GtDiagrammerTool >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	^ true
]

{ #category : #'api - accessing' }
GtDiagrammerTool >> canvas [
	<return: #BlElement>
	
	^ self diagrammer canvas
]

{ #category : #'api - accessing' }
GtDiagrammerTool >> diagrammer [
	<return: #GtDiagrammerElement>
	
	^ diagrammer
]

{ #category : #comparing }
GtDiagrammerTool >> hash [
	^ self class hash
]

{ #category : #'api - hooks' }
GtDiagrammerTool >> onInstalledIn: aDiagrammerElement [
	diagrammer := aDiagrammerElement
]

{ #category : #'api - hooks' }
GtDiagrammerTool >> onUninstalledIn: aDiagrammerElement [
]

{ #category : #'api - accessing' }
GtDiagrammerTool >> style [
	^ style
]

{ #category : #'api - accessing' }
GtDiagrammerTool >> style: aStyle [
	style := aStyle
]

{ #category : #styles }
GtDiagrammerTool >> stylesIn: aPicker [
	aPicker
		display: [ #() ];
		shape: [ BrToggle new
			aptitude: BrMaterialToggleIconifiedAptitude;
			icon: (BlElement new
				size: 28@28;
				background: Color random);
			margin: (BlInsets all: 3) ]
]

{ #category : #'api - accessing' }
GtDiagrammerTool >> symbol [
	<return: #Character or: #String>
	
	^ self subclassResponsibility
]
