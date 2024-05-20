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
	
	self 
		assert: aCrNewLineScript
		equals: aResult originalScript.

	^ GtWardleyMapScriptExampleResult new
		originalWardleyMap: aMap;
		originalScript: aResult originalScript;
		resultingScript: aCrNewLineScript
]

{ #category : #accessing }
GtWardleyMapScriptExporterExamples >> exportMapWithPipeline [
	<gtExample>
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
			
	self 
		assert: aScript
		equals: aResult originalScript.

	^ GtWardleyMapScriptExampleResult new
		originalWardleyMap: aMap;
		originalScript: aResult originalScript;
		resultingScript: aScript
]

{ #category : #accessing }
GtWardleyMapScriptExporterExamples >> exportMapWithPipelineAndLfNewLines [
	<gtExample>
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
	
	self 
		assert: aCrNewLineScript
		equals: aResult originalScript.

	^ GtWardleyMapScriptExampleResult new
		originalWardleyMap: aMap;
		originalScript: aResult originalScript;
		resultingScript: aCrNewLineScript
]

{ #category : #accessing }
GtWardleyMapScriptExporterExamples >> exportMapWithTwoPipelines [
	<gtExample>
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
			
	self 
		assert: aScript
		equals: aResult originalScript.

	^ GtWardleyMapScriptExampleResult new
		originalWardleyMap: aMap;
		originalScript: aResult originalScript;
		resultingScript: aScript
]

{ #category : #accessing }
GtWardleyMapScriptExporterExamples >> exportMapWithTwoPipelinesAndLfNewLines [
	<gtExample>
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
	
	self 
		assert: aCrNewLineScript
		equals: aResult originalScript.

	^ GtWardleyMapScriptExampleResult new
		originalWardleyMap: aMap;
		originalScript: aResult originalScript;
		resultingScript: aCrNewLineScript
]

{ #category : #'examples - model' }
GtWardleyMapScriptExporterExamples >> resultWithImportedMapWithNewSyntaxForPipeline [
	<gtExample>
	^ GtWardleyMapScriptImporterExamples new importScriptWithNewSyntaxForPipeline
]

{ #category : #'examples - model' }
GtWardleyMapScriptExporterExamples >> resultWithImportedMapWithNewSyntaxForPipelineSimplified [
	<gtExample>
	^ GtWardleyMapScriptImporterExamples new importScriptWithNewSyntaxForPipelineSimplified
]

{ #category : #'examples - model' }
GtWardleyMapScriptExporterExamples >> resultWithImportedMapWithPipeline [
	<gtExample>
	^ GtWardleyMapScriptImporterExamples new importScriptWithPipeline
]

{ #category : #'examples - model' }
GtWardleyMapScriptExporterExamples >> resultWithImportedMapWithTwoPipelines [
	<gtExample>
	^ GtWardleyMapScriptImporterExamples new importScriptWithTwoPipelines
]
