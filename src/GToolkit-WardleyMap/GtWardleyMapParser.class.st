Class {
	#name : #GtWardleyMapParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWardleyMapParser class >> ambiguousTransitions [
^#(
#[ 0 6 0 153] 
#[ 0 6 1 13] 
#[ 0 6 0 114] 
#[ 0 6 0 130] 
#[ 0 6 0 158]
	).
]

{ #category : #'generated-accessing' }
GtWardleyMapParser class >> cacheId [
	^'2024-05-22T06:10:40.307849-04:00'
]

{ #category : #generated }
GtWardleyMapParser class >> definitionComment [
"%glr;


%id <name> <float>;
%hierarchy Link (FlowLink);
%prefix GtWM;
%suffix Node;
%root Program;
%excludes name;title <titleLabel>
	: [^\s] [^\r\n]*
	;
title name nameWithoutNumber default <whitespace>
	: [ \t\v]+
	;
<float>
	: \-? \d+ (\. \d+)?
	;
nameWithoutNumber <nameWithoutNumber>
	: [^\s]+ (\s+ [^\s\d][^\s]*)*
	;
name default <nodeName>
	: [^\s\-\[\]] | \-[^\>\[\]] | \+[^\<\>\[\]]
	;
url <url>
	: [^\r\n\)\]]+
	;
<comment>
	: \/\/ [^\r\n]*
	;
title name nameWithoutNumber default  <eol>
	: [\r\n]+
	;
<anchor>
	: anchor
	;
<annotation>
	: annotation
	;
<annotations>
	: annotations
	;
<build>
	: build
	;
<buy>
	: buy
	;
<component>
	: component
	;
<ecosystem>
	: ecosystem
	;
<evolution>
	: evolution
	;
<evolve>
	: evolve
	;
<inertia>
	: inertia
	;
<label>
	: label
	;
<market>
	: market
	;
<note>
	: note
	;
<outsource>
	: outsource
	;
<pioneers>
	: pioneers
	;
<pipeline>
	: pipeline
	;
<settlers>
	: settlers
	;
<style>
	: style
	;
<submap>
	: submap
	;
<title>
	: title
	;
<townplanners>
	: townplanners
	;
<url>
	: url
	;
<yAxis>
	: y\-axis
	;
map 
	: Lines Eols? {{File}}
	;
Lines
	: Eols? Line (Eols Line)* 
	;
Eols
	: SwitchToDefault <eol>+
	;
Line
	: Title 'title'
	| Anchor 'anchor'
	| Element 'element'
	| Evolve 'evolve'
	| Link 'link'
	| Annotation 'annotation'
	| PresentationAnnotation 'presentationAnnotation'
	| PresentationStyle 'style'
	| Note 'note'
	| Pipeline 'pipeline'
	| PresentationYAxis 'yAxis'
	| Evolution 'evolution'
	| Method 'method'
	| Submap 'submap'
	| Url 'url'
	| Attitude 'attitude'
	| Market 'market'
	| Ecosystem 'ecosystem'
	;
PresentationYAxis
	: SwitchToName <yAxis> 'yAxisToken' <name> 'label' ""->"" 'arrow' <name> 'min' ""->"" 'arrow' <name> 'max' {{}}
	;
PresentationAnnotation
	: <annotations> 'annotationsToken' Coords 'annotations' {{}}
	;
PresentationStyle
	: SwitchToName <style> 'styleToken' <name> 'style' {{}}
	;
Link
	: <name> 'start' SwitchToName (""+>"" 'arrow' | ""+<>"" 'arrow' | ""+<"" 'arrow' | ""->"" 'arrow') <name> 'end' {{Link}}
	| <name> 'start' SwitchToName ""+'"" 'flowArrow' <name> 'flowValue' (""'>"" 'arrow' | ""'<>"" 'arrow' | ""'<"" 'arrow') <name> 'end' {{FlowLink}}
	;
Anchor
	: SwitchToName <anchor> 'anchorToken' <name> 'name' Coords 'position' {{}}
	;
Coords
	: SwitchToDefault ""["" 'left' (<float> 'visibility' "","" 'comma')? <float> 'maturity' ""]"" 'right' {{}}
	;
Evolve
	: SwitchToNameWithoutNumber <evolve> 'evolveToken' SwitchToDefault <nameWithoutNumber> 'name' <float> 'maturity' Decorators (Label 'label' Decorators )?{{}}
	;
