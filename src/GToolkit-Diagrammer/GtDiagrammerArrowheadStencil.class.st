Class {
	#name : #GtDiagrammerArrowheadStencil,
	#superclass : #GtDiagrammerStencil,
	#category : 'GToolkit-Diagrammer-Stencils - Arrowheads'
}

{ #category : #comparing }
GtDiagrammerArrowheadStencil >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].	
	
	self class = anObject class
		ifTrue: [ ^ true ].

	(anObject isKindOf: self create class)
		ifTrue: [ ^ self compareTo: anObject ].
	
	^ false
]

{ #category : #'api - actions' }
GtDiagrammerArrowheadStencil >> applyAsFromHeadOn: aCurveElement [
	aCurveElement fromHead: (self createFor: aCurveElement)
]

{ #category : #'api - actions' }
GtDiagrammerArrowheadStencil >> applyAsToHeadOn: aCurveElement [
	aCurveElement toHead: (self createFor: aCurveElement)
]

{ #category : #'gt-inspector-extension' }
GtDiagrammerArrowheadStencil >> asArrowheadInLine [
	| aLine |
	aLine := BlLineElement new.
	aLine border: (BlBorder paint: Color gray width: 5).
	aLine fromAnchor: (BlAbsolutePositionAnchor position: 30@50).
	aLine toAnchor: (BlAbsolutePositionAnchor position: 300@50).
	aLine toHead: (self createFor: aLine).
	^ aLine
]

{ #category : #comparing }
GtDiagrammerArrowheadStencil >> compareTo: anArrowheadElement [
	^ true
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadStencil >> create [
	<return: #BlArrowheadElement>

	^ self subclassResponsibility
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadStencil >> createFor: aCurveElement [
	<return: #BlArrowheadElement>

	^ self create border: aCurveElement border copy
]

{ #category : #'gt-inspector-extension' }
GtDiagrammerArrowheadStencil >> gtInspectorPreviewIn: aComposite [
	<gtInspectorPresentationOrder: 5>

	^ aComposite bloc
		title: 'Preview';
		display: [ self asArrowheadInLine ]
]

{ #category : #'gt-extension' }
GtDiagrammerArrowheadStencil >> gtLiveIn: anElement [
	anElement addChild: self asArrowheadInLine
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadStencil >> icon [
	"Create an element playing a role of an icon in a UI picker"
	<return: #BlElement>
	| cellSize aLine aContainer |

	cellSize := self iconSize.
	
	aLine := BlLineElement new.
	aLine transformDo: [ :t | t origin: BlAffineTransformationLeftCenterOrigin new; scaleBy: 1.5 ].
	aLine border: (BlBorder paint: (Color lightGray) width: 3).
	aLine fromAnchor: (BlAbsolutePositionAnchor position: ((cellSize x / 5) @ cellSize y / 2.0)).
	aLine toAnchor: (BlAbsolutePositionAnchor position: (cellSize x / 1.5 @ (cellSize y / 2.0))).
	aLine toHead: self preview.
	
	aContainer := BlElement new.
	aContainer size: cellSize.
	aContainer addChild: aLine.
	
	^ aContainer
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadStencil >> iconSize [
	^ 50@25
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadStencil >> preview [
	"Create an arrowhead used as a preview in UI"
	<return: #BlArrowheadElement>

	^ self create
]
