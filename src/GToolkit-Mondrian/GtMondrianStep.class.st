"
I am a utility class that holds the state about the current step in the Mondrian view creation. I am particularly useful in the case of constructs like ==nodes:forEach:== which creates  a nested step. For example, in this case, the ==shape== should describe the scope inside the step and not be applicable in the broader scope.
"
Class {
	#name : #GtMondrianStep,
	#superclass : #Object,
	#instVars : [
		'root',
		'childrenContainers',
		'objectsToNodesCache'
	],
	#category : 'GToolkit-Mondrian'
}

{ #category : #accessing }
GtMondrianStep >> addChildren: aCollection [ 
	self addChildren: aCollection in: #default
]

{ #category : #accessing }
GtMondrianStep >> addChildren: aCollection in: aSymbol [
	"At this stage we need to gather the elements that can contain children from the child.
	We do not want to do it later, because at a later time we might have other Mondrian child nodes
	that also appear as Bloc elements"

	aCollection do: [ :each | each graph identifyChildrenContainers ].
	root graph addChildren: aCollection inChildrenContainer: aSymbol
]

{ #category : #initialization }
GtMondrianStep >> initialize [
	objectsToNodesCache := IdentityDictionary new
]

{ #category : #accessing }
GtMondrianStep >> layout: aLayout [
	root layout: aLayout
]

{ #category : #accessing }
GtMondrianStep >> nodeAt: anObject ifAbsent: aBlock [
	^ objectsToNodesCache
		at: anObject 
		ifAbsent: aBlock
]

{ #category : #accessing }
GtMondrianStep >> nodeAt: anObject put: aNode [
	^ objectsToNodesCache at: anObject put: aNode
]

{ #category : #accessing }
GtMondrianStep >> root [
	^ root
]

{ #category : #accessing }
GtMondrianStep >> root: anElement [
	"The root is a Bloc element that is marked as children container.
	It is not necessarily a Mondrian node"
	root := anElement.
	root layout: GtGraphGridLayout new
]