SwitchToNameWithoutNumber
	: [self scope: #nameWithoutNumber. nil]
	;
Pipeline
	: SwitchToName <pipeline> 'pipelineToken' <name> 'name' (SwitchToDefault ""["" 'left' <float> 'maturity1' "","" 'comma' <float> 'maturity2' ""]"" 'right')? {{}}
	| SwitchToName <pipeline> 'pipelineToken' <name> 'name' SwitchToDefault <eol> ""{"" 'left' <eol> InsidePipelines? ""}"" 'right' {{}}
	;
InsidePipelines
	: Eols ? InsidePipeline (Eols InsidePipeline)* Eols?
	;
InsidePipeline
	: Element 'element'
	| Evolve 'evolve'
	;
Element
	: SwitchToName <component> 'typeToken' ExtendableComponent? {{}}
	;
ExtendableComponent 
	: <name> 'name' (Coords 'coords' Decorators (<inertia> 'inertiaToken' Decorators )?  (Label 'label' Decorators)?)?
	;
Label
	: <label> 'labelToken' ""["" 'left' <float> 'x' "","" 'comma' <float> 'y' ""]"" 'right' {{}}
	;
Decorators
	: Decorator 'decorator'*
	;
Decorator
	: ""("" 'left' (<build> 'type' | <buy> 'type'| <outsource> 'type' | <market> 'type' | <ecosystem> 'type') "")"" 'right' {{}}
	;
Annotation
	: <annotation> 'annotationToken' <float> 'number' ""["" 'left' Coords 'occurrence' ("","" 'comma' Coords 'occurrence')* SwitchToName ""]"" 'right' <name> 'text' {{}}
	| <annotation> 'annotationToken' <float> 'number' Coords 'occurrence' <name> 'text' {{}}
	;
Note
	: SwitchToName <note> 'noteToken' SwitchToDefault <name> 'label' (Coords 'position')? {{}}
	;
Evolution
	: SwitchToName <evolution> 'evolutionToken' <name> 'line1' (""->"" 'arrow' <name> 'line2' (""->"" 'arrow' <name> 'line3' (""->"" 'arrow' <name> 'line4')?)?)? {{}}
	;
Method
	: SwitchToTitle (<buy> 'keyword' | <outsource> 'keyword' | <build> 'keyword') SwitchToDefault <titleLabel> 'name' {{}}
	;
Submap
	: <submap> 'submapToken' <url> 'urlToken' SwitchToUrl ""("" 'left' <url> 'url' SwitchToDefault "")"" 'right' {{}}
	;
SwitchToUrl
	: [self scope: #url. nil]
	;
Market
	: SwitchToName <market> 'typeToken' ExtendableComponent {{Element}} 
	;
Ecosystem
	: SwitchToName <ecosystem> 'typeToken' ExtendableComponent {{Element}}
	;
Url
	: SwitchToName <url> 'urlToken' <name> 'name' SwitchToUrl ""["" 'left' <url> 'url' SwitchToDefault ""]"" 'right' {{}}
	;
SwitchToName
	: [self scope: #name. nil]
	;
SwitchToName
	:
	;
Attitude
	: (<pioneers> 'attitude' | <settlers> 'attitude' | <townplanners> 'attitude') (Coords 'coords' | ManyCoords 'coords') <float> 'width' <float> 'height' {{}}
	;
ManyCoords
	: ""["" 'left' <float> 'visibility' "","" 'comma' <float> 'maturity' "","" 'comma' <float> 'visibility2' "","" 'comma' <float> 'maturity2' ""]"" 'right' {{}}
	;
Title
	: SwitchToTitle <title> 'titleToken' SwitchToDefault <titleLabel> 'name' {{}}
	;
SwitchToDefault
	: [self scope: #default. nil]
	;
SwitchToTitle
	: [self scope: #title. nil]
	;"
]

{ #category : #generated }
GtWardleyMapParser class >> reduceTable [
^#(
	#(88 0 #reduceActionForSwitchToDefault1: 5214209 true) 
	#(84 0 #reduceActionForSwitchToName1: 4719617 true) 
	#(89 0 #reduceActionForSwitchToTitle1: 5265409 true) 
	#(61 0 #reduceActionForSwitchToNameWithoutNumber1: 2565121 true) 
	#(47 1 #reduceActionFormap1: 1088513 false) 
	#(50 0 #reduceActionFor_Eols_Line__1: 1141761 false) 
	#(53 1 #reduceActionForLine11: 1193995 false) 
	#(53 1 #reduceActionForLine7: 1193991 false) 
	#(53 1 #reduceActionForLine8: 1193992 false) 
	#(53 1 #reduceActionForLine5: 1193989 false) 
	#(53 1 #reduceActionForLine2: 1193986 false) 
	#(53 1 #reduceActionForLine4: 1193988 false) 
	#(53 1 #reduceActionForLine10: 1193994 false) 
	#(53 1 #reduceActionForLine3: 1193987 false) 
	#(53 1 #reduceActionForLine6: 1193990 false) 
	#(53 1 #reduceActionForLine9: 1193993 false) 
	#(53 1 #reduceActionForLine12: 1193996 false) 
	#(53 1 #reduceActionForLine13: 1193997 false) 
	#(53 1 #reduceActionForLine14: 1193998 false) 
	#(53 1 #reduceActionForLine17: 1194001 false) 
	#(53 1 #reduceActionForLine18: 1194002 false) 
	#(53 1 #reduceActionForLine15: 1193999 false) 
	#(53 1 #reduceActionForLine16: 1194000 false) 
	#(53 1 #reduceActionForLine1: 1193985 false) 
	#(55 2 #reduceActionForPresentationAnnotation1: 1753089 false) 
	#(80 0 #reduceActionForSwitchToUrl1: 4382721 true) 
	#(47 2 #reduceActionFormap1: 1088514 false) 
	#(48 2 #reduceActionForLines1: 1121281 false) 
	#(67 2 #reduceActionForElement1: 3076097 false) 
	#(52 1 #liftFirstValue: 1183745 false) 
	#(51 2 #liftFirstValue: 1159169 false) 
	#(48 3 #reduceActionForLines2: 1121282 false) 
	#(50 2 #reduceActionFor_Eols_Line__2: 1141762 false) 
	#(67 3 #reduceActionForElement2: 3076098 false) 
	#(68 1 #reduceActionForExtendableComponent1: 3154945 false) 
	#(82 3 #reduceActionForElement2: 4507649 false) 
	#(77 3 #reduceActionForEvolution1: 3950593 false) 
	#(81 3 #reduceActionForElement2: 4425729 false) 
	#(62 3 #reduceActionForPipeline1: 2636801 false) 
	#(56 3 #reduceActionForPresentationStyle1: 1843201 false) 
	#(52 2 #liftFirstValue: 1183746 false) 
	#(75 0 #reduceActionFor______comma__Coords__occurrence___1: 3672065 false) 
	#(73 4 #reduceActionForAnnotation2: 3576834 false) 
	#(85 4 #reduceActionForAttitude1: 4784129 false) 
	#(85 4 #reduceActionForAttitude1: 4784130 false) 
	#(85 4 #reduceActionForAttitude1: 4784131 false) 
	#(85 4 #reduceActionForAttitude1: 4784132 false) 
	#(85 4 #reduceActionForAttitude1: 4784133 false) 
	#(85 4 #reduceActionForAttitude1: 4784134 false) 
	#(49 2 #reduceActionFor_Eols_Line_1: 1141761 false) 
	#(58 4 #reduceActionForAnchor1: 2190337 false) 
	#(71 0 #reduceActionForDecorator__decorator__1: 3411969 false) 
	#(76 4 #reduceActionForNote1: 3848193 false) 
	#(78 4 #reduceActionForMethod3: 4125699 false) 
	#(78 4 #reduceActionForMethod3: 4125697 false) 
	#(78 4 #reduceActionForMethod3: 4125698 false) 
	#(87 4 #reduceActionForTitle1: 5124097 false) 
	#(57 4 #reduceActionForLink3: 1923075 false) 
	#(57 4 #reduceActionForLink3: 1923074 false) 
	#(57 4 #reduceActionForLink3: 1923073 false) 
	#(57 4 #reduceActionForLink3: 1923076 false) 
	#(59 4 #reduceActionForCoords1: 2278401 false) 
	#(68 3 #reduceActionForExtendableComponent2: 3154946 false) 
	#(70 1 #reduceActionForDecorators1: 3397633 false) 
	#(77 5 #reduceActionForEvolution2: 3950594 false) 
	#(76 5 #reduceActionForNote2: 3848194 false) 
	#(75 2 #reduceActionFor______comma__Coords__occurrence___2: 3672066 false) 
	#(60 6 #reduceActionForEvolve1: 2393089 false) 
	#(71 2 #reduceActionForDecorator__decorator__2: 3411970 false) 
	#(57 6 #reduceActionForLink7: 1923079 false) 
	#(57 6 #reduceActionForLink7: 1923078 false) 
	#(57 6 #reduceActionForLink7: 1923077 false) 
	#(74 2 #reduceActionFor______comma__Coords__occurrence__1: 3672065 false) 
	#(59 6 #reduceActionForCoords2: 2278402 false) 
	#(79 7 #reduceActionForSubmap1: 4258817 false) 
	#(68 5 #reduceActionForExtendableComponent4: 3154948 false) 
	#(68 5 #reduceActionForExtendableComponent3: 3154947 false) 
	#(77 7 #reduceActionForEvolution3: 3950595 false) 
	#(84 0 #reduceActionForSwitchToName1: 4719617 false) 
	#(54 7 #reduceActionForPresentationYAxis1: 1619969 false) 
	#(73 8 #reduceActionForAnnotation1: 3576833 false) 
	#(60 8 #reduceActionForEvolve2: 2393090 false) 
	#(72 3 #reduceActionForDecorator1: 3438593 false) 
	#(72 3 #reduceActionForDecorator1: 3438594 false) 
	#(72 3 #reduceActionForDecorator1: 3438597 false) 
	#(72 3 #reduceActionForDecorator1: 3438596 false) 
	#(72 3 #reduceActionForDecorator1: 3438595 false) 
	#(62 8 #reduceActionForPipeline3: 2636803 false) 
	#(66 1 #reduceActionForInsidePipeline2: 3016706 false) 
	#(65 0 #reduceActionFor______comma__Coords__occurrence___1: 2983937 false) 
	#(66 1 #reduceActionForInsidePipeline1: 3016705 false) 
	#(83 8 #reduceActionForUrl1: 4594689 false) 
	#(68 7 #reduceActionForExtendableComponent5: 3154949 false) 
	#(77 9 #reduceActionForEvolution4: 3950596 false) 
	#(62 9 #reduceActionForPipeline2: 2636802 false) 
	#(62 9 #reduceActionForPipeline4: 2636804 false) 
	#(63 2 #reduceActionForInsidePipelines1: 2941953 false) 
	#(86 9 #reduceActionForManyCoords1: 4957185 false) 
	#(63 3 #reduceActionForInsidePipelines3: 2941955 false) 
	#(63 3 #reduceActionForInsidePipelines1: 2941954 false) 
	#(65 2 #reduceActionFor______comma__Coords__occurrence___2: 2983938 false) 
	#(69 6 #reduceActionForLabel1: 3298305 false) 
	#(63 4 #reduceActionForInsidePipelines3: 2941956 false) 
	#(64 2 #reduceActionFor_Eols_Line_1: 2983937 false)
	).
]

{ #category : #generated }
GtWardleyMapParser class >> scannerClass [
	^GtWardleyMapScanner
]

{ #category : #generated }
GtWardleyMapParser class >> startingStateFormap [
	^ 1
]

{ #category : #generated }
GtWardleyMapParser class >> symbolNames [
	^ #('"''<"' '"''<>"' '"''>"' '"("' '")"' '"+''"' '"+<"' '"+<>"' '"+>"' '","' '"->"' '"["' '"]"' '"{"' '"}"' '<titleLabel>' '<whitespace>' '<float>' '<nameWithoutNumber>' '<nodeName>' '<comment>' '<eol>' '<anchor>' '<annotation>' '<annotations>' '<build>' '<buy>' '<component>' '<ecosystem>' '<evolution>' '<evolve>' '<inertia>' '<label>' '<market>' '<note>' '<outsource>' '<pioneers>' '<pipeline>' '<settlers>' '<style>' '<submap>' '<title>' '<townplanners>' '<url>' '<yAxis>' 'B e g i n' 'map' 'Lines' '(Eols Line)' '(Eols Line)*' 'Eols' '<eol>+' 'Line' 'PresentationYAxis' 'PresentationAnnotation' 'PresentationStyle' 'Link' 'Anchor' 'Coords' 'Evolve' 'SwitchToNameWithoutNumber' 'Pipeline' 'InsidePipelines' '(Eols InsidePipeline)' '(Eols InsidePipeline)*' 'InsidePipeline' 'Element' 'ExtendableComponent' 'Label' 'Decorators' 'Decorator ''decorator''*' 'Decorator' 'Annotation' '("," ''comma'' Coords ''occurrence'')' '("," ''comma'' Coords ''occurrence'')*' 'Note' 'Evolution' 'Method' 'Submap' 'SwitchToUrl' 'Market' 'Ecosystem' 'Url' 'SwitchToName' 'Attitude' 'ManyCoords' 'Title' 'SwitchToDefault' 'SwitchToTitle' '<name>' 'E O F' 'error')
]

{ #category : #generated }
GtWardleyMapParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtWMFileNode #GtWMFileNode #OrderedCollection #OrderedCollection #OrderedCollection nil #SmaCCToken #OrderedCollection #GtWMPresentationYAxisNode #GtWMPresentationAnnotationNode #GtWMPresentationStyleNode #GtWMLinkNode #GtWMAnchorNode #GtWMCoordsNode #GtWMEvolveNode nil #GtWMPipelineNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtWMElementNode #OrderedCollection #GtWMLabelNode #OrderedCollection #OrderedCollection #GtWMDecoratorNode #GtWMAnnotationNode #OrderedCollection #OrderedCollection #GtWMNoteNode #GtWMEvolutionNode #GtWMMethodNode #GtWMSubmapNode nil #GtWMElementNode #GtWMElementNode #GtWMUrlNode nil #GtWMAttitudeNode #GtWMManyCoordsNode #GtWMTitleNode nil nil #SmaCCToken #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtWardleyMapParser class >> transitionTable [
^#(
#[1 0 6 0 22 0 10 0 23 0 9 0 24 0 13 0 25 0 14 0 26 0 14 0 27 0 10 0 28 0 10 0 29 0 10 0 30 0 18 0 31 0 10 0 34 0 10 0 35 0 14 0 36 0 17 0 37 0 10 0 38 0 21 0 39 0 10 0 40 0 25 0 41 0 14 0 42 0 29 0 43 0 10 0 44 0 10 0 45 0 33 0 47 0 37 0 48 0 41 0 51 0 45 0 53 0 49 0 54 0 53 0 55 0 57 0 56 0 61 0 57 0 65 0 58 0 69 0 60 0 73 0 61 0 77 0 62 0 81 0 67 0 85 0 73 0 89 0 76 0 93 0 77 0 97 0 78 0 101 0 79 0 105 0 81 0 109 0 82 0 113 0 83 0 117 0 84 0 121 0 85 0 125 0 87 0 129 0 88 0 133 0 89 0 137 0 90] 
#[0 0 141 0 18] 
#[1 0 6 0 12 0 145 0 59 0 149 0 88] 
#[1 0 7 0 12 0 157 0 59 0 161 0 86 0 149 0 88] 
#[1 0 7 0 12 0 165 0 59 0 169 0 86 0 149 0 88] 
#[0 0 173 0 44] 
#[1 0 7 0 12 0 177 0 59 0 181 0 86 0 149 0 88] 
#[0 0 0 0 91] 
#[1 0 6 0 22 0 185 0 51 0 129 0 88 0 22 0 91] 
#[1 0 10 0 23 0 9 0 24 0 13 0 25 0 14 0 26 0 14 0 27 0 10 0 28 0 10 0 29 0 10 0 30 0 18 0 31 0 10 0 34 0 10 0 35 0 14 0 36 0 17 0 37 0 10 0 38 0 21 0 39 0 10 0 40 0 25 0 41 0 14 0 42 0 29 0 43 0 10 0 44 0 10 0 45 0 189 0 53 0 49 0 54 0 53 0 55 0 57 0 56 0 61 0 57 0 65 0 58 0 69 0 60 0 73 0 61 0 77 0 62 0 81 0 67 0 85 0 73 0 89 0 76 0 93 0 77 0 97 0 78 0 101 0 79 0 105 0 81 0 109 0 82 0 113 0 83 0 117 0 84 0 121 0 85 0 125 0 87 0 133 0 89 0 137 0 90] 
#[1 0 26 0 22 0 193 0 50 0 26 0 91] 
#[0 0 30 0 22 0 91] 
#[0 0 34 0 22 0 91] 
#[0 0 38 0 22 0 91] 
#[0 0 42 0 22 0 91] 
#[0 0 46 0 22 0 91] 
#[0 0 50 0 22 0 91] 
#[0 0 197 0 31] 
#[0 0 54 0 22 0 91] 
#[0 0 58 0 22 0 91] 
#[0 0 62 0 22 0 91] 
#[0 0 66 0 22 0 91] 
#[0 0 70 0 22 0 91] 
#[0 0 74 0 22 0 91] 
#[0 0 78 0 22 0 91] 
#[0 0 82 0 22 0 91] 
#[0 0 86 0 22 0 91] 
#[0 0 90 0 22 0 91] 
#[1 0 201 0 23 0 205 0 28 0 209 0 29 0 213 0 30 0 217 0 34 0 221 0 35 0 225 0 38 0 229 0 40 0 233 0 44 0 237 0 45] 
#[0 0 94 0 22 0 91] 
#[0 0 98 0 22 0 91] 
#[0 0 245 0 22 0 52] 
#[1 0 249 0 26 0 253 0 27 1 1 0 36 1 5 0 42] 
#[1 0 10 0 6 0 10 0 7 0 10 0 8 0 10 0 9 0 10 0 11 1 9 0 84] 
#[1 0 11 0 12 1 17 0 59 0 149 0 88] 
#[0 0 102 0 22 0 91] 
#[0 1 21 0 12] 
#[0 1 25 0 18] 
#[0 1 29 0 18] 
#[0 1 33 0 18] 
#[0 1 37 0 18] 
#[0 1 41 0 18] 
#[1 0 106 0 4 1 45 0 80] 
#[0 1 49 0 18] 
#[0 1 53 0 18] 
#[0 0 110 0 91] 
#[1 0 26 0 22 1 57 0 50 0 26 0 91] 
#[1 0 15 0 22 1 61 0 49 1 65 0 51 0 129 0 88 0 114 0 91] 
#[1 0 6 0 19 1 69 0 88] 
#[0 1 73 0 90] 
#[1 0 118 0 15 0 118 0 22 1 77 0 68 1 81 0 90 0 118 0 91] 
#[1 1 85 0 68 1 81 0 90] 
#[0 1 89 0 90] 
#[1 1 93 0 68 1 81 0 90] 
#[1 1 97 0 88 0 6 0 90] 
#[0 1 101 0 90] 
#[0 1 105 0 90] 
#[0 1 109 0 90] 
#[0 1 113 0 90] 
#[0 0 122 0 15 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 90 0 91] 
#[1 0 126 0 15 1 117 0 22 0 126 0 23 0 126 0 24 0 126 0 25 0 126 0 26 0 126 0 27 0 126 0 28 0 126 0 29 0 126 0 30 0 126 0 31 0 126 0 34 0 126 0 35 0 126 0 36 0 126 0 37 0 126 0 38 0 126 0 39 0 126 0 40 0 126 0 41 0 126 0 42 0 126 0 43 0 126 0 44 0 126 0 45 0 126 0 90 0 126 0 91] 
#[1 0 6 0 16 1 121 0 88] 
#[1 0 6 0 16 1 125 0 88] 
#[1 0 6 0 16 1 129 0 88] 
#[1 0 6 0 16 1 133 0 88] 
#[1 1 137 0 6 1 141 0 7 1 145 0 8 1 149 0 9 1 153 0 11] 
#[1 0 6 0 12 1 157 0 59 0 149 0 88] 
#[0 1 161 0 90] 
#[0 1 165 0 18] 
#[0 1 169 0 10] 
#[0 1 173 0 18] 
#[0 1 177 0 18] 
#[0 1 181 0 18] 
#[0 1 185 0 18] 
#[0 1 189 0 4] 
#[0 1 193 0 18] 
#[0 1 197 0 18] 
#[1 0 19 0 22 1 61 0 49 1 65 0 51 0 129 0 88 0 130 0 91] 
#[0 0 134 0 22 0 91] 
#[1 0 10 0 23 0 9 0 24 0 13 0 25 0 14 0 26 0 14 0 27 0 10 0 28 0 10 0 29 0 10 0 30 0 18 0 31 0 10 0 34 0 10 0 35 0 14 0 36 0 17 0 37 0 10 0 38 0 21 0 39 0 10 0 40 0 25 0 41 0 14 0 42 0 29 0 43 0 10 0 44 0 10 0 45 1 201 0 53 0 49 0 54 0 53 0 55 0 57 0 56 0 61 0 57 0 65 0 58 0 69 0 60 0 73 0 61 0 77 0 62 0 81 0 67 0 85 0 73 0 89 0 76 0 93 0 77 0 97 0 78 0 101 0 79 0 105 0 81 0 109 0 82 0 113 0 83 0 117 0 84 0 121 0 85 0 125 0 87 0 133 0 89 0 137 0 90] 
#[0 1 205 0 19] 
#[1 0 6 0 12 1 209 0 59 0 149 0 88] 
#[0 0 138 0 15 0 22 0 91] 
#[1 0 6 0 12 0 142 0 15 0 142 0 22 1 213 0 59 0 149 0 88 0 142 0 91] 
#[0 0 146 0 22 0 91] 
#[1 1 217 0 11 0 150 0 22 0 150 0 91] 
#[0 0 154 0 22 0 91] 
#[0 1 221 0 90] 
#[1 0 6 0 12 0 23 0 22 1 225 0 88 0 158 0 91] 
#[0 0 162 0 22 0 91] 
#[1 0 106 0 12 1 229 0 80] 
#[0 1 233 0 11] 
#[0 0 166 0 15 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 90 0 91] 
#[0 1 237 0 16] 
#[0 1 241 0 16] 
#[0 1 245 0 16] 
#[0 1 249 0 16] 
#[0 1 253 0 90] 
#[0 2 1 0 90] 
#[0 2 5 0 90] 
#[0 2 9 0 90] 
#[0 2 13 0 90] 
#[1 0 170 0 10 0 170 0 13 2 17 0 75] 
#[0 0 174 0 22 0 91] 
#[1 2 21 0 10 2 25 0 13] 
#[0 2 29 0 18] 
#[0 0 178 0 22 0 91] 
#[0 0 182 0 22 0 91] 
#[0 0 186 0 22 0 91] 
#[0 0 190 0 22 0 91] 
#[0 2 33 0 44] 
#[0 0 194 0 22 0 91] 
#[0 0 198 0 22 0 91] 
#[0 0 202 0 22 0 91] 
#[0 2 37 0 18] 
#[0 0 206 0 22 0 91] 
#[1 0 210 0 4 0 210 0 15 0 210 0 22 0 210 0 32 0 210 0 33 2 41 0 70 2 45 0 71 0 210 0 91] 
#[0 2 49 0 90] 
#[1 0 6 0 12 0 214 0 22 2 53 0 59 0 149 0 88 0 214 0 91] 
#[1 2 57 0 12 2 61 0 22] 
#[0 2 65 0 12] 
#[0 2 69 0 90] 
#[0 0 218 0 22 0 91] 
#[0 0 222 0 22 0 91] 
#[0 0 226 0 22 0 91] 
#[0 0 230 0 22 0 91] 
#[1 2 73 0 1 2 77 0 2 2 81 0 3] 
#[0 0 234 0 22 0 91] 
#[0 0 238 0 22 0 91] 
#[0 0 242 0 22 0 91] 
#[0 0 246 0 22 0 91] 
#[1 2 85 0 10 0 10 0 13 2 89 0 74 2 93 0 84] 
#[0 2 97 0 18] 
#[0 0 250 0 4 0 10 0 13 0 15 0 18 0 22 0 32 0 33 0 90 0 91] 
#[0 2 101 0 10] 
#[1 0 6 0 5 2 105 0 88] 
#[1 0 210 0 4 0 210 0 15 0 210 0 22 0 210 0 33 2 109 0 70 2 45 0 71 0 210 0 91] 
#[1 0 254 0 15 0 254 0 22 2 113 0 32 2 117 0 33 2 121 0 69 0 254 0 91] 
#[1 2 125 0 4 1 2 0 15 1 2 0 22 1 2 0 32 1 2 0 33 2 129 0 72 1 2 0 91] 
#[1 2 133 0 11 1 6 0 22 1 6 0 91] 
#[0 1 10 0 22 0 91] 
#[0 2 137 0 18] 
#[0 2 141 0 14] 
#[0 2 145 0 44] 
#[0 2 149 0 11] 
#[0 2 153 0 90] 
#[0 2 157 0 90] 
#[0 2 161 0 90] 
#[1 0 6 0 12 2 165 0 59 0 149 0 88] 
#[0 1 14 0 10 0 13] 
#[0 2 169 0 13] 
#[0 2 173 0 13] 
#[0 2 177 0 18] 
#[0 2 181 0 5] 
#[1 1 18 0 15 1 18 0 22 2 117 0 33 2 185 0 69 1 18 0 91] 
#[1 0 210 0 4 0 210 0 15 0 210 0 22 0 210 0 33 2 189 0 70 2 45 0 71 0 210 0 91] 
#[0 2 193 0 12] 
#[1 0 210 0 4 0 210 0 15 0 210 0 22 2 197 0 70 2 45 0 71 0 210 0 91] 
#[1 2 201 0 26 2 205 0 27 2 209 0 29 2 213 0 34 2 217 0 36] 
#[0 1 22 0 4 0 15 0 22 0 32 0 33 0 91] 
#[0 2 221 0 90] 
#[0 2 225 0 10] 
#[0 2 229 0 22] 
#[1 0 6 0 13 2 233 0 88] 
#[0 2 237 0 90] 
#[0 1 26 0 22 0 91] 
#[0 1 30 0 22 0 91] 
#[0 1 34 0 22 0 91] 
#[0 1 38 0 10 0 13] 
#[0 2 241 0 90] 
#[0 1 42 0 4 0 10 0 13 0 15 0 18 0 22 0 32 0 33 0 90 0 91] 
#[0 2 245 0 10] 
#[0 1 46 0 22 0 91] 
#[1 0 210 0 4 0 210 0 15 0 210 0 22 2 249 0 70 2 45 0 71 0 210 0 91] 
#[1 1 50 0 15 1 50 0 22 2 117 0 33 2 253 0 69 1 50 0 91] 
#[0 3 1 0 18] 
#[0 1 54 0 15 0 22 0 91] 
#[0 3 5 0 5] 
#[0 3 9 0 5] 
#[0 3 13 0 5] 
#[0 3 17 0 5] 
#[0 3 21 0 5] 
#[1 3 25 0 11 1 58 0 22 1 58 0 91] 
#[0 3 29 0 18] 
#[1 3 33 0 15 0 6 0 22 1 62 0 28 0 18 0 31 3 37 0 51 3 41 0 60 0 73 0 61 3 45 0 63 3 49 0 66 3 53 0 67 3 57 0 84 0 129 0 88] 
#[0 3 61 0 13] 
#[0 1 66 0 22 0 91] 
#[0 1 70 0 22 0 91] 
#[0 3 65 0 18] 
#[0 1 74 0 15 0 22 0 91] 
#[1 0 210 0 4 0 210 0 15 0 210 0 22 3 69 0 70 2 45 0 71 0 210 0 91] 
#[0 3 73 0 10] 
#[0 1 78 0 4 0 15 0 22 0 32 0 33 0 91] 
#[0 1 82 0 4 0 15 0 22 0 32 0 33 0 91] 
#[0 1 86 0 4 0 15 0 22 0 32 0 33 0 91] 
#[0 1 90 0 4 0 15 0 22 0 32 0 33 0 91] 
#[0 1 94 0 4 0 15 0 22 0 32 0 33 0 91] 
#[0 3 77 0 90] 
#[0 3 81 0 13] 
#[0 1 98 0 22 0 91] 
#[1 0 10 0 28 0 18 0 31 3 41 0 60 0 73 0 61 3 85 0 66 3 53 0 67 3 57 0 84] 
#[0 1 102 0 15 0 22] 
#[0 3 89 0 15] 
#[1 1 106 0 15 1 106 0 22 3 93 0 65] 
#[0 1 110 0 15 0 22] 
#[0 0 205 0 28] 
#[0 1 114 0 22 0 91] 
#[0 3 97 0 13] 
#[0 1 118 0 15 0 22 0 91] 
#[0 3 101 0 18] 
#[0 1 122 0 22 0 91] 
#[0 1 126 0 22 0 91] 
#[1 1 106 0 15 1 106 0 22 3 105 0 65] 
#[0 1 130 0 22 0 91] 
#[1 1 134 0 15 0 6 0 22 3 109 0 51 3 113 0 64 0 129 0 88] 
#[0 1 138 0 18] 
#[0 3 117 0 13] 
#[1 1 142 0 15 0 6 0 22 3 121 0 51 3 113 0 64 0 129 0 88] 
#[1 1 146 0 15 0 10 0 28 0 18 0 31 3 41 0 60 0 73 0 61 3 125 0 66 3 53 0 67 3 57 0 84] 
#[0 1 150 0 15 0 22] 
#[0 1 154 0 4 0 15 0 22 0 91] 
#[1 1 158 0 15 0 10 0 28 0 18 0 31 3 41 0 60 0 73 0 61 3 125 0 66 3 53 0 67 3 57 0 84] 
#[0 1 162 0 15 0 22]
	).
]

{ #category : #private }
GtWardleyMapParser >> actionsForCurrentToken [
	| actions position nameToken previousState newPosition oldToken |
	(currentToken value notEmpty
		and: [ (currentToken value first isLetter or: [ '(+' includes:  currentToken value first ]) and: [ (currentToken ids includes: scanner nameId) not ] ])
		ifTrue:
			[ position := scanner position.
			nameToken := scanner scanNameAt: currentToken startPosition.
			nameToken value = currentToken value
				ifFalse:
					[ oldToken := currentToken.
					newPosition := scanner position.
					scanner position: position.
					previousState := currentState.
					currentState := self duplicateState.
					self position: newPosition.
					currentToken := nameToken.
					self parseCurrentToken.
					self restoreState: previousState.
					currentToken := oldToken.
					^ super actionsForCurrentToken ].
			currentToken := currentToken copy ids: (currentToken ids copyWith: scanner nameId) ].
	actions := super actionsForCurrentToken.
	(actions isEmpty and: [ currentToken ids includes: scanner floatId ])
		ifTrue:
			[ currentToken := scanner scanNameAt: currentToken startPosition.
			self position: scanner position.
			actions := super actionsForCurrentToken ].
	^ actions
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForAnchor1: nodes [
	| result |
	result := GtWMAnchorNode new.
	result anchorToken: (nodes at: 2).
	result name: (nodes at: 3).
	result position: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForAnnotation1: nodes [
	| result |
	result := GtWMAnnotationNode new.
	result annotationToken: (nodes at: 1).
	result number: (nodes at: 2).
	result left: (nodes at: 3).
	result addNode: (nodes at: 4) to: result occurrences.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addNodes: ((nodes at: 5) at: 2) to: result occurrences.
	result right: (nodes at: 7).
	result text: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForAnnotation2: nodes [
	| result |
	result := GtWMAnnotationNode new.
	result annotationToken: (nodes at: 1).
	result number: (nodes at: 2).
	result addNode: (nodes at: 3) to: result occurrences.
	result text: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForAttitude1: nodes [
	| result |
	result := GtWMAttitudeNode new.
	result attitude: (nodes at: 1).
	result coords: (nodes at: 2).
	result width: (nodes at: 3).
	result height: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForCoords1: nodes [
	| result |
	result := GtWMCoordsNode new.
	result left: (nodes at: 2).
	result maturity: (nodes at: 3).
	result right: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForCoords2: nodes [
	| result |
	result := GtWMCoordsNode new.
	result left: (nodes at: 2).
	result visibility: (nodes at: 3).
	result comma: (nodes at: 4).
	result maturity: (nodes at: 5).
	result right: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForDecorator1: nodes [
	| result |
	result := GtWMDecoratorNode new.
	result left: (nodes at: 1).
	result type: (nodes at: 2).
	result right: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForDecorator__decorator__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForDecorator__decorator__2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForDecorators1: nodes [
	| result |
	result := nodes at: 1.
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForElement1: nodes [
	| result |
	result := GtWMElementNode new.
	result typeToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForElement2: nodes [
	| result |
	result := GtWMElementNode new.
	result typeToken: (nodes at: 2).
	result name: ((nodes at: 3) at: 1).
	result coords: ((nodes at: 3) at: 2).
	result addNodes: ((nodes at: 3) at: 3) to: result decorators.
	result label: ((nodes at: 3) at: 4).
	result inertiaToken: ((nodes at: 3) at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForEvolution1: nodes [
	| result |
	result := GtWMEvolutionNode new.
	result evolutionToken: (nodes at: 2).
	result line1: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForEvolution2: nodes [
	| result |
	result := GtWMEvolutionNode new.
	result evolutionToken: (nodes at: 2).
	result line1: (nodes at: 3).
	result addToken: (nodes at: 4) to: result arrows.
	result line2: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForEvolution3: nodes [
	| result |
	result := GtWMEvolutionNode new.
	result evolutionToken: (nodes at: 2).
	result line1: (nodes at: 3).
	result addToken: (nodes at: 4) to: result arrows.
	result line2: (nodes at: 5).
	result addToken: (nodes at: 6) to: result arrows.
	result line3: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForEvolution4: nodes [
	| result |
	result := GtWMEvolutionNode new.
	result evolutionToken: (nodes at: 2).
	result line1: (nodes at: 3).
	result addToken: (nodes at: 4) to: result arrows.
	result line2: (nodes at: 5).
	result addToken: (nodes at: 6) to: result arrows.
	result line3: (nodes at: 7).
	result addToken: (nodes at: 8) to: result arrows.
	result line4: (nodes at: 9).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForEvolve1: nodes [
	| result |
	result := GtWMEvolveNode new.
	result evolveToken: (nodes at: 2).
	result name: (nodes at: 4).
	result maturity: (nodes at: 5).
	result addNodes: (nodes at: 6) to: result decorators.
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForEvolve2: nodes [
	| result |
	result := GtWMEvolveNode new.
	result evolveToken: (nodes at: 2).
	result name: (nodes at: 4).
	result maturity: (nodes at: 5).
	result addNodes: (nodes at: 6) to: result decorators.
	result label: (nodes at: 7).
	result addNodes: (nodes at: 8) to: result decorators.
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForExtendableComponent1: nodes [
	| result |
	result := Array new: 5.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForExtendableComponent2: nodes [
	| result |
	result := Array new: 5.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	self addAll: (nodes at: 3) to: (result at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForExtendableComponent3: nodes [
	| result |
	result := Array new: 5.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	self addAll: (nodes at: 3) to: (result at: 3).
	result at: 4 put: (nodes at: 4).
	self addAll: (nodes at: 5) to: (result at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForExtendableComponent4: nodes [
	| result |
	result := Array new: 5.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	self addAll: (nodes at: 3) to: (result at: 3).
	result at: 5 put: (nodes at: 4).
	self addAll: (nodes at: 5) to: (result at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForExtendableComponent5: nodes [
	| result |
	result := Array new: 5.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	self addAll: (nodes at: 3) to: (result at: 3).
	result at: 5 put: (nodes at: 4).
	self addAll: (nodes at: 5) to: (result at: 3).
	result at: 4 put: (nodes at: 6).
	self addAll: (nodes at: 7) to: (result at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForInsidePipeline1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForInsidePipeline2: nodes [
	| result |
	result := Array new: 2.
	result at: 2 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForInsidePipelines1: nodes [
	| result |
	result := nodes at: 2.
	self addFirst: ((nodes at: 1) at: 1) to: (result at: 1).
	self addFirst: ((nodes at: 1) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForInsidePipelines3: nodes [
	| result |
	result := nodes at: 3.
	self addFirst: ((nodes at: 2) at: 1) to: (result at: 1).
	self addFirst: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLabel1: nodes [
	| result |
	result := GtWMLabelNode new.
	result labelToken: (nodes at: 1).
	result left: (nodes at: 2).
	result x: (nodes at: 3).
	result comma: (nodes at: 4).
	result y: (nodes at: 5).
	result right: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine10: nodes [
	| result |
	result := Array new: 18.
	result at: 10 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine11: nodes [
	| result |
	result := Array new: 18.
	result at: 11 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine12: nodes [
	| result |
	result := Array new: 18.
	result at: 12 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine13: nodes [
	| result |
	result := Array new: 18.
	result at: 13 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine14: nodes [
	| result |
	result := Array new: 18.
	result at: 14 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine15: nodes [
	| result |
	result := Array new: 18.
	result at: 15 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine16: nodes [
	| result |
	result := Array new: 18.
	result at: 16 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine17: nodes [
	| result |
	result := Array new: 18.
	result at: 17 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine18: nodes [
	| result |
	result := Array new: 18.
	result at: 18 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine1: nodes [
	| result |
	result := Array new: 18.
	result at: 1 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine2: nodes [
	| result |
	result := Array new: 18.
	result at: 2 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine3: nodes [
	| result |
	result := Array new: 18.
	result at: 3 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine4: nodes [
	| result |
	result := Array new: 18.
	result at: 4 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine5: nodes [
	| result |
	result := Array new: 18.
	result at: 5 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine6: nodes [
	| result |
	result := Array new: 18.
	result at: 6 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine7: nodes [
	| result |
	result := Array new: 18.
	result at: 7 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine8: nodes [
	| result |
	result := Array new: 18.
	result at: 8 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLine9: nodes [
	| result |
	result := Array new: 18.
	result at: 9 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLines1: nodes [
	| result |
	result := nodes at: 2.
	self addFirst: ((nodes at: 1) at: 1) to: (result at: 1).
	self addFirst: ((nodes at: 1) at: 2) to: (result at: 2).
	self addFirst: ((nodes at: 1) at: 3) to: (result at: 3).
	self addFirst: ((nodes at: 1) at: 4) to: (result at: 4).
	self addFirst: ((nodes at: 1) at: 5) to: (result at: 5).
	self addFirst: ((nodes at: 1) at: 6) to: (result at: 6).
	self addFirst: ((nodes at: 1) at: 7) to: (result at: 7).
	self addFirst: ((nodes at: 1) at: 8) to: (result at: 8).
	self addFirst: ((nodes at: 1) at: 9) to: (result at: 9).
	self addFirst: ((nodes at: 1) at: 10) to: (result at: 10).
	self addFirst: ((nodes at: 1) at: 11) to: (result at: 11).
	self addFirst: ((nodes at: 1) at: 12) to: (result at: 12).
	self addFirst: ((nodes at: 1) at: 13) to: (result at: 13).
	self addFirst: ((nodes at: 1) at: 14) to: (result at: 14).
	self addFirst: ((nodes at: 1) at: 15) to: (result at: 15).
	self addFirst: ((nodes at: 1) at: 16) to: (result at: 16).
	self addFirst: ((nodes at: 1) at: 17) to: (result at: 17).
	self addFirst: ((nodes at: 1) at: 18) to: (result at: 18).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLines2: nodes [
	| result |
	result := nodes at: 3.
	self addFirst: ((nodes at: 2) at: 1) to: (result at: 1).
	self addFirst: ((nodes at: 2) at: 2) to: (result at: 2).
	self addFirst: ((nodes at: 2) at: 3) to: (result at: 3).
	self addFirst: ((nodes at: 2) at: 4) to: (result at: 4).
	self addFirst: ((nodes at: 2) at: 5) to: (result at: 5).
	self addFirst: ((nodes at: 2) at: 6) to: (result at: 6).
	self addFirst: ((nodes at: 2) at: 7) to: (result at: 7).
	self addFirst: ((nodes at: 2) at: 8) to: (result at: 8).
	self addFirst: ((nodes at: 2) at: 9) to: (result at: 9).
	self addFirst: ((nodes at: 2) at: 10) to: (result at: 10).
	self addFirst: ((nodes at: 2) at: 11) to: (result at: 11).
	self addFirst: ((nodes at: 2) at: 12) to: (result at: 12).
	self addFirst: ((nodes at: 2) at: 13) to: (result at: 13).
	self addFirst: ((nodes at: 2) at: 14) to: (result at: 14).
	self addFirst: ((nodes at: 2) at: 15) to: (result at: 15).
	self addFirst: ((nodes at: 2) at: 16) to: (result at: 16).
	self addFirst: ((nodes at: 2) at: 17) to: (result at: 17).
	self addFirst: ((nodes at: 2) at: 18) to: (result at: 18).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLink3: nodes [
	| result |
	result := GtWMLinkNode new.
	result start: (nodes at: 1).
	result arrow: (nodes at: 3).
	result end: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForLink7: nodes [
	| result |
	result := GtWMFlowLinkNode new.
	result start: (nodes at: 1).
	result flowArrow: (nodes at: 3).
	result flowValue: (nodes at: 4).
	result arrow: (nodes at: 5).
	result end: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForManyCoords1: nodes [
	| result |
	result := GtWMManyCoordsNode new.
	result left: (nodes at: 1).
	result visibility: (nodes at: 2).
	result addToken: (nodes at: 3) to: result commas.
	result maturity: (nodes at: 4).
	result addToken: (nodes at: 5) to: result commas.
	result visibility2: (nodes at: 6).
	result addToken: (nodes at: 7) to: result commas.
	result maturity2: (nodes at: 8).
	result right: (nodes at: 9).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForMethod3: nodes [
	| result |
	result := GtWMMethodNode new.
	result keyword: (nodes at: 2).
	result name: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForNote1: nodes [
	| result |
	result := GtWMNoteNode new.
	result noteToken: (nodes at: 2).
	result label: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForNote2: nodes [
	| result |
	result := GtWMNoteNode new.
	result noteToken: (nodes at: 2).
	result label: (nodes at: 4).
	result position: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForPipeline1: nodes [
	| result |
	result := GtWMPipelineNode new.
	result pipelineToken: (nodes at: 2).
	result name: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForPipeline2: nodes [
	| result |
	result := GtWMPipelineNode new.
	result pipelineToken: (nodes at: 2).
	result name: (nodes at: 3).
	result left: (nodes at: 5).
	result maturity1: (nodes at: 6).
	result comma: (nodes at: 7).
	result maturity2: (nodes at: 8).
	result right: (nodes at: 9).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForPipeline3: nodes [
	| result |
	result := GtWMPipelineNode new.
	result pipelineToken: (nodes at: 2).
	result name: (nodes at: 3).
	result left: (nodes at: 6).
	result right: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForPipeline4: nodes [
	| result |
	result := GtWMPipelineNode new.
	result pipelineToken: (nodes at: 2).
	result name: (nodes at: 3).
	result left: (nodes at: 6).
	result addNodes: ((nodes at: 8) at: 1) to: result elements.
	result addNodes: ((nodes at: 8) at: 2) to: result evolves.
	result right: (nodes at: 9).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForPresentationAnnotation1: nodes [
	| result |
	result := GtWMPresentationAnnotationNode new.
	result annotationsToken: (nodes at: 1).
	result annotations: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForPresentationStyle1: nodes [
	| result |
	result := GtWMPresentationStyleNode new.
	result styleToken: (nodes at: 2).
	result style: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForPresentationYAxis1: nodes [
	| result |
	result := GtWMPresentationYAxisNode new.
	result yAxisToken: (nodes at: 2).
	result label: (nodes at: 3).
	result addToken: (nodes at: 4) to: result arrows.
	result min: (nodes at: 5).
	result addToken: (nodes at: 6) to: result arrows.
	result max: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForSubmap1: nodes [
	| result |
	result := GtWMSubmapNode new.
	result submapToken: (nodes at: 1).
	result urlToken: (nodes at: 2).
	result left: (nodes at: 4).
	result url: (nodes at: 5).
	result right: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForSwitchToDefault1: nodes [
	self scope: #default.
	^ nil
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForSwitchToName1: nodes [
	self scope: #name.
	^ nil
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForSwitchToNameWithoutNumber1: nodes [
	self scope: #nameWithoutNumber.
	^ nil
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForSwitchToTitle1: nodes [
	self scope: #title.
	^ nil
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForSwitchToUrl1: nodes [
	self scope: #url.
	^ nil
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForTitle1: nodes [
	| result |
	result := GtWMTitleNode new.
	result titleToken: (nodes at: 2).
	result name: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionForUrl1: nodes [
	| result |
	result := GtWMUrlNode new.
	result urlToken: (nodes at: 2).
	result name: (nodes at: 3).
	result left: (nodes at: 5).
	result url: (nodes at: 6).
	result right: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionFor_Eols_Line_1: nodes [
	| result |
	result := nodes at: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionFor_Eols_Line__1: nodes [
	| result |
	result := Array new: 18.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 7 put: (OrderedCollection new: 2).
	result at: 8 put: (OrderedCollection new: 2).
	result at: 9 put: (OrderedCollection new: 2).
	result at: 10 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 14 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 16 put: (OrderedCollection new: 2).
	result at: 17 put: (OrderedCollection new: 2).
	result at: 18 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionFor_Eols_Line__2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	self add: ((nodes at: 2) at: 3) to: (result at: 3).
	self add: ((nodes at: 2) at: 4) to: (result at: 4).
	self add: ((nodes at: 2) at: 5) to: (result at: 5).
	self add: ((nodes at: 2) at: 6) to: (result at: 6).
	self add: ((nodes at: 2) at: 7) to: (result at: 7).
	self add: ((nodes at: 2) at: 8) to: (result at: 8).
	self add: ((nodes at: 2) at: 9) to: (result at: 9).
	self add: ((nodes at: 2) at: 10) to: (result at: 10).
	self add: ((nodes at: 2) at: 11) to: (result at: 11).
	self add: ((nodes at: 2) at: 12) to: (result at: 12).
	self add: ((nodes at: 2) at: 13) to: (result at: 13).
	self add: ((nodes at: 2) at: 14) to: (result at: 14).
	self add: ((nodes at: 2) at: 15) to: (result at: 15).
	self add: ((nodes at: 2) at: 16) to: (result at: 16).
	self add: ((nodes at: 2) at: 17) to: (result at: 17).
	self add: ((nodes at: 2) at: 18) to: (result at: 18).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionFor______comma__Coords__occurrence__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionFor______comma__Coords__occurrence___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionFor______comma__Coords__occurrence___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtWardleyMapParser >> reduceActionFormap1: nodes [
	| result |
	result := GtWMFileNode new.
	result addNodes: ((nodes at: 1) at: 1) to: result titles.
	result addNodes: ((nodes at: 1) at: 2) to: result anchors.
	result addNodes: ((nodes at: 1) at: 3) to: result elements.
	result addNodes: ((nodes at: 1) at: 4) to: result evolves.
	result addNodes: ((nodes at: 1) at: 5) to: result links.
	result addNodes: ((nodes at: 1) at: 6) to: result annotations.
	result addNodes: ((nodes at: 1) at: 7) to: result presentationAnnotations.
	result addNodes: ((nodes at: 1) at: 8) to: result styles.
	result addNodes: ((nodes at: 1) at: 9) to: result notes.
	result addNodes: ((nodes at: 1) at: 10) to: result pipelines.
	result addNodes: ((nodes at: 1) at: 11) to: result yAxises.
	result addNodes: ((nodes at: 1) at: 12) to: result evolutions.
	result addNodes: ((nodes at: 1) at: 13) to: result methods.
	result addNodes: ((nodes at: 1) at: 14) to: result submaps.
	result addNodes: ((nodes at: 1) at: 15) to: result urls.
	result addNodes: ((nodes at: 1) at: 16) to: result attitudes.
	result addNodes: ((nodes at: 1) at: 17) to: result markets.
	result addNodes: ((nodes at: 1) at: 18) to: result ecosystems.
	^ result
]

{ #category : #testing }
GtWardleyMapParser >> tryAllTokens [
	^ true
]
