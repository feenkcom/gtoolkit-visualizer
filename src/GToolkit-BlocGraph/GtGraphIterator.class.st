"
I am an iterator that is used to iterate over connected edges and nodes within a graph of elements.


"
Class {
	#name : #GtGraphIterator,
	#superclass : #Object,
	#instVars : [
		'graphElement'
	],
	#category : 'GToolkit-BlocGraph'
}

{ #category : #'instance creation' }
GtGraphIterator class >> new [
	self error: '(Use on: instead) I must be always created in a context of a graph element'
]

{ #category : #'instance creation' }
GtGraphIterator class >> on: aGtGraphEement [
	^ self basicNew
		initialize;
		graphElement: aGtGraphEement
]

{ #category : #'api - converting' }
GtGraphIterator >> asArray [
	"Return a collection of all items enumerable by this iterator"
	<return: #Array of: #Object>

	^ Array streamContents: [ :aStream | self do: [ :anObject | aStream nextPut: anObject ] ]
]

{ #category : #'api - enumeration' }
GtGraphIterator >> do: aBlock [
	"Evaluate a given block with all iterator items"
	
	^ self subclassResponsibility
]

{ #category : #'private - accessing' }
GtGraphIterator >> graphElement [
	<return: #GtGraphEement>

	^ graphElement
]

{ #category : #'private - accessing' }
GtGraphIterator >> graphElement: aGtGraphEement [
	graphElement := aGtGraphEement
]

{ #category : #'gt-inspector-extension' }
GtGraphIterator >> gtInspectorItemsIn: aComposite [
	<gtInspectorPresentationOrder: 5>
	
	^ aComposite fastList
		title: 'Items';
		display: [ self asArray ]
]

{ #category : #'api - testing' }
GtGraphIterator >> hasAny [
	"Return true if I have any items"
	<return: #Boolean>
	
	self do: [ :anObject | ^ true ].
	^ false
]

{ #category : #'api - testing' }
GtGraphIterator >> hasNone [
	"Return true if I don't have any items, false otherwise"
	<return: #Boolean>
	
	self do: [ :anObject | ^ false ].
	^ true
]

{ #category : #'api - testing' }
GtGraphIterator >> isEmpty [
	<return: #Boolean>

	^ self hasNone
]

{ #category : #'api - testing' }
GtGraphIterator >> isNotEmpty [
	<return: #Boolean>

	^ self hasAny
]

{ #category : #'api - enumeration' }
GtGraphIterator >> select: selectBlock thenDo: doBlock [
	"Utility method to improve readability.
	Do not create the intermediate collection."
	
	self do: [ :anElement |
		(selectBlock value: anElement)
			ifTrue: [ doBlock value: anElement ] ]
]

{ #category : #'api - accessing' }
GtGraphIterator >> size [
	"Return amount of items that can be returned by this iterator.
	Please note, I have to iterate over all items, so complexity is linear"
	<return: #Number>
	| aCounter |

	aCounter := 0.
	self do: [ :anObject | aCounter := aCounter + 1 ].
	^ aCounter
]
