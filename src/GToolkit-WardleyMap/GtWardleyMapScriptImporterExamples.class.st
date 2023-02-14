Class {
	#name : #GtWardleyMapScriptImporterExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'examples - imports' }
GtWardleyMapScriptImporterExamples >> importScript [
	<gtExample>
	
	| aScript aWardleyMap anImporter |
	aWardleyMap := GtWardleyMapModelExamples new newMapWithPipelineInnerNodes.
	aScript := aWardleyMap asWardleyMapScript.
	anImporter := GtWardleyMapScriptImporter new 
		stream: aScript readStream;
		import.
	
	^ GtWardleyMapScriptExampleResult new 
		originalWardleyMap: aWardleyMap;
		originalScript: aScript;
		resultingWardleyMap: anImporter wardleyMap
]

{ #category : #'examples - imports' }
GtWardleyMapScriptImporterExamples >> importScriptWithPipeline [
	<gtExample>
	
	| aScript anImporter aMap aNodeA aNodeB aNodeC aNodeD aNodeE aNodeF |
	aScript := self scriptWithPipeline.
	anImporter := GtWardleyMapScriptImporter new 
		stream: aScript readStream;
		import.
		
	aMap := anImporter wardleyMap.
	
	self assert: aMap title equals: 'map with pipeline'.
	self assert: aMap nodes size equals: 6.
	self assert: aMap edges size equals: 1.
	
	aNodeA := aMap nodes detect: [ :each | each label = 'node a' ].
	self assert: aNodeA x equals: 0.5.
	self assert: aNodeA y equals: 1 - 0.86.
	self assert: aNodeA innerNodes size equals: 4.
	self assert: aNodeA pipelineNode isNil.
	
	aNodeB := aMap nodes detect: [ :each | each label = 'node b' ].
	self assert: aNodeB x equals: 0.38.
	self assert: aNodeB y equals: aNodeA y.
	self assert: (aNodeA innerNodes identityIncludes: aNodeB).
	self assert: aNodeB pipelineNode equals: aNodeA.
	
	aNodeC := aMap nodes detect: [ :each | each label = 'node c' ].
	self assert: aNodeC x equals: 0.46.
	self assert: aNodeC y equals: aNodeA y.
	self assert: (aNodeA innerNodes identityIncludes: aNodeC).
	self assert: aNodeC pipelineNode equals: aNodeA.

	aNodeD := aMap nodes detect: [ :each | each label = 'node d' ].
	self assert: aNodeD x equals: 0.61.
	self assert: aNodeD y equals: aNodeA y.
	self assert: (aNodeA innerNodes identityIncludes: aNodeD).
	self assert: aNodeD pipelineNode equals: aNodeA.
	
	aNodeE := aMap nodes detect: [ :each | each label = 'node e' ].
	self assert: aNodeE x equals: 0.71.
	self assert: aNodeE y equals: aNodeA y.
	self assert: (aNodeA innerNodes identityIncludes: aNodeE).
	self assert: aNodeE pipelineNode equals: aNodeA.
	
	self 
		assert: aNodeA pipelineCoordinate x 
		equals: aNodeB x - GtWardleyMapConstants  pipelineRelativeOffset.
	self 
		assert: aNodeA pipelineCoordinate y 
		equals: aNodeE x + GtWardleyMapConstants  pipelineRelativeOffset.
	
	aNodeF := aMap nodes detect: [ :each | each label = 'node f' ].
	self assert: aNodeF x equals: 0.57.
	self assert: aNodeF y equals: 1 - 0.96.
	self assert: (aNodeA innerNodes identityIncludes: aNodeF) not.
	self assert: aNodeF pipelineNode isNil.
	
	^ GtWardleyMapScriptExampleResult new 
		originalScript: aScript;
		resultingWardleyMap: anImporter wardleyMap
]

{ #category : #'examples - imports' }
GtWardleyMapScriptImporterExamples >> importScriptWithTwoPipelines [
	<gtExample>
	
	| aScript anImporter aMap aNodeA aNodeB aNodeC aNodeD aNodeE aNodeF aNodeG |
	aScript := self scriptWithTwoPipelines.
	anImporter := GtWardleyMapScriptImporter new 
		stream: aScript readStream;
		import.
		
	aMap := anImporter wardleyMap.
	
	self assert: aMap nodes size equals: 7.
	self assert: aMap edges size equals: 0.
	
	aNodeA := aMap nodes detect: [ :each | each label = 'node a' ].
	self assert: aNodeA x equals: 0.49.
	self assert: aNodeA y equals: 1 - 0.87.
	self assert: aNodeA innerNodes size equals: 2.
	self assert: aNodeA pipelineNode isNil.
	
	aNodeD := aMap nodes detect: [ :each | each label = 'node d' ].
	self assert: aNodeD x equals: 0.48.
	self assert: aNodeD y equals: 1 - 0.77.
	self assert: aNodeD innerNodes size equals: 3.
	self assert: aNodeD pipelineNode isNil.
	
	aNodeB := aMap nodes detect: [ :each | each label = 'node b' ].
	self assert: aNodeB x equals: 0.21.
	self assert: aNodeB y equals: aNodeA y.
	self assert: (aNodeA innerNodes identityIncludes: aNodeB).
	self assert: aNodeB pipelineNode equals: aNodeA.
	
	aNodeC := aMap nodes detect: [ :each | each label = 'node c' ].
	self assert: aNodeC x equals: 0.81.
	self assert: aNodeC y equals: aNodeA y.
	self assert: (aNodeA innerNodes identityIncludes: aNodeC).
	self assert: aNodeC pipelineNode equals: aNodeA.

	aNodeE := aMap nodes detect: [ :each | each label = 'node e' ].
	self assert: aNodeE x equals: 0.24.
	self assert: aNodeE y equals: aNodeD y.
	self assert: (aNodeD innerNodes identityIncludes: aNodeE).
	self assert: aNodeE pipelineNode equals: aNodeD.
	
	aNodeF := aMap nodes detect: [ :each | each label = 'node f' ].
	self assert: aNodeF x equals: 0.65.
	self assert: aNodeF y equals: aNodeD y.
	self assert: (aNodeD innerNodes identityIncludes: aNodeF).
	self assert: aNodeF pipelineNode equals: aNodeD.
	
	aNodeG := aMap nodes detect: [ :each | each label = 'node g' ].
	self assert: aNodeG x equals: 0.78.
	self assert: aNodeG y equals: aNodeD y.
	self assert: (aNodeD innerNodes identityIncludes: aNodeG).
	self assert: aNodeG pipelineNode equals: aNodeD.
	
	self 
		assert: aNodeA pipelineCoordinate x 
		equals: aNodeB x - GtWardleyMapConstants  pipelineRelativeOffset.
	self 
		assert: aNodeA pipelineCoordinate y 
		equals: aNodeC x + GtWardleyMapConstants  pipelineRelativeOffset.
	
	self 
		assert: aNodeD pipelineCoordinate x 
		equals: aNodeE x - GtWardleyMapConstants  pipelineRelativeOffset.
	self 
		assert: aNodeD pipelineCoordinate y 
		equals: aNodeG x + GtWardleyMapConstants  pipelineRelativeOffset.
	
	^ GtWardleyMapScriptExampleResult new 
		originalScript: aScript;
		resultingWardleyMap: anImporter wardleyMap
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptImporterExamples >> scriptWithPipeline [
	<gtExample>
	^ GtWardleyMapScriptExamples new withPipelineCr
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptImporterExamples >> scriptWithTwoPipelines [
	<gtExample>
	^ GtWardleyMapScriptExamples new withTwoPipelinesCr
]
