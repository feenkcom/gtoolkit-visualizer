tutorial - shapes
nodesWithText
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :x | 
			BlTextElement new
				text: x gtDisplayString asRopedText;
				padding: (BlInsets all: 5);
				geometry: BlEllipse new ];
		with: (1 to: 9).
	^ view