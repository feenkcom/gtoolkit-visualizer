Class {
	#name : #GtSequenceDiagramMessageResponseEdgeElement,
	#superclass : #GtSequenceDiagramMessageEdgeElement,
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #initialization }
GtSequenceDiagramMessageResponseEdgeElement >> initialize [
	super initialize.
	self
		aptitude: (BrStyleCommonAptitude new
				unfocused: [ :s | 
					s
						border: (BlBorder builder
								paint: Color lightGray;
								width: 2;
								dashArray: #(4 4);
								build) ];
				focused: [ :s | s border: (BlBorder paint: Color lightGray width: 1) ])
]
