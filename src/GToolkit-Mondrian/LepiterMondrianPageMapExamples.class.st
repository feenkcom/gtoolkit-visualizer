Class {
	#name : #LepiterMondrianPageMapExamples,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #accessing }
LepiterMondrianPageMapExamples >> patternMap [
	"A map of patterns with default layout."

	<gtExample>
	^ LepiterMondrianPageMap new
		pageTitles: {'Moldable object'.
				'Viewable data wrapper'.
				'Project diary'.
				'Contextual playground'.
				'Example object'.
				'Custom view'.
				'Custom action'.
				'Simple view'.
				'Collection wrapper'};
		database: LeDatabase gtBook;
		connections: {'Moldable object'
					-> {'Viewable data wrapper'.
							'Project diary'.
							'Contextual playground'}.
				'Project diary' -> {'Example object'}.
				'Contextual playground'
					-> {'Custom view'.
							'Custom action'.
							'Example object'}.
				'Custom view'
					-> {'Simple view'.
							'Collection wrapper'}}
]

{ #category : #accessing }
LepiterMondrianPageMapExamples >> patternMapwithExplicitPositions [
	"A map of patterns with explicit layout.
	The positions are obtained by manually laying out the pageMap and then evaluating:
		(self root children collect: #position)"

	<gtExample>
	^ self patternMap
		explicitPositions: {184.9584903717041 @ 245.31882731119794.
				372.0 @ 243.91666666666669.
				399.2699890136719 @ 297.9166666666667.
				163.60298538208008 @ 351.9166666666667.
				392.554988861084 @ 354.51450602213544.
				195.3509864807129 @ 420.51450602213544.
				353.4189872741699 @ 420.51450602213544.
				139.4889907836914 @ 483.1123453776042.
				241.65098571777344 @ 483.1123453776042.
				297.3524875640869 @ 259.2440187484011.
				297.3524875640869 @ 274.55073920388384.
				241.26675975939287 @ 274.9166666666667.
				446.2144626644011 @ 327.51450602213544.
				242.00638569915492 @ 381.5145060221354.
				277.1290380863739 @ 381.51450602213544.
				320.310977935791 @ 367.70853786158517.
				197.80934387551858 @ 450.11234537760424.
				257.7372079134252 @ 450.11234537760424}
]

{ #category : #accessing }
LepiterMondrianPageMapExamples >> simpleMap [
	"A simple map with default layout."

	<gtExample>
	^ LepiterMondrianPageMap new
		pageTitles: {'Glamorous Toolkit'.
				'About this book'.
				'Get started'};
		database: LeDatabase gtBook;
		connections: {'Glamorous Toolkit'
					-> {'About this book'.
							'Get started'}}
]
