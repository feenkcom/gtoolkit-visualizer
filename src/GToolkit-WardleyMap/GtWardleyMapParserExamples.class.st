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
GtWardleyMapParserExamples >> parseScriptWithNewSyntaxForPipeline [

	<gtExample>
	
	| aResult |
	aResult := GtWardleyMapParser parse: self scriptWithNewSyntaxForPipeline.
	
	^ aResult.
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
