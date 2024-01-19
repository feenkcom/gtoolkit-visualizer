Class {
	#name : #LePageMondrianMapExamples,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #accessing }
LePageMondrianMapExamples >> oldPatternMap [
	"The original map of patterns with default layout."

	<gtExample>
	^ LePageMondrianMap new
		pageTitles: {'Moldable Object'.
				'Moldable Data Wrapper'.
				'Project Diary'.
				'Contextual Playground'.
				'Example Object'.
				'Custom View'.
				'Custom Action'.
				'Simple View'.
				'Moldable Collection Wrapper'};
		database: LeDatabase gtBook;
		connections: {'Moldable Object'
					-> {'Moldable Data Wrapper'.
							'Project Diary'.
							'Contextual Playground'}.
				'Project Diary' -> {'Example Object'}.
				'Contextual Playground'
					-> {'Custom View'.
							'Custom Action'.
							'Example Object'}.
				'Custom View'
					-> {'Simple View'.
							'Moldable Collection Wrapper'}}
]

{ #category : #accessing }
LePageMondrianMapExamples >> oldPatternMapwithExplicitPositions [
	"The original map of patterns with explicit layout.
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
LePageMondrianMapExamples >> patternMap [
	<gtExample>
	^ self patternMapDefaultLayout
		explicitPositions: self patternMapExplicitPositions;
		yourself
]

{ #category : #accessing }
LePageMondrianMapExamples >> patternMapDefaultLayout [
	"Revised pattern map with patterns from the EuroPLoP submission.
	This is the default layout."
	<gtExample>
	^ LePageMondrianMap new
		pageTitles: {'Explainable System'.
				'Moldable Tool'.
				'Contextual Playground'.
				'Custom View'.
				'Custom Search'.
				'Custom Action'.
				'Moldable Object'.
				'Example Object'.
				'Moldable Data Wrapper'.
				'Moldable Collection Wrapper'.
				'Project Diary'.
				'Tooling Buildup'.
				'Blind Spot'.
				'Simple View'.
				'Throwaway Analysis Tool'};
		database: LeDatabase gtBook;
		connections: {'Explainable System'
					-> {'Moldable Tool'.
							'Tooling Buildup'.
							'Blind Spot'.
							'Project Diary'}.
				'Moldable Tool' -> {'Moldable Object'}.
				'Tooling Buildup' -> {'Moldable Object'}.
				'Blind Spot' -> {'Moldable Object'}.
				'Project Diary'
					-> {'Moldable Object'.
							'Example Object'}.
				'Moldable Object'
					-> {'Example Object'.
							'Contextual Playground'.
							'Moldable Data Wrapper'}.
				'Example Object' -> {'Moldable Object'}.
				'Moldable Data Wrapper' -> {'Moldable Object'}.
				'Contextual Playground'
					-> {'Custom View'.
							'Custom Search'.
							'Custom Action'}.
				'Custom View' -> {'Simple View'}.
				'Custom Search' -> {'Moldable Collection Wrapper'}.
				'Throwaway Analysis Tool' -> {'Contextual Playground'}};
		yourself
]

{ #category : #accessing }
LePageMondrianMapExamples >> patternMapExplicitPositions [
	^ {147.85599899291992 @ 263.068827311198.
		84.12199783325195 @ 343.66666666666674.
		127.85199737548828 @ 479.86234537760424.
		29.573993682861328 @ 530.460184733073.
		168.36199569702148 @ 530.460184733073.
		277.11799240112305 @ 530.460184733073.
		173.14398956298828 @ 429.2645060221355.
		418.25 @ 426.86234537760424.
		286.8819808959961 @ 479.86234537760424.
		125.70598983764648 @ 581.0580240885417.
		419.8499946594238 @ 342.66666666666674.
		202.36598587036133 @ 344.66666666666674.
		327.1059913635254 @ 345.66666666666674.
		31.827991485595703 @ 581.0580240885417.
		-22.63500213623047 @ 388.068827311198.
		149.09086528422657 @ 292.6666666666668.
		222.9257735812187 @ 292.6666666666668.
		242.13502293421251 @ 292.6666666666668.
		261.9298342429868 @ 292.6666666666668.
		150.84133005286404 @ 373.2645060221355.
		114.58270707475687 @ 509.460184733073.
		210.86330494321152 @ 509.460184733073.
		242.23835308666088 @ 509.460184733073.
		76.63999176025392 @ 560.0580240885417.
		221.73999404907227 @ 560.0580240885417.
		287.343994140625 @ 442.2072496711477.
		213.3505649137046 @ 458.86234537760424.
		269.9676235166164 @ 458.86234537760424.
		287.343994140625 @ 442.2072496711477.
		269.9676235166164 @ 458.86234537760424.
		270.6981733773149 @ 372.2645060221355.
		468.12425342262134 @ 372.2645060221355.
		235.14070452086227 @ 374.2645060221355.
		254.27232316020465 @ 375.2645060221355.
		85.91478656383653 @ 417.66666666666674}
]

{ #category : #accessing }
LePageMondrianMapExamples >> simpleMap [
	"A simple map with default layout."

	<gtExample>
	^ LePageMondrianMap new
		pageTitles: {'Glamorous Toolkit'.
				'About this book'.
				'Get started'};
		database: LeDatabase gtBook;
		connections: {'Glamorous Toolkit'
					-> {'About this book'.
							'Get started'}}
]

{ #category : #accessing }
LePageMondrianMapExamples >> simpleMapWithMissingPages [
	"A map where some pages are missing -- hover shows them as pink, and clicking goes to nil."

	<gtExample>
	^ LePageMondrianMap new
		pageTitles: {'Glamorous Toolkit'.
				'A Missing Page'.
				'Another Missing Page'};
		database: LeDatabase gtBook;
		connections: {'Glamorous Toolkit'
					-> {'A Missing Page'.
							'Another Missing Page'}}
]
