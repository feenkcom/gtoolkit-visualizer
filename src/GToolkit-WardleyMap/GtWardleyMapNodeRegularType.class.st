Class {
	#name : #GtWardleyMapNodeRegularType,
	#superclass : #Object,
	#traits : 'TGtWardleyMapNodeType + TGtUniqueInstance',
	#classTraits : 'TGtWardleyMapNodeType classTrait + TGtUniqueInstance classTrait',
	#category : #'GToolkit-WardleyMap-Helpers - Node Type'
}

{ #category : #printing }
GtWardleyMapNodeRegularType >> gtDisplayText [
	^ 'regular' asRopedText
]

{ #category : #'api - testing' }
GtWardleyMapNodeRegularType >> isRegularNode [
	^ true
]
