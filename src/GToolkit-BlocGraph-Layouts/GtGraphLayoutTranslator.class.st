Class {
	#name : #GtGraphLayoutTranslator,
	#superclass : #Object,
	#instVars : [
		'view'
	],
	#classInstVars : [
		'defaultTranslator'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Basic'
}

{ #category : #accessing }
GtGraphLayoutTranslator class >> default [
	"Return the default translator, the one used in the layouts"

	defaultTranslator ifNotNil: [ ^ defaultTranslator ].
	^ defaultTranslator := self defaultClass new
]

{ #category : #accessing }
GtGraphLayoutTranslator class >> defaultClass [
	^ self allSubclasses detect: #isDefault
]

{ #category : #accessing }
GtGraphLayoutTranslator class >> isDefault [
	^ false
]

{ #category : #accessing }
GtGraphLayoutTranslator >> nbCycles: anInteger [
	"Do nothing"
]

{ #category : #hook }
GtGraphLayoutTranslator >> translate: element by: deltaPosition [
	"Translate of the center of the element by a step"
	self translate: element to: element position + deltaPosition
]

{ #category : #hook }
GtGraphLayoutTranslator >> translate: element to: newPosition [
	"Translate of the center of the element"
	self subclassResponsibility 
]

{ #category : #'public - translating' }
GtGraphLayoutTranslator >> translate: element to: newPosition direction: aDirection [
	"Translate the bottom left corner of the element"

	self translate: element to: newPosition" + (element extent / 2 * aDirection)"
]

{ #category : #'public - translating' }
GtGraphLayoutTranslator >> translateBottomLeftOf: element to: newPosition [
	"Translate the bottom left corner of the element"

	self translate: element to: newPosition direction: 1 @ -1.
]

{ #category : #'public - translating' }
GtGraphLayoutTranslator >> translateBottomOf: element to: newPosition [
	"Translate the bottom side of the element"

	self translate: element to: element position x @ newPosition direction: 0 @ -1
]

{ #category : #'public - translating' }
GtGraphLayoutTranslator >> translateBottomRightOf: element to: newPosition [
	"Translate the bottom right corner of the element"

	self translate: element to: newPosition direction: -1 @ -1
]

{ #category : #'public - translating' }
GtGraphLayoutTranslator >> translateCenterLeftOf: element to: newPosition [
	"Translate the left center of the element to newPosition"

	self translate: element to: newPosition direction: 1 @ 0
]

{ #category : #'public - translating' }
GtGraphLayoutTranslator >> translateLeftOf: element to: newPosition [
	"Translate the left side of the element"

	self translate: element to: newPosition @ element position y direction: 1 @ 0.
]

{ #category : #'public - translating' }
GtGraphLayoutTranslator >> translateRightOf: element to: newPosition [
	"Translate the right side of the element"

	self translate: element to: newPosition @ element position y direction: -1 @ 0.
]

{ #category : #'public - translating' }
GtGraphLayoutTranslator >> translateTopLeftOf: element to: newPosition [
	"Translate the top right corner of the element"

	self translate: element to: newPosition direction: 1 @ 1
]

{ #category : #'public - translating' }
GtGraphLayoutTranslator >> translateTopOf: element to: newPosition [
	"Translate the top side of the element"

	self translate: element to: element position x @ newPosition direction: 0 @ 1.
]

{ #category : #'public - translating' }
GtGraphLayoutTranslator >> translateTopRightOf: element to: newPosition [
	"Translate the top right corner of the element"

	self translate: element to: newPosition direction: -1 @ 1
]

{ #category : #accessing }
GtGraphLayoutTranslator >> view [
	^ view
]

{ #category : #accessing }
GtGraphLayoutTranslator >> view: aView [
	view := aView
]
