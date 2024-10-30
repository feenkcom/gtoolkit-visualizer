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
	^ self oldPatternMap
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
	^ {(162.85599899291992@248.068827311198). (57.12199783325195@331.66666666666674). (151.85199737548828@490.86234537760424). (27.573993682861328@548.460184733073). (176.36199569702148@550.460184733073). (330.11799240112305@549.460184733073). (173.14398956298828@429.2645060221355). (400.25@428.86234537760424). (331.8819808959961@478.86234537760424). (132.70598983764648@607.0580240885417). (409.8499946594238@329.66666666666674). (173.36598587036133@331.66666666666674). (306.1059913635254@330.66666666666674). (19.827991485595703@606.0580240885417). (-12.635002136230469@401.068827311198). (128.99312508682794@277.66666666666674). (229.38947087135608@277.66666666666674). (250.68496186051243@277.66666666666674). (271.24798444844413@277.66666666666674). (125.8946826087156@361.2645060221355). (114.65175872240796@520.460184733073). (229.8956850946925@520.460184733073). (268.66502547955145@520.460184733073). (67.20934502824751@578.0580240885417). (229.0014690425749@580.0580240885417). (287.343994140625@443.7599743036119). (230.2735420266925@458.86234537760424). (284.1955621996964@458.86234537760424). (287.343994140625@443.7599743036119). (284.1955621996964@458.86234537760424). (263.93202703347913@359.2645060221355). (455.7622500194767@359.2645060221355). (229.38883379267833@361.2645060221355). (247.46484860248592@360.2645060221355). (98.73780155531863@430.66666666666674)}
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
