Class {
	#name : #GtWardleyMapBeaconSignal,
	#superclass : #BeaconSignal,
	#category : #'GToolkit-WardleyMap-Beacon'
}

{ #category : #utilities }
GtWardleyMapBeaconSignal class >> labelForNodeElement: aNodeElement [
	| aNodeViewModel |
	aNodeElement ifNil: [ ^ 'nil!' ].
	aNodeElement hasWardleyMapNodeViewModel ifFalse: [ ^ '?' ].
	aNodeViewModel := aNodeElement wardleyMapNodeViewModel.
	^ aNodeViewModel label
]
