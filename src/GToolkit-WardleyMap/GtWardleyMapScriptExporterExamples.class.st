Class {
	#name : #GtWardleyMapScriptExporterExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #accessing }
GtWardleyMapScriptExporterExamples >> convertWitCrNewLines: aScript [ 

	^ (aScript copyReplaceAll: String cr, String lf with: String cr)
		copyReplaceAll: String lf with: String cr
]

{ #category : #accessing }
GtWardleyMapScriptExporterExamples >> exportMapWithPipeline [
	<gtExample>
	| aMap anExporter aScript aResult |
	aResult := self resultWithImportedMapWithPipeline.
	aMap := aResult resultingWardleyMap.

	anExporter := GtWardleyMapScriptExporter new.
	aScript := anExporter
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
		beLfNewLine;
		wardleyMap: aMap;
		export;
		script.
		
	self assert: (aScript includes: Character cr) not.
		
	self assert: (aScript = aResult originalScript) not.
	
	aCrNewLineScript := self convertWitCrNewLines: aScript.
	
	self 
		assert: aCrNewLineScript
		equals: aResult originalScript.

	^ GtWardleyMapScriptExampleResult new
		originalWardleyMap: aMap;
		originalScript: aResult originalScript;
		resultingScript: aCrNewLineScript
]

{ #category : #'examples - model' }
GtWardleyMapScriptExporterExamples >> resultWithImportedMapWithPipeline [
	<gtExample>
	^ GtWardleyMapScriptImporterExamples new importScriptWithPipeline
]
