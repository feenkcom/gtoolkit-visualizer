Class {
	#name : #GtWardleyMapScriptImporterExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #examples }
GtWardleyMapScriptImporterExamples >> importScript [
	<gtExample>
	
	| aScript aWardleyMap anImporter |
	aWardleyMap := GtWardleyMapModelExamples new newMapWithPipelineInnerNodes.
	aScript := aWardleyMap asWardleyMapScript.
	anImporter := GtWardleyMapScriptImporter new 
		stream: aScript readStream;
		import.
	
	^ GtWardleyMapScriptImporterExampleResult new 
		originalWardleyMap: aWardleyMap;
		script: aScript;
		importedWardleyMap: anImporter wardleyMap
]
