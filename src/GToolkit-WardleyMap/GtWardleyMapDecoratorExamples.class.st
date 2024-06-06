"
I exemplify {{gtClass:TGtWardleyMapDecorator}}. 
"
Class {
	#name : #GtWardleyMapDecoratorExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorExamples >> mapElementWithProposedModifications [
	<gtExample>
	|  aMapViewModel anElement |
	aMapViewModel := self mapViewModelWithProposedModifications.
	anElement := GtWardleyMapElement new wardleyMapViewModel: aMapViewModel.
	
	^ anElement
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorExamples >> mapViewModelWithProposedModifications [
	<gtExample>
	| aMap  aMapViewModel |
	aMap := self mapWithProposedModifications.
	aMapViewModel := GtWardleyMapViewModel new wardleyMapModel: aMap.
	
	^ aMapViewModel
]

{ #category : #examples }
GtWardleyMapDecoratorExamples >> mapWithNodes [
	<gtExample>
	^ GtWardleyMapModelExamples new newMapWithNodes
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorExamples >> mapWithProposedModifications [
	<gtExample>
	| aMap aNodeA aNodeB aNodeC anAddA aRemoveC |
	aMap := self mapWithNodes.
	aNodeA := aMap nodeWithName: 'Node A' ifFound: [ :theNode | theNode] ifNone: [ nil ].
	aNodeB := aMap nodeWithName: 'Node B' ifFound: [ :theNode | theNode] ifNone: [ nil ].
	aNodeC := aMap nodeWithName: 'Node C' ifFound: [ :theNode | theNode] ifNone: [ nil ].
	
	anAddA := GtWardleyMapAddProposition new.
	aNodeA addWardleyMapDecoratorModel: anAddA.
	aRemoveC := GtWardleyMapRemoveProposition new.
	aNodeC addWardleyMapDecoratorModel: aRemoveC.
	
	^ aMap
]
