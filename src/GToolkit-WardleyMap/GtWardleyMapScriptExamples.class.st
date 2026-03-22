Class {
	#name : #GtWardleyMapScriptExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #asserting }
GtWardleyMapScriptExamples >> assertCrNewLine: aScript [
	"Ensure only CR new line characters are used"

	self
		assert: [ (aScript includes: Character lf) not ]
		description: [ 'Script must includes only CR new line characters' ]
]

{ #category : #asserting }
GtWardleyMapScriptExamples >> assertLfNewLine: aScript [
	"Ensure only LF new line characters are used"

	self
		assert: [ (aScript includes: Character cr) not ]
		description: [ 'Script must includes only LF new line characters' ]
]

{ #category : #support }
GtWardleyMapScriptExamples >> convertToLf: aScript [
	^ aScript copyReplaceAll: String cr with: String lf
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptExamples >> withCommentCr [
	<gtExample>
	<return: #ByteString>
	| aScript |
	aScript := 'style wardley

title map with pipeline and note

// this is a comment
note (+opportunity) [0.82, 0.13] // this is a comment

component node b [0.85, 0.21] label [-76, -2] // this is a comment
component node c [0.86, 0.81] label [40, -2] // this is a comment
component node a [0.87, 0.49] label [-45, -12] // this is a comment
pipeline node a [0.2, 0.82] // this is a comment

component node d [0.65, 0.34] label [-55, 25]

node d+<>node a // this is a comment
node b->node d // this is a comment
'.

	self assertCrNewLine: aScript.

	^ aScript
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptExamples >> withCommentLf [
	<gtExample>
	<return: #ByteString>
	| aScript |
	aScript := self convertToLf: self withCommentCr.

	self assertLfNewLine: aScript.

	^ aScript
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptExamples >> withNewSyntaxForPipelinesCr [
	<gtExample>
	<return: #ByteString>
	| aScript |
	aScript := '// General
// Map is licensed under creative commons share alike.
// https://creativecommons.org/licenses/by-sa/4.0/

title Something
evolution genesis / concept -> custom / emerging -> product / converging -> commodity / accepted
style wardley

note Node C pipeline comment [0.45, 0.45]

// components
component Node A [0.95, 0.66]
component Node B [0.84, 0.57] label [-91, -5]
pipeline Node B

component Node C [0.50, 0.67] label [-2, -17]
pipeline Node C
{
component Node D [0.17] label [-63, 14]
component Node E [0.80] label [20, 18]
}

component Node F [0.15, 0.70] label [4, -12]
pipeline Node F
{
component Node G [0.67] label [-5, 33]
component Node H [0.75] label [-5, 33]
evolve Node G -> something g 0.8 label [-5, 20]
}

evolve Node B 0.73 label [-5, 21]
evolve Node C -> something c 0.9 label [-5, 21]

//connections

Node A->Node B;comment on A-B edge
Node B->Node C
Node C->Node F;comment on C-F edge
'.

	self assertCrNewLine: aScript.

	^ aScript
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptExamples >> withNewSyntaxForPipelinesCrSimplified [
	<gtExample>
	<return: #ByteString>
	| aScript |
	aScript := 'style wardley

title Something
evolution genesis / concept -> custom / emerging -> product / converging -> commodity / accepted

note Node C pipeline comment [0.45, 0.45]

component Node A [0.95, 0.66] label [-10, 29]
component Node B [0.84, 0.57] label [-91, -5]
pipeline Node B
component Node C [0.50, 0.67] label [-2, -17]
pipeline Node C
{
component Node D [0.17] label [-63, 14]
component Node E [0.80] label [20, 18]
}
component Node F [0.18, 0.70] label [4, -12]
pipeline Node F
{
component Node G [0.67] label [-31, 15]
component Node H [0.75] label [15, 16]
}

evolve Node B 0.73 label [-5, 21]
evolve Node C -> something c 0.90 label [-5, 21]
evolve Node G -> something g 0.80 label [-5, 20]


Node A->Node B;comment on A-B edge
Node B->Node C
Node C->Node F;comment on C-F edge
'.

	self assertCrNewLine: aScript.

	^ aScript
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptExamples >> withNewSyntaxForPipelinesLfSimplified [
	<gtExample>
	<return: #ByteString>
	| aScript |
	aScript := self convertToLf: self withNewSyntaxForPipelinesCrSimplified.

	self assertLfNewLine: aScript.

	^ aScript
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptExamples >> withNoteCr [
	<gtExample>
	<return: #ByteString>
	| aScript |
	aScript := 'style wardley

title map with pipeline and note

note (+opportunity) [0.82, 0.13]

component node b [0.85, 0.21] label [-76, -2]
component node c [0.86, 0.81] label [40, -2]
component node a [0.87, 0.49] label [-45, -12]
pipeline node a [0.2, 0.82]

component node d [0.65, 0.34] label [-55, 25]

node d+<>node a
node b->node d
'.

	self assertCrNewLine: aScript.

	^ aScript
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptExamples >> withNoteLf [
	<gtExample>
	<return: #ByteString>
	| aScript |
	aScript := self convertToLf: self withNoteCr.

	self assertLfNewLine: aScript.

	^ aScript
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptExamples >> withPipelineCr [
	<gtExample>
	<return: #ByteString>
	| aScript |
	aScript := 'style wardley

title map with pipeline
evolution genesis -> custom built -> product (+rental) -> commodity

component node f [0.96, 0.57] label [-36, -9]

component node b [0.84, 0.38] label [-46, 28]
component node c [0.84, 0.46] label [-21, 25]
component node d [0.84, 0.61] label [-32, 26]
component node e [0.84, 0.71] label [-20, 26]
component node a [0.86, 0.50] label [-35, -12]
pipeline node a [0.37, 0.72]


node f->node a
'.

	self assertCrNewLine: aScript.

	^ aScript
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptExamples >> withPipelineLf [
	<gtExample>
	<return: #ByteString>
	| aScript |
	aScript := self convertToLf: self withPipelineCr.

	self assertLfNewLine: aScript.

	^ aScript
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptExamples >> withTwoPipelinesCr [
	<gtExample>
	<return: #ByteString>
	| aScript |
	aScript := 'style wardley

evolution genesis -> custom built -> product (+rental) -> commodity

component node b [0.85, 0.21] label [-76, -2]
component node c [0.85, 0.81] label [40, -2]
component node a [0.87, 0.49] label [-45, -12]
pipeline node a [0.20, 0.82]

component node e [0.75, 0.24] label [-100, 2]
component node f [0.75, 0.65] label [-53, 23]
component node g [0.75, 0.78] label [20, 9]
component node d [0.77, 0.48] label [9, -5]
pipeline node d [0.23, 0.79]


'.

	self assertCrNewLine: aScript.

	^ aScript
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptExamples >> withTwoPipelinesLf [
	<gtExample>
	<return: #ByteString>
	| aScript |
	aScript := self convertToLf: self withTwoPipelinesCr.

	self assertLfNewLine: aScript.

	^ aScript
]
