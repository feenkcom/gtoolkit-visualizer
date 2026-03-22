Class {
	#name : #GtWardleyMapScriptExporterExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #accessing }
GtWardleyMapScriptExporterExamples >> convertWithCrNewLines: aScript [ 

	^ (aScript copyReplaceAll: String cr, String lf with: String cr)
		copyReplaceAll: String lf with: String cr
]

{ #category : #accessing }
GtWardleyMapScriptExporterExamples >> exportMapWithNewSyntaxForPipelineSimplifiedAndLfNewLines [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	| aMap anExporter aScript aResult aCrNewLineScript |
	aResult := self resultWithImportedMapWithNewSyntaxForPipelineSimplified.
	aMap := aResult resultingWardleyMap.

	anExporter := GtWardleyMapScriptExporter new.
	aScript := anExporter
			beNewPipelineSyntax;
			beLfNewLine;
			wardleyMap: aMap;
			export;
			script.

	self assert: (aScript includes: Character cr) not.

	self assert: (aScript = aResult originalScript) not.

	aCrNewLineScript := self convertWithCrNewLines: aScript.

	self assert: aCrNewLineScript equals: aResult originalScript.

	^ GtWardleyMapScriptExampleResult new
		originalWardleyMap: aMap;
		originalScript: aResult originalScript;
		resultingScript: aCrNewLineScript
]

{ #category : #accessing }
GtWardleyMapScriptExporterExamples >> exportMapWithNoteLf [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	| aMap anExporter aScript aResult aCrNewLineScript |
	aResult := self resultWithImportedMapWithNoteLf.
	aMap := aResult resultingWardleyMap.

	anExporter := GtWardleyMapScriptExporter new.
	aScript := anExporter
			beOldPipelineSyntax;
			beLfNewLine;
			wardleyMap: aMap;
			export;
			script.

	self assert: (aScript includes: Character cr) not.

	self assert: (aScript = aResult originalScript) not.

	aCrNewLineScript := self convertWithCrNewLines: aScript.

	self
		assert: (aResult originalScript includesSubstring: 'note (+opportunity) [0.82, 0.13]').
	self
		assert: (aCrNewLineScript includesSubstring: 'note (+opportunity) [0.82, 0.13]').


	true
		ifFalse: [  "Currently, there are edges that we do not support."self
				assert: aCrNewLineScript
				equals: aResult originalScript ].

	^ GtWardleyMapScriptExampleResult new
		originalWardleyMap: aMap;
		originalScript: aResult originalScript;
		resultingScript: aCrNewLineScript
]

{ #category : #accessing }
GtWardleyMapScriptExporterExamples >> exportMapWithPipeline [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	| aMap anExporter aScript aResult |
	aResult := self resultWithImportedMapWithPipeline.
	aMap := aResult resultingWardleyMap.

	anExporter := GtWardleyMapScriptExporter new.
	aScript := anExporter
			beOldPipelineSyntax;
			beCrNewLine;
			wardleyMap: aMap;
			export;
			script.

	self assert: aScript equals: aResult originalScript.

	^ GtWardleyMapScriptExampleResult new
		originalWardleyMap: aMap;
		originalScript: aResult originalScript;
		resultingScript: aScript
]

{ #category : #accessing }
GtWardleyMapScriptExporterExamples >> exportMapWithPipelineAndLfNewLines [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	| aMap anExporter aScript aResult aCrNewLineScript |
	aResult := self resultWithImportedMapWithPipeline.
	aMap := aResult resultingWardleyMap.

	anExporter := GtWardleyMapScriptExporter new.
	aScript := anExporter
			beOldPipelineSyntax;
			beLfNewLine;
			wardleyMap: aMap;
			export;
			script.

	self assert: (aScript includes: Character cr) not.

	self assert: (aScript = aResult originalScript) not.

	aCrNewLineScript := self convertWithCrNewLines: aScript.

	self assert: aCrNewLineScript equals: aResult originalScript.

	^ GtWardleyMapScriptExampleResult new
		originalWardleyMap: aMap;
		originalScript: aResult originalScript;
		resultingScript: aCrNewLineScript
]

{ #category : #accessing }
GtWardleyMapScriptExporterExamples >> exportMapWithTwoPipelines [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	| aMap anExporter aScript aResult |
	aResult := self resultWithImportedMapWithTwoPipelines.
	aMap := aResult resultingWardleyMap.

	anExporter := GtWardleyMapScriptExporter new.
	aScript := anExporter
			beOldPipelineSyntax;
			beCrNewLine;
			wardleyMap: aMap;
			export;
			script.

	self assert: aScript equals: aResult originalScript.

	^ GtWardleyMapScriptExampleResult new
		originalWardleyMap: aMap;
		originalScript: aResult originalScript;
		resultingScript: aScript
]

{ #category : #accessing }
GtWardleyMapScriptExporterExamples >> exportMapWithTwoPipelinesAndLfNewLines [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	| aMap anExporter aScript aResult aCrNewLineScript |
	aResult := self resultWithImportedMapWithTwoPipelines.
	aMap := aResult resultingWardleyMap.

	anExporter := GtWardleyMapScriptExporter new.
	aScript := anExporter
			beOldPipelineSyntax;
			beLfNewLine;
			wardleyMap: aMap;
			export;
			script.

	self assert: (aScript includes: Character cr) not.

	self assert: (aScript = aResult originalScript) not.

	aCrNewLineScript := self convertWithCrNewLines: aScript.

	self assert: aCrNewLineScript equals: aResult originalScript.

	^ GtWardleyMapScriptExampleResult new
		originalWardleyMap: aMap;
		originalScript: aResult originalScript;
		resultingScript: aCrNewLineScript
]

{ #category : #'examples - model' }
GtWardleyMapScriptExporterExamples >> resultWithImportedMapWithNewSyntaxForPipeline [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	^ GtWardleyMapScriptImporterExamples new importScriptWithNewSyntaxForPipeline
]

{ #category : #'examples - model' }
GtWardleyMapScriptExporterExamples >> resultWithImportedMapWithNewSyntaxForPipelineSimplified [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	^ GtWardleyMapScriptImporterExamples new
		importScriptWithNewSyntaxForPipelineSimplified
]

{ #category : #'examples - model' }
GtWardleyMapScriptExporterExamples >> resultWithImportedMapWithNoteLf [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	^ GtWardleyMapScriptImporterExamples new importScriptWithNoteLf
]

{ #category : #'examples - model' }
GtWardleyMapScriptExporterExamples >> resultWithImportedMapWithPipeline [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	^ GtWardleyMapScriptImporterExamples new importScriptWithPipeline
]

{ #category : #'examples - model' }
GtWardleyMapScriptExporterExamples >> resultWithImportedMapWithTwoPipelines [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	^ GtWardleyMapScriptImporterExamples new importScriptWithTwoPipelines
]
