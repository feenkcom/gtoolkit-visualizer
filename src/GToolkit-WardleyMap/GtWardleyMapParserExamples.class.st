Class {
	#name : #GtWardleyMapParserExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'examples - parser' }
GtWardleyMapParserExamples >> parseScriptWithComment [
	<gtExample>
	| aResult |
	aResult := GtWardleyMapParser parse: self scriptWithComment.

	^ aResult
]

{ #category : #'examples - parser' }
GtWardleyMapParserExamples >> parseScriptWithEvolution [
	<gtExample>
	<noTest>
	| aScript aResult |
	aScript := 'evolution genesis / concept -> custom / emerging -> product / converging -> commodity/ accepted'.
	aResult := GtWardleyMapParser parse: aScript.

	self assert: aResult evolutions size equals: 1.
	self assert: aResult links size equals: 0.

	^ aResult
]

{ #category : #'examples - parser' }
GtWardleyMapParserExamples >> parseScriptWithNewSyntaxForPipeline [
	<gtExample>
	<noTest>
	| aResult |
	aResult := GtWardleyMapParser parse: self scriptWithNewSyntaxForPipeline.

	self assert: aResult evolutions size equals: 1.
	self assert: aResult evolves size equals: 2.
	self assert: aResult elements size equals: 4.
	self assert: aResult links size equals: 3.
	self assert: aResult note size equals: 1.

	^ aResult
]

{ #category : #'examples - parser' }
GtWardleyMapParserExamples >> parseScriptWithNote [
	<gtExample>
	| aResult |
	aResult := GtWardleyMapParser parse: self scriptWithNote.

	^ aResult
]

{ #category : #'examples - parser' }
GtWardleyMapParserExamples >> parseScriptWithPipeline [

	<gtExample>
	
	| aResult |
	aResult := GtWardleyMapParser parse: self scriptWithPipeline.
	
	^ aResult.
]

{ #category : #'eamples - scripts' }
GtWardleyMapParserExamples >> scriptWithComment [
	<gtExample>
	^ GtWardleyMapScriptExamples new withCommentLf
]

{ #category : #'eamples - scripts' }
GtWardleyMapParserExamples >> scriptWithNewSyntaxForPipeline [
	<gtExample>
	^ GtWardleyMapScriptExamples new withNewSyntaxForPipelinesCr
]

{ #category : #'eamples - scripts' }
GtWardleyMapParserExamples >> scriptWithNote [
	<gtExample>
	^ GtWardleyMapScriptExamples new withNoteLf
]

{ #category : #'eamples - scripts' }
GtWardleyMapParserExamples >> scriptWithPipeline [
	<gtExample>
	^ GtWardleyMapScriptExamples new withPipelineLf
]
