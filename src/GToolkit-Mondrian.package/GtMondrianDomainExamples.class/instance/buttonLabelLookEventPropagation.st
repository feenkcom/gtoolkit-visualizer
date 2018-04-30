examples
buttonLabelLookEventPropagation
	<gtExample>
	| aView aButtonElement theNodes |

	aButtonElement := BrButtonLabelLookExamples new buttonWithModelAndLookWithoutConstraints.
	theNodes := {
		aButtonElement.
		aButtonElement look.
		aButtonElement viewModel.
		aButtonElement children first.
		aButtonElement children first children first.
	}.

	aView := self emptyView.

	aView nodes
		shape: [ :aTarget |
			| text |
			text := aTarget gtDisplayString asRopedText.
			text attributes: {BrTextForegroundAttribute paint: Color lightGray}.
			BlTextElement new
				text: text;
				padding: (BlInsets all: 5) ];
		with: theNodes.

	aView edges 
		fromRightCenter;
		toLeftCenter;
		shape: [ :x | BlLineElement new border: (BlBorder paint: (Color lightGray alpha: 0.4)) ];
		connect: (theNodes select: [ :each | each hasOwner ])
			from: [ :aTarget | aTarget owner ].

	aView layout horizontalTree horizontalGap: 40.

	^ aView