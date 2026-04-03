Class {
	#name : #GtWardleyMapAddOptionChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'key',
		'value'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #'as yet unclassified' }
GtWardleyMapAddOptionChange >> executeNotifying: aBlock [
	| undo |
	map ensureOptions.
	undo := map
			optionAt: key
			ifPresent: [ :old | 
				self class new
					map: map;
					key: key;
					value: old;
					yourself ]
			ifAbsent: [ GtWardleyMapRemoveOptionChange new
					map: map;
					key: key;
					yourself ].
	map optionAt: key put: value.
	^ undo
]

{ #category : #accessing }
GtWardleyMapAddOptionChange >> key [
	^ key
]

{ #category : #accessing }
GtWardleyMapAddOptionChange >> key: anObject [
	key := anObject
]

{ #category : #accessing }
GtWardleyMapAddOptionChange >> value [
	^ value
]

{ #category : #accessing }
GtWardleyMapAddOptionChange >> value: anObject [
	value := anObject
]
