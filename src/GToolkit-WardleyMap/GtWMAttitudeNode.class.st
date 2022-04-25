Class {
	#name : #GtWMAttitudeNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'attitude',
		'coords',
		'width',
		'height'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMAttitudeNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitAttitude: self
]

{ #category : #generated }
GtWMAttitudeNode >> attitude [
	^ attitude
]

{ #category : #generated }
GtWMAttitudeNode >> attitude: aSmaCCToken [
	attitude := aSmaCCToken
]

{ #category : #generated }
GtWMAttitudeNode >> coords [
	^ coords
]

{ #category : #generated }
GtWMAttitudeNode >> coords: aGtWMProgramNode [
	self coords notNil ifTrue: [ self coords parent: nil ].
	coords := aGtWMProgramNode.
	self coords notNil ifTrue: [ self coords parent: self ]
]

{ #category : #generated }
GtWMAttitudeNode >> height [
	^ height
]

{ #category : #generated }
GtWMAttitudeNode >> height: aSmaCCToken [
	height := aSmaCCToken
]

{ #category : #generated }
GtWMAttitudeNode >> nodeVariables [
	^ #(#coords)
]

{ #category : #generated }
GtWMAttitudeNode >> tokenVariables [
	^ #(#attitude #width #height)
]

{ #category : #generated }
GtWMAttitudeNode >> width [
	^ width
]

{ #category : #generated }
GtWMAttitudeNode >> width: aSmaCCToken [
	width := aSmaCCToken
]
