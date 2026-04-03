Class {
	#name : #GtWardleyMapRemoveOptionChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'key'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #'as yet unclassified' }
GtWardleyMapRemoveOptionChange >> executeNotifying: aBlock [
	| currentValue undo |
	currentValue := map hasOptions ifTrue: [ map optionAt: key ifAbsent: [  ] ].
	undo := GtWardleyMapAddOptionChange new
			map: map;
			key: key;
			value: currentValue;
			yourself.
	map clearOption: key ifAbsent: [  ].
	^ undo
]

{ #category : #accessing }
GtWardleyMapRemoveOptionChange >> key [
	^ key
]

{ #category : #accessing }
GtWardleyMapRemoveOptionChange >> key: anObject [
	key := anObject
]
