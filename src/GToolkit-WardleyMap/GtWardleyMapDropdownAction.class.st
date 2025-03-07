Class {
	#name : #GtWardleyMapDropdownAction,
	#superclass : #GtWardleyMapAction,
	#instVars : [
		'content'
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
	anAptitude := BrGlamorousWithExplicitDropdownAptitude
			handle: [ (super newButton: aButtonClass)
					in: [ :theHandle | 
						theHandle aptitude - BrGlamorousButtonExteriorAptitude ];
					margin: BlInsets empty ]
			content: self content.
	^ (super newButton: aButtonClass) addAptitude: anAptitude
]

{ #category : #accessing }
GtWardleyMapDropdownAction >> preferredExtent: anObject [
	"ignored, we use new dropdown implementation that does not need this workaround."
]
