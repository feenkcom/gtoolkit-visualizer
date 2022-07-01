Class {
	#name : #GtSequenceDiagramMessageEdgeElement,
	#superclass : #BlLineElement,
	#traits : 'TGtWithSequenceDiagramMessageViewModel',
	#classTraits : 'TGtWithSequenceDiagramMessageViewModel classTrait',
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #accessing }
GtSequenceDiagramMessageEdgeElement >> initialize [
	super initialize.
	self
		aptitude: (BrStyleCommonAptitude new
				unfocused: [ :s | s border: (BlBorder paint: Color black width: 2) ];
				focused: [ :s | s border: (BlBorder paint: self theme editor focusedBorderColor width: 1) ])
]
