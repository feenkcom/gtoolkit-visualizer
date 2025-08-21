Class {
	#name : #LePageMondrianMapExamples,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #accessing }
LePageMondrianMapExamples >> oldPatternMap [
	"The original map of patterns with default layout."

	<gtExample>
	<return: #LePageMondrianMap>
	| map |
	map := LePageMondrianMap new
			pageTitles: {'Moldable Object'.
					'Moldable Data Wrapper'.
					'Project Diary'.
					'Contextual Playground'.
					'Example Object'.
					'Contextual View'.
					'Contextual Action'.
					'Simple View'.
					'Moldable Collection Wrapper'};
			database: LeDatabase gtBook;
			connections: {'Moldable Object'
						-> {'Moldable Data Wrapper'.
								'Project Diary'.
								'Contextual Playground'}.
					'Project Diary' -> {'Example Object'}.
					'Contextual Playground'
						-> {'Contextual View'.
								'Contextual Action'.
								'Example Object'}.
					'Contextual View'
						-> {'Simple View'.
								'Moldable Collection Wrapper'}}.
	self assert: map missingPages isEmpty.
	^ map
]

{ #category : #accessing }
LePageMondrianMapExamples >> oldPatternMapwithExplicitPositions [
	"The original map of patterns with explicit layout.
	The positions are obtained by manually laying out the pageMap and then evaluating:
		(self root children collect: #position)"

	<gtExample>
	<return: #LePageMondrianMap>
	| map |
	map := self oldPatternMap
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
					257.7372079134252 @ 450.11234537760424}.
	self assert: map missingPages isEmpty.
	^ map
]

{ #category : #accessing }
LePageMondrianMapExamples >> patternMap [
	<gtExample>
	<return: #LePageMondrianMap>
	| map |
	map := self patternMapDefaultLayout
			explicitPositions: self patternMapExplicitPositions;
			yourself.
	self assert: map missingPages isEmpty.
	^ map
]

{ #category : #accessing }
LePageMondrianMapExamples >> patternMapDefaultLayout [
	"Revised pattern map with patterns from the EuroPLoP submission.
	This is the default layout."

	<gtExample>
	<return: #LePageMondrianMap>
	| map |
	map := LePageMondrianMap new
			pageTitles: {'Explainable System'.
					'Moldable Tool'.
					'Contextual Playground'.
					'Contextual View'.
					'Contextual Search'.
					'Contextual Action'.
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
						-> {'Contextual View'.
								'Contextual Search'.
								'Contextual Action'}.
					'Contextual View' -> {'Simple View'}.
					'Contextual Search' -> {'Moldable Collection Wrapper'}.
					'Throwaway Analysis Tool' -> {'Contextual Playground'}};
			yourself.
	self assert: map missingPages isEmpty.
	^ map
]

{ #category : #accessing }
LePageMondrianMapExamples >> patternMapExplicitPositions [
	^ {(162.85599899291992@248.068827311198). (57.12199783325195@331.66666666666674). (151.85199737548828@490.86234537760424). (27.573993682861328@548.460184733073). (176.36199569702148@550.460184733073). (330.11799240112305@549.460184733073). (173.14398956298828@429.2645060221355). (400.25@428.86234537760424). (331.8819808959961@478.86234537760424). (132.70598983764648@607.0580240885417). (409.8499946594238@329.66666666666674). (173.36598587036133@331.66666666666674). (306.1059913635254@330.66666666666674). (19.827991485595703@606.0580240885417). (-12.635002136230469@401.068827311198). (128.99312508682794@277.66666666666674). (229.38947087135608@277.66666666666674). (250.68496186051243@277.66666666666674). (271.24798444844413@277.66666666666674). (125.8946826087156@361.2645060221355). (114.65175872240796@520.460184733073). (229.8956850946925@520.460184733073). (268.66502547955145@520.460184733073). (67.20934502824751@578.0580240885417). (229.0014690425749@580.0580240885417). (287.343994140625@443.7599743036119). (230.2735420266925@458.86234537760424). (284.1955621996964@458.86234537760424). (287.343994140625@443.7599743036119). (284.1955621996964@458.86234537760424). (263.93202703347913@359.2645060221355). (455.7622500194767@359.2645060221355). (229.38883379267833@361.2645060221355). (247.46484860248592@360.2645060221355). (98.73780155531863@430.66666666666674)}
]

{ #category : #accessing }
LePageMondrianMapExamples >> patternMapWithCategories [
	"Pattern map from EuroPLoP 24 paper, with categories and Composed Narrative"

	<gtExample>
	<return: #LePageMondrianMap>
	| map |
	map := LePageMondrianMap new
			pageCategoriesAndTitles: self patternPagesWithCategories;
			database: LeDatabase gtBook;
			connectionsWithCategories: {{''.
						'Explainable System'}
						-> {{'(T) '.
									'Moldable Tool'}.
								{'(P) '.
									'Tooling Buildup'}.
								{'(P) '.
									'Blind Spot'}.
								{'(P) '.
									'Project Diary'}}.
					{'(T) '.
						'Moldable Tool'}
						-> {{'(M) '.
									'Moldable Object'}}.
					{'(P) '.
						'Tooling Buildup'}
						-> {{'(M) '.
									'Moldable Object'}}.
					{'(P) '.
						'Blind Spot'}
						-> {{'(T) '.
									'Composed Narrative'}.
								{'(M) '.
									'Moldable Object'}}.
					{'(T) '.
						'Composed Narrative'}
						-> {{'(T) '.
									'Moldable Tool'}.
								{'(M) '.
									'Moldable Object'}}.
					{'(P) '.
						'Project Diary'}
						-> {{'(T) '.
									'Composed Narrative'}.
								{'(M) '.
									'Example Object'}}.
					{'(M) '.
						'Moldable Object'}
						-> {{'(M) '.
									'Example Object'}.
								{'(T) '.
									'Contextual Playground'}.
								{'(M) '.
									'Moldable Data Wrapper'}}.
					{'(M) '.
						'Example Object'}
						-> {{'(M) '.
									'Moldable Object'}}.
					{'(M) '.
						'Moldable Data Wrapper'}
						-> {{'(M) '.
									'Moldable Object'}}.
					{'(T) '.
						'Contextual Playground'}
						-> {{'(T) '.
									'Contextual View'}.
								{'(T) '.
									'Contextual Search'}.
								{'(T) '.
									'Contextual Action'}}.
					{'(T) '.
						'Contextual View'}
						-> {{'(P) '.
									'Simple View'}}.
					{'(T) '.
						'Contextual Search'}
						-> {{'(M) '.
									'Moldable Collection Wrapper'}}.
					{'(P) '.
						'Throwaway Analysis Tool'}
						-> {{'(T) '.
									'Contextual Playground'}}};
			yourself.
	self assert: map missingPages isEmpty.
	^ map
		explicitPositions: self patternMapWithCategoriesExplicitPositions;
		yourself
]

{ #category : #accessing }
LePageMondrianMapExamples >> patternMapWithCategoriesExplicitPositions [
	^ {(42.47800064086914@52.98549397786462). (-165.02799606323242@184.58333333333337). (21.202003479003906@308.77901204427087). (51.85099983215332@362.3768513997396). (282.8230037689209@363.3768513997396). (-164.20500373840332@362.3768513997396). (29.22899627685547@183.18117268880212). (40.552001953125@251.18117268880212). (-164.5@251.77901204427087). (280.44799041748047@250.77901204427087). (282.2249927520752@421.97469075520837). (51.46799850463867@117.58333333333337). (-163.5680046081543@118.58333333333337). (281.94800186157227@116.58333333333337). (53.82499885559082@422.97469075520837). (282.2589988708496@287.9854939778646). (-80.6736785082072@82.58333333333337). (-50.989956334651794@82.58333333333337). (161.26305677126857@82.58333333333337). (109.14527439622032@82.58333333333337). (-57.24437334591479@214.18117268880212). (108.74588442211643@338.3768513997396). (173.4247453590247@338.3768513997396). (-44.1598731439729@338.3768513997396). (108.52499580383301@391.97469075520837). (356.9212265577813@392.97469075520837). (-44.5680046081543@198.50411230707226). (109.20330556424382@212.77901204427087). (-30.797996520996094@266.1785041257077). (109.23360201165006@280.77901204427087). (177.85199737548828@265.71720979317337). (-30.797996520996094@266.1785041257077). (177.85199737548828@265.71720979317337). (109.0260129251521@147.18117268880212). (-74.86300155399843@147.18117268880212). (-74.70589959777348@148.18117268880212). (158.53933285474488@146.1597730780413). (133.61137343572346@146.18117268880212). (197.44799041748047@310.17137655920493)}
]

{ #category : #accessing }
LePageMondrianMapExamples >> patternPagesWithCategories [
	<gtExample>
	<return: #Array>
	^ {{''.
			'Explainable System'}.
		{'(T) '.
			'Moldable Tool'}.
		{'(T) '.
			'Contextual Playground'}.
		{'(T) '.
			'Contextual View'}.
		{'(T) '.
			'Contextual Search'}.
		{'(T) '.
			'Contextual Action'}.
		{'(T) '.
			'Composed Narrative'}.
		{'(M) '.
			'Moldable Object'}.
		{'(M) '.
			'Example Object'}.
		{'(M) '.
			'Moldable Data Wrapper'}.
		{'(M) '.
			'Moldable Collection Wrapper'}.
		{'(P) '.
			'Project Diary'}.
		{'(P) '.
			'Tooling Buildup'}.
		{'(P) '.
			'Blind Spot'}.
		{'(P) '.
			'Simple View'}.
		{'(P) '.
			'Throwaway Analysis Tool'}}
]

{ #category : #accessing }
LePageMondrianMapExamples >> simpleMap [
	"A simple map with default layout."

	<gtExample>
	<return: #LePageMondrianMap>
	| map |
	map := LePageMondrianMap new
			pageTitles: {'Glamorous Toolkit'.
					'About this book'.
					'Get started'};
			database: LeDatabase gtBook;
			connections: {'Glamorous Toolkit'
						-> {'About this book'.
								'Get started'}}.
	self assert: map missingPages isEmpty.
	^ map
]

{ #category : #accessing }
LePageMondrianMapExamples >> simpleMapWithCategories [
	<gtExample>
	<return: #LePageMondrianMap>
	| map |
	map := LePageMondrianMap new
			pageCategoriesAndTitles: {{''.
						'Explainable System'}.
					{'(T) '.
						'Moldable Tool'}.
					{'(P) '.
						'Tooling Buildup'}};
			database: LeDatabase gtBook;
			connectionsWithCategories: {{''.
						'Explainable System'}
						-> {{'(T) '.
									'Moldable Tool'}.
								{'(P) '.
									'Tooling Buildup'}}}.
	self assert: map missingPages isEmpty.
	^ map
]

{ #category : #accessing }
LePageMondrianMapExamples >> simpleMapWithMissingPages [
	"A map where some pages are missing -- hover shows them as pink, and clicking goes to nil."

	<gtExample>
	<return: #LePageMondrianMap>
	^ LePageMondrianMap new
		pageTitles: {'Glamorous Toolkit'.
				'A Missing Page'.
				'Another Missing Page'};
		database: LeDatabase gtBook;
		connections: {'Glamorous Toolkit'
					-> {'A Missing Page'.
							'Another Missing Page'}}
]
