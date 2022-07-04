Class {
	#name : #GtSequenceDiagramMessageSendEdgeElement,
	#superclass : #GtSequenceDiagramMessageEdgeElement,
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #accessing }
GtSequenceDiagramMessageSendEdgeElement >> initialize [
	super initialize.
	self
		aptitude: (BrStyleCommonAptitude new
				unfocused: [ :s | 
					s
						border: (BlBorder builder
								paint: Color black;
								width: 2;
								build) ];
				focused: [ :s | s border: (BlBorder paint: self theme editor focusedBorderColor width: 1) ])
]
