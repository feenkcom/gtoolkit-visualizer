Class {
	#name : #GtWardleyMapParserExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'examples - parser' }
GtWardleyMapParserExamples >> parseScriptWithComment [
	<gtExample>
	<return: #GtWMFileNode>
	| aResult |
	aResult := GtWardleyMapParser parse: self scriptWithComment.

	self assert: aResult styles size equals: 1.
	self assert: aResult styles first style source equals: 'wardley'.

	self assert: aResult titles size equals: 1.
	self
		assert: aResult titles first name source
		equals: 'map with pipeline and note'.

	self assert: aResult notes size equals: 1.
	self assert: aResult notes first label source equals: '(+opportunity)'.
	self assert: aResult notes first position visibility source equals: '0.82'.
	self assert: aResult notes first position evolution source equals: '0.13'.

	self assert: aResult elements size equals: 4.
	self assert: aResult elements first name source equals: 'node b'.
	self assert: aResult elements first coords visibility source equals: '0.85'.
	self assert: aResult elements first coords evolution source equals: '0.21'.
	self assert: aResult elements first label x source equals: '-76'.
	self assert: aResult elements first label y source equals: '-2'.

	self assert: aResult pipelines size equals: 1.
	self assert: aResult pipelines first name source equals: 'node a'.
	self assert: aResult pipelines first evolution1 source equals: '0.2'.
	self assert: aResult pipelines first evolution2 source equals: '0.82'.

	self assert: aResult links size equals: 2.
	self assert: aResult links first start source equals: 'node d'.
	self assert: aResult links first arrow source equals: '+<>'.
	self assert: aResult links first end source equals: 'node a'.

	^ aResult
]

{ #category : #'examples - parser' }
GtWardleyMapParserExamples >> parseScriptWithEvolution [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'evolution genesis / concept -> custom / emerging -> product / converging -> commodity/ accepted'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult evolutions size equals: 1.
	self assert: aResult evolutions first line1 source equals: 'genesis / concept'.
	self assert: aResult evolutions first line2 source equals: 'custom / emerging'.
	self
		assert: aResult evolutions first line3 source
		equals: 'product / converging'.
	self
		assert: aResult evolutions first line4 source
		equals: 'commodity/ accepted'.

	self assert: aResult links size equals: 0.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithEvolve1 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'evolve Node G 0.8 label [-5, 20]'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult evolves size equals: 1.
	self assert: aResult evolves first name source equals: 'Node G'.
	self assert: aResult evolves first evolution source equals: '0.8'.
	self assert: aResult evolves first arrow equals: nil.
	self assert: aResult evolves first evolvedName equals: nil.
	self assert: aResult evolves first label x source equals: '-5'.
	self assert: aResult evolves first label y source equals: '20'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithEvolve2 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'evolve Node G -> something g 0.8 label [-5, 20]'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult evolves size equals: 1.
	self assert: aResult evolves first name source equals: 'Node G'.
	self assert: aResult evolves first evolution source equals: '0.8'.
	self assert: aResult evolves first arrow source equals: '->'.
	self assert: aResult evolves first evolvedName source equals: 'something g'.
	self assert: aResult evolves first label x source equals: '-5'.
	self assert: aResult evolves first label y source equals: '20'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithEvolve3 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'evolve Node G -> something g 0.8 label [-5, 20] // extra line comment'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult evolves size equals: 1.
	self assert: aResult evolves first name source equals: 'Node G'.
	self assert: aResult evolves first evolution source equals: '0.8'.
	self assert: aResult evolves first arrow source equals: '->'.
	self assert: aResult evolves first evolvedName source equals: 'something g'.
	self assert: aResult evolves first label x source equals: '-5'.
	self assert: aResult evolves first label y source equals: '20'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithEvolve4 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'evolve Node-G -> something-g 0.8 label [-5, 20] // extra line comment'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult evolves size equals: 1.
	self assert: aResult evolves first name source equals: 'Node-G'.
	self assert: aResult evolves first evolution source equals: '0.8'.
	self assert: aResult evolves first arrow source equals: '->'.
	self assert: aResult evolves first evolvedName source equals: 'something-g'.
	self assert: aResult evolves first label x source equals: '-5'.
	self assert: aResult evolves first label y source equals: '20'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithEvolve5 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'evolve Node3 -> something3 0.8 label [-5, 20] // extra line comment'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult evolves size equals: 1.
	self assert: aResult evolves first name source equals: 'Node3'.
	self assert: aResult evolves first evolution source equals: '0.8'.
	self assert: aResult evolves first arrow source equals: '->'.
	self assert: aResult evolves first evolvedName source equals: 'something3'.
	self assert: aResult evolves first label x source equals: '-5'.
	self assert: aResult evolves first label y source equals: '20'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithEvolve6 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'evolve Node -5 -> something -1 0.8 label [-5, 20] // extra line comment'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult evolves size equals: 1.
	self assert: aResult evolves first name source equals: 'Node -5'.
	self assert: aResult evolves first evolution source equals: '0.8'.
	self assert: aResult evolves first arrow source equals: '->'.
	self assert: aResult evolves first evolvedName source equals: 'something -1'.
	self assert: aResult evolves first label x source equals: '-5'.
	self assert: aResult evolves first label y source equals: '20'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink1 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'Node A->Node B'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: 'Node A'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: 'Node B'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink10 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'A -> B'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: 'A'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: 'B'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink11 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'A -> B ; c'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: 'A'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: 'B'.
	self assert: aResult links first comment source equals: 'c'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink12 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := '1 -> 2 ; 3'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: '1'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: '2'.
	self assert: aResult links first comment source equals: '3'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink13 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := '"Best" (legacy)->"common library"'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: '"Best" (legacy)'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: '"common library"'.
	self assert: aResult links first comment equals: nil.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink14 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := '"Best" (legacy) ->C# / .Net'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: '"Best" (legacy)'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: 'C# / .Net'.
	self assert: aResult links first comment equals: nil.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink15 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := '/something ->/slash / another slash'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: '/something'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: '/slash / another slash'.
	self assert: aResult links first comment equals: nil.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink16 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := '/something ->/slash / another slash // commented line'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: '/something'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: '/slash / another slash'.
	self assert: aResult links first comment equals: nil.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink17 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := '/something ->/slash / another slash ; link I/O label // commented line'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: '/something'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: '/slash / another slash'.
	self assert: aResult links first comment source equals: 'link I/O label'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink2 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'Node A -> Node B '.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: 'Node A'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: 'Node B'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink3 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'Node A -> Node B // the rest of the line is comment'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: 'Node A'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: 'Node B'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink4 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'Node A -> Node B ; link explanation '.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: 'Node A'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: 'Node B'.
	self assert: aResult links first comment source equals: 'link explanation'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink5 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'Node A -> Node B ; link explanation // the rest of the line is comment'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: 'Node A'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: 'Node B'.
	self assert: aResult links first comment source equals: 'link explanation'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink6 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'Node A->Node B;link explanation'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: 'Node A'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: 'Node B'.
	self assert: aResult links first comment source equals: 'link explanation'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink7 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'Node A -> 1'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: 'Node A'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: '1'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink8 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'Node A -> 1 // the rest of the line is comment'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: 'Node A'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: '1'.

	^ aResult
]

{ #category : #'examples - link' }
GtWardleyMapParserExamples >> parseScriptWithLink9 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'Node A -> 1 ; link comment to node 1 // the rest of the line is comment'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: 'Node A'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: '1'.
	self
		assert: aResult links first comment source
		equals: 'link comment to node 1'.

	^ aResult
]

{ #category : #'examples - parser' }
GtWardleyMapParserExamples >> parseScriptWithNewSyntaxForPipeline [
	<gtExample>
	<return: #GtWMFileNode>
	| aResult |
	aResult := GtWardleyMapParser parse: self scriptWithNewSyntaxForPipeline.

	self assert: aResult styles size equals: 1.
	self assert: aResult styles first style source equals: 'wardley'.

	self assert: aResult titles size equals: 1.
	self assert: aResult titles first name source equals: 'Something'.

	self assert: aResult evolutions size equals: 1.
	self assert: aResult evolutions first line1 source equals: 'genesis / concept'.
	self assert: aResult evolutions first line2 source equals: 'custom / emerging'.
	self
		assert: aResult evolutions first line3 source
		equals: 'product / converging'.
	self
		assert: aResult evolutions first line4 source
		equals: 'commodity / accepted'.
	self
		assert: aResult evolutions first sections
		equals: {'genesis / concept'.
				'custom / emerging'.
				'product / converging'.
				'commodity / accepted'}.

	self assert: aResult notes size equals: 1.
	self assert: aResult notes first label source equals: 'Node C pipeline comment'.
	self assert: aResult notes first position visibility source equals: '0.45'.
	self assert: aResult notes first position evolution source equals: '0.45'.

	self assert: aResult elements size equals: 4.
	self assert: aResult elements first name source equals: 'Node A'.
	self assert: aResult elements first coords visibility source equals: '0.95'.
	self assert: aResult elements first coords evolution source equals: '0.66'.

	self assert: aResult elements second name source equals: 'Node B'.
	self assert: aResult elements second coords visibility source equals: '0.84'.
	self assert: aResult elements second coords evolution source equals: '0.57'.
	self assert: aResult elements second label x source equals: '-91'.
	self assert: aResult elements second label y source equals: '-5'.

	self assert: aResult pipelines size equals: 3.
	self assert: aResult pipelines first name source equals: 'Node B'.

	self assert: aResult pipelines second name source equals: 'Node C'.
	self assert: aResult pipelines second elements size equals: 2.
	self
		assert: aResult pipelines second elements first name source
		equals: 'Node D'.
	self
		assert: aResult pipelines second elements first coords evolution source
		equals: '0.17'.
	self
		assert: aResult pipelines second elements first coords visibility
		equals: nil.
	self
		assert: aResult pipelines second elements first label x source
		equals: '-63'.
	self
		assert: aResult pipelines second elements first label y source
		equals: '14'.

	self
		assert: aResult pipelines second elements second name source
		equals: 'Node E'.
	self
		assert: aResult pipelines second elements second coords evolution source
		equals: '0.80'.
	self
		assert: aResult pipelines second elements second coords visibility
		equals: nil.
	self
		assert: aResult pipelines second elements second label x source
		equals: '20'.
	self
		assert: aResult pipelines second elements second label y source
		equals: '18'.

	self assert: aResult pipelines third name source equals: 'Node F'.
	self assert: aResult pipelines third elements size equals: 2.
	self assert: aResult pipelines third evolves size equals: 1.
	self assert: aResult pipelines third evolves first name source equals: 'Node G'.
	self
		assert: aResult pipelines third evolves first evolvedName source
		equals: 'something g'.
	self
		assert: aResult pipelines third evolves first evolution source
		equals: '0.8'.
	self assert: aResult pipelines third evolves first label x source equals: '-5'.
	self assert: aResult pipelines third evolves first label y source equals: '20'.

	self assert: aResult evolves size equals: 2.
	self assert: aResult evolves first name source equals: 'Node B'.
	self assert: aResult evolves first evolution source equals: '0.73'.
	self assert: aResult evolves first label x source equals: '-5'.
	self assert: aResult evolves first label y source equals: '21'.

	self assert: aResult evolves second name source equals: 'Node C'.
	self assert: aResult evolves second evolvedName source equals: 'something c'.
	self assert: aResult evolves second evolution source equals: '0.9'.
	self assert: aResult evolves second label x source equals: '-5'.
	self assert: aResult evolves second label y source equals: '21'.

	self assert: aResult links size equals: 3.
	self assert: aResult links first start source equals: 'Node A'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: 'Node B'.
	self assert: aResult links first comment source equals: 'comment on A-B edge'.

	self assert: aResult links second start source equals: 'Node B'.
	self assert: aResult links second arrow source equals: '->'.
	self assert: aResult links second end source equals: 'Node C'.
	self assert: aResult links second comment equals: nil.

	self assert: aResult links third start source equals: 'Node C'.
	self assert: aResult links third arrow source equals: '->'.
	self assert: aResult links third end source equals: 'Node F'.
	self assert: aResult links third comment source equals: 'comment on C-F edge'.

	^ aResult
]

{ #category : #'examples - parser' }
GtWardleyMapParserExamples >> parseScriptWithNote [
	<gtExample>
	<return: #GtWMFileNode>
	| aResult |
	aResult := GtWardleyMapParser parse: self scriptWithNote.

	self assert: aResult styles size equals: 1.
	self assert: aResult styles first style source equals: 'wardley'.

	self assert: aResult titles size equals: 1.
	self
		assert: aResult titles first name source
		equals: 'map with pipeline and note'.

	self assert: aResult notes size equals: 1.
	self assert: aResult notes first label source equals: '(+opportunity)'.
	self assert: aResult notes first position visibility source equals: '0.82'.
	self assert: aResult notes first position evolution source equals: '0.13'.

	self assert: aResult elements size equals: 4.
	self assert: aResult elements first name source equals: 'node b'.
	self assert: aResult elements first coords visibility source equals: '0.85'.
	self assert: aResult elements first coords evolution source equals: '0.21'.

	self assert: aResult pipelines size equals: 1.
	self assert: aResult pipelines first name source equals: 'node a'.
	self assert: aResult pipelines first evolution1 source equals: '0.2'.
	self assert: aResult pipelines first evolution2 source equals: '0.82'.

	self assert: aResult links size equals: 2.
	self assert: aResult links first start source equals: 'node d'.
	self assert: aResult links first arrow source equals: '+<>'.
	self assert: aResult links first end source equals: 'node a'.

	self assert: aResult links second start source equals: 'node b'.
	self assert: aResult links second arrow source equals: '->'.
	self assert: aResult links second end source equals: 'node d'.

	^ aResult
]

{ #category : #'examples - parser' }
GtWardleyMapParserExamples >> parseScriptWithPipeline [
	<gtExample>
	<return: #GtWMFileNode>
	| aResult |
	aResult := GtWardleyMapParser parse: self scriptWithPipeline.

	self assert: aResult styles size equals: 1.
	self assert: aResult styles first style source equals: 'wardley'.

	self assert: aResult titles size equals: 1.
	self assert: aResult titles first name source equals: 'map with pipeline'.

	self assert: aResult elements size equals: 6.
	self assert: aResult elements first name source equals: 'node f'.
	self assert: aResult elements first coords visibility source equals: '0.96'.
	self assert: aResult elements first coords evolution source equals: '0.57'.
	self assert: aResult elements first label x source equals: '-36'.
	self assert: aResult elements first label y source equals: '-9'.

	self assert: aResult pipelines size equals: 1.
	self assert: aResult pipelines first name source equals: 'node a'.
	self assert: aResult pipelines first evolution1 source equals: '0.37'.
	self assert: aResult pipelines first evolution2 source equals: '0.72'.

	self assert: aResult links size equals: 1.
	self assert: aResult links first start source equals: 'node f'.
	self assert: aResult links first arrow source equals: '->'.
	self assert: aResult links first end source equals: 'node a'.

	^ aResult
]

{ #category : #'examples - pipeline' }
GtWardleyMapParserExamples >> parseScriptWithPipeline1 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'pipeline node a [0.08, .6]'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult pipelines size equals: 1.
	self assert: aResult pipelines first name source equals: 'node a'.
	self assert: aResult pipelines first evolution1 source equals: '0.08'.
	self assert: aResult pipelines first evolution2 source equals: '.6'.
	self assert: aResult pipelines first coordinate equals: 0.08 @ 0.6.

	^ aResult
]

{ #category : #'examples - pipeline' }
GtWardleyMapParserExamples >> parseScriptWithPipeline2 [
	<gtExample>
	<return: #GtWMFileNode>
	| aScript aResult |
	aScript := 'pipeline node a [-.08, -.6]'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult pipelines size equals: 1.
	self assert: aResult pipelines first name source equals: 'node a'.
	self assert: aResult pipelines first evolution1 source equals: '-.08'.
	self assert: aResult pipelines first evolution2 source equals: '-.6'.
	self assert: aResult pipelines first coordinate equals: -0.08 @ -0.6.

	^ aResult
]

{ #category : #'eamples - scripts' }
GtWardleyMapParserExamples >> scriptWithComment [
	<gtExample>
	<return: #ByteString>
	^ GtWardleyMapScriptExamples new withCommentLf
]

{ #category : #'eamples - scripts' }
GtWardleyMapParserExamples >> scriptWithNewSyntaxForPipeline [
	<gtExample>
	<return: #ByteString>
	^ GtWardleyMapScriptExamples new withNewSyntaxForPipelinesCr
]

{ #category : #'eamples - scripts' }
GtWardleyMapParserExamples >> scriptWithNote [
	<gtExample>
	<return: #ByteString>
	^ GtWardleyMapScriptExamples new withNoteLf
]

{ #category : #'eamples - scripts' }
GtWardleyMapParserExamples >> scriptWithPipeline [
	<gtExample>
	<return: #ByteString>
	^ GtWardleyMapScriptExamples new withPipelineLf
]
