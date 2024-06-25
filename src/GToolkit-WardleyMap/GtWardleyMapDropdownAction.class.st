Class {
	#name : #GtWardleyMapDropdownAction,
	#superclass : #GtWardleyMapAction,
	#instVars : [
		'content',
		'preferredExtent'
	],
	#category : #'GToolkit-WardleyMap-! Models - Decorators'
}

{ #category : #accessing }
GtWardleyMapDropdownAction >> content [
	^ content
]

{ #category : #accessing }
GtWardleyMapDropdownAction >> content: aBlock [
	content := aBlock
]

{ #category : #accessing }
GtWardleyMapDropdownAction >> newButton: aButtonClass [
	| anAptitude |
	anAptitude := BrGlamorousWithDropdownAptitude
			handle: [ (super newButton: aButtonClass)
					in: [ :theHandle | 
						theHandle aptitude - BrGlamorousButtonExteriorAptitude ];
					margin: BlInsets empty ]
			content: self content.
	preferredExtent ifNotNil: [ anAptitude preferredExtent: preferredExtent ].
	^ (super newButton: aButtonClass) addAptitude: anAptitude
]

{ #category : #accessing }
GtWardleyMapDropdownAction >> preferredExtent [
	^ preferredExtent
]

{ #category : #accessing }
GtWardleyMapDropdownAction >> preferredExtent: anObject [
	preferredExtent := anObject
]
