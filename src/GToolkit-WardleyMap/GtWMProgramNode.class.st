Class {
	#name : #GtWMProgramNode,
	#superclass : #SmaCCParseNode,
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMProgramNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProgram: self
]
