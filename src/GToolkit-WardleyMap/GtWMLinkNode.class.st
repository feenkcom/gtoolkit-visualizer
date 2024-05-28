Class {
	#name : #GtWMLinkNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'start',
		'arrow',
		'end',
		'semicolon',
		'comment'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMLinkNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLink: self
]

{ #category : #generated }
GtWMLinkNode >> arrow [
	^ arrow
]

{ #category : #generated }
GtWMLinkNode >> arrow: aSmaCCToken [
	arrow := aSmaCCToken
]

{ #category : #generated }
GtWMLinkNode >> comment [
	^ comment
]

{ #category : #generated }
GtWMLinkNode >> comment: aSmaCCToken [
	comment := aSmaCCToken
]

{ #category : #generated }
GtWMLinkNode >> end [
	^ end
]

{ #category : #generated }
GtWMLinkNode >> end: aSmaCCToken [
	end := aSmaCCToken
]

{ #category : #generated }
GtWMLinkNode >> semicolon [
	^ semicolon
]

{ #category : #generated }
GtWMLinkNode >> semicolon: aSmaCCToken [
	semicolon := aSmaCCToken
]

{ #category : #generated }
GtWMLinkNode >> start [
	^ start
]

{ #category : #generated }
GtWMLinkNode >> start: aSmaCCToken [
	start := aSmaCCToken
]

{ #category : #generated }
GtWMLinkNode >> tokenVariables [
	^ #(#start #arrow #end #semicolon #comment)
]
