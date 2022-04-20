Class {
	#name : #GtWMFlowLinkNode,
	#superclass : #GtWMLinkNode,
	#instVars : [
		'flowArrow',
		'flowValue'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMFlowLinkNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitFlowLink: self
]

{ #category : #generated }
GtWMFlowLinkNode >> flowArrow [
	^ flowArrow
]

{ #category : #generated }
GtWMFlowLinkNode >> flowArrow: aSmaCCToken [
	flowArrow := aSmaCCToken
]

{ #category : #generated }
GtWMFlowLinkNode >> flowValue [
	^ flowValue
]

{ #category : #generated }
GtWMFlowLinkNode >> flowValue: aSmaCCToken [
	flowValue := aSmaCCToken
]

{ #category : #generated }
GtWMFlowLinkNode >> tokenVariables [
	^ #(#flowArrow #flowValue #start #arrow #end)
]
