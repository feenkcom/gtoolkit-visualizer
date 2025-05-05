Class {
	#name : #GtWardleyMapScriptImporterExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'examples - imports' }
GtWardleyMapScriptImporterExamples >> importScript [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
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
GtWardleyMapScriptImporterExamples >> importScriptWithNewSyntaxForPipeline [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	| aScript anImporter aMap aNodeA aNodeB aNodeD aNodeC aNodeG aNodeH aNodeF anEdgeAB anEdgeBC anEdgeCF aNodeE anEvolutionSections |
	aScript := self scriptWithNewSyntaxForPipeline.
	anImporter := GtWardleyMapScriptImporter new
			stream: aScript readStream;
			import.

	aMap := anImporter wardleyMap.

	self assert: aMap title equals: 'Something'.
	self assert: aMap nodes size equals: 8.
	self assert: aMap edges size equals: 3.

	anEvolutionSections := {'genesis / concept'.
			'custom / emerging'.
			'product / converging'.
			'commodity / accepted'}.
	self
		assert: anEvolutionSections ~= GtWardleyMapConstants defaultEvolutionSections.
	self assert: aMap evolutionSections equals: anEvolutionSections.
	self assert: aMap isEvolutionAxisVisible.

	aNodeA := aMap nodes detect: [ :each | each label = 'Node A' ].
	self assert: aNodeA evolution equals: 0.66.
	self assert: aNodeA x equals: 0.66.
	self assert: aNodeA visibility equals: 0.95.
	self assert: aNodeA y equals: 1 - 0.95.
	self assert: aNodeA innerNodes size equals: 0.
	self assert: aNodeA pipelineNode isNil.

	aNodeB := aMap nodes detect: [ :each | each label = 'Node B' ].
	self assert: aNodeB x equals: 0.57.
	self assert: aNodeB y equals: 1 - 0.84.
	self assert: aNodeB innerNodes size equals: 0.
	self assert: aNodeB pipelineNode isNil.

	aNodeD := aMap nodes detect: [ :each | each label = 'Node D' ].
	self assert: aNodeD x equals: 0.17.
	self assert: aNodeD y equals: 1 - 0.50.
	self assert: aNodeD innerNodes size equals: 0.

	aNodeE := aMap nodes detect: [ :each | each label = 'Node E' ].
	self assert: aNodeE x equals: 0.80.
	self assert: aNodeE y equals: 1 - 0.50.
	self assert: aNodeE innerNodes size equals: 0.

	aNodeC := aMap nodes detect: [ :each | each label = 'Node C' ].
	self assert: aNodeC x equals: 0.67.
	self assert: aNodeC y equals: 1 - 0.50.
	self assert: aNodeC innerNodes size equals: 2.
	self assert: (aNodeC innerNodes identityIncludes: aNodeD).
	self assert: (aNodeC innerNodes identityIncludes: aNodeD).
	self assert: aNodeD pipelineNode equals: aNodeC.
	self assert: aNodeD pipelineNode equals: aNodeC.
	self assert: aNodeC pipelineNode isNil.

	aNodeG := aMap nodes detect: [ :each | each label = 'Node G' ].
	self assert: aNodeG x equals: 0.67.
	self assert: aNodeG y equals: 1 - 0.15.
	self assert: aNodeG innerNodes size equals: 0.

	aNodeH := aMap nodes detect: [ :each | each label = 'Node H' ].
	self assert: aNodeH x equals: 0.75.
	self assert: aNodeH y equals: 1 - 0.15.
	self assert: aNodeH innerNodes size equals: 0.

	aNodeF := aMap nodes detect: [ :each | each label = 'Node F' ].
	self assert: aNodeF x equals: 0.70.
	self assert: aNodeF y equals: 1 - 0.15.
	self assert: aNodeF innerNodes size equals: 2.
	self assert: (aNodeF innerNodes identityIncludes: aNodeG).
	self assert: (aNodeF innerNodes identityIncludes: aNodeH).
	self assert: aNodeG pipelineNode equals: aNodeF.
	self assert: aNodeH pipelineNode equals: aNodeF.
	self assert: aNodeF pipelineNode isNil.

	self
		assert: (aNodeC pipelineCoordinate x
				closeTo: aNodeD x - GtWardleyMapConstants pipelineRelativeOffset
				precision: 0.001).
	self
		assert: aNodeC pipelineCoordinate y
		equals: aNodeE x + GtWardleyMapConstants pipelineRelativeOffset.

	self
		assert: aNodeF pipelineCoordinate x
		equals: aNodeG x - GtWardleyMapConstants pipelineRelativeOffset.
	self
		assert: aNodeF pipelineCoordinate y
		equals: aNodeH x + GtWardleyMapConstants pipelineRelativeOffset.

	anEdgeAB := aMap edges
			detect: [ :each | each fromNode = aNodeA and: [ each toNode = aNodeB ] ].
	self assert: anEdgeAB isLabelVisible.
	self assert: anEdgeAB label equals: 'comment on A-B edge'.

	anEdgeBC := aMap edges
			detect: [ :each | each fromNode = aNodeB and: [ each toNode = aNodeC ] ].
	self assert: anEdgeBC isLabelVisible not.
	self assert: anEdgeBC label equals: 'Edge label'.

	anEdgeCF := aMap edges
			detect: [ :each | each fromNode = aNodeC and: [ each toNode = aNodeF ] ].
	self assert: anEdgeCF isLabelVisible.
	self assert: anEdgeCF label equals: 'comment on C-F edge'.

	^ GtWardleyMapScriptExampleResult new
		originalScript: aScript;
		resultingWardleyMap: anImporter wardleyMap
]

{ #category : #'examples - imports' }
GtWardleyMapScriptImporterExamples >> importScriptWithNewSyntaxForPipelineSimplified [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	| aScript anImporter aMap aNodeA aNodeB aNodeD aNodeE aNodeC aNodeG aNodeH aNodeF anEdgeAB anEdgeCF anEdgeBC aSections |
	aScript := self scriptWithNewSyntaxForPipelineSimplified.
	anImporter := GtWardleyMapScriptImporter new
			stream: aScript readStream;
			import.

	aMap := anImporter wardleyMap.

	aSections := {'genesis / concept'.
			'custom / emerging'.
			'product / converging'.
			'commodity / accepted'}.
	self assert: aMap evolutionSections equals: aSections.
	self assert: aMap isEvolutionAxisVisible.

	self assert: aMap title equals: 'Something'.
	self assert: aMap nodes size equals: 8.
	self assert: aMap edges size equals: 3.

	aNodeA := aMap nodes detect: [ :each | each label = 'Node A' ].
	self assert: aNodeA evolution equals: 0.66.
	self assert: aNodeA x equals: 0.66.
	self assert: aNodeA visibility equals: 0.95.
	self assert: aNodeA y equals: 1 - 0.95.
	self assert: aNodeA innerNodes size equals: 0.
	self assert: aNodeA pipelineNode isNil.
	self assert: aNodeA isEvolveVisible not.

	aNodeB := aMap nodes detect: [ :each | each label = 'Node B' ].
	self assert: aNodeB x equals: 0.57.
	self assert: aNodeB y equals: 1 - 0.84.
	self assert: aNodeB innerNodes size equals: 0.
	self assert: aNodeB pipelineNode isNil.
	self assert: aNodeB isEvolveVisible.
	self assert: aNodeB evolvedLabel equals: 'Node B'.
	self assert: aNodeB evolvedEvolution equals: 0.73.
	self assert: aNodeB isEvolvedLabelVisible not.

	aNodeD := aMap nodes detect: [ :each | each label = 'Node D' ].
	self assert: aNodeD x equals: 0.17.
	self assert: aNodeD y equals: 1 - 0.50.
	self assert: aNodeD innerNodes size equals: 0.
	self assert: aNodeD isEvolveVisible not.

	aNodeE := aMap nodes detect: [ :each | each label = 'Node E' ].
	self assert: aNodeE x equals: 0.80.
	self assert: aNodeE y equals: 1 - 0.50.
	self assert: aNodeE innerNodes size equals: 0.
	self assert: aNodeE isEvolveVisible not.

	aNodeC := aMap nodes detect: [ :each | each label = 'Node C' ].
	self assert: aNodeC x equals: 0.67.
	self assert: aNodeC y equals: 1 - 0.50.
	self assert: aNodeC innerNodes size equals: 2.
	self assert: (aNodeC innerNodes identityIncludes: aNodeD).
	self assert: (aNodeC innerNodes identityIncludes: aNodeE).
	self assert: aNodeD pipelineNode equals: aNodeC.
	self assert: aNodeE pipelineNode equals: aNodeC.
	self assert: aNodeC pipelineNode isNil.
	self assert: aNodeC isEvolveVisible.
	self assert: aNodeC evolvedLabel equals: 'something c'.
	self assert: aNodeC evolvedEvolution equals: 0.90.
	self assert: aNodeC isEvolvedLabelVisible.

	aNodeG := aMap nodes detect: [ :each | each label = 'Node G' ].
	self assert: aNodeG x equals: 0.67.
	self assert: aNodeG y equals: 1 - 0.18.
	self assert: aNodeG innerNodes size equals: 0.
	self assert: aNodeG isEvolveVisible.
	self assert: aNodeG evolvedLabel equals: 'something g'.
	self assert: aNodeG evolvedEvolution equals: 0.80.
	self assert: aNodeG isEvolvedLabelVisible.

	aNodeH := aMap nodes detect: [ :each | each label = 'Node H' ].
	self assert: aNodeH x equals: 0.75.
	self assert: aNodeH y equals: 1 - 0.18.
	self assert: aNodeH innerNodes size equals: 0.
	self assert: aNodeH isEvolveVisible not.

	aNodeF := aMap nodes detect: [ :each | each label = 'Node F' ].
	self assert: aNodeF x equals: 0.70.
	self assert: aNodeF y equals: 1 - 0.18.
	self assert: aNodeF innerNodes size equals: 2.
	self assert: (aNodeF innerNodes identityIncludes: aNodeG).
	self assert: (aNodeF innerNodes identityIncludes: aNodeH).
	self assert: aNodeG pipelineNode equals: aNodeF.
	self assert: aNodeH pipelineNode equals: aNodeF.
	self assert: aNodeF pipelineNode isNil.
	self assert: aNodeF isEvolveVisible not.

	self
		assert: aNodeC pipelineCoordinate x
		equals: aNodeD x - GtWardleyMapConstants pipelineRelativeOffset.
	self
		assert: aNodeC pipelineCoordinate y
		equals: aNodeE x + GtWardleyMapConstants pipelineRelativeOffset.

	self
		assert: aNodeF pipelineCoordinate x
		equals: aNodeG x - GtWardleyMapConstants pipelineRelativeOffset.
	self
		assert: aNodeF pipelineCoordinate y
		equals: aNodeH x + GtWardleyMapConstants pipelineRelativeOffset.

	anEdgeAB := aMap
			edgeFromNode: aNodeA
			toNode: aNodeB
			ifFound: [ :anEdge | anEdge ]
			ifNone: [ nil ].
	self assert: anEdgeAB label equals: 'comment on A-B edge'.
	self assert: anEdgeAB isLabelVisible.

	anEdgeBC := aMap
			edgeFromNode: aNodeB
			toNode: aNodeC
			ifFound: [ :anEdge | anEdge ]
			ifNone: [ nil ].
	self assert: anEdgeBC isLabelVisible not.

	anEdgeCF := aMap
			edgeFromNode: aNodeC
			toNode: aNodeF
			ifFound: [ :anEdge | anEdge ]
			ifNone: [ nil ].
	self assert: anEdgeCF label equals: 'comment on C-F edge'.
	self assert: anEdgeCF isLabelVisible.

	^ GtWardleyMapScriptExampleResult new
		originalScript: aScript;
		resultingWardleyMap: anImporter wardleyMap
]

{ #category : #'examples - imports' }
GtWardleyMapScriptImporterExamples >> importScriptWithNoteLf [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	| aScript anImporter aMap aNoteA |
	aScript := self scriptWithNoteLf.
	anImporter := GtWardleyMapScriptImporter new
			stream: aScript readStream;
			import.

	aMap := anImporter wardleyMap.

	self assert: aMap title equals: 'map with pipeline and note'.
	self assert: aMap nodes size equals: 4.
	self assert: aMap edges size equals: 2.
	self assert: aMap notes size equals: 1.

	aNoteA := aMap notes detect: [ :each | each label = '(+opportunity)' ].
	self assert: aNoteA x equals: 0.13.
	self assert: aNoteA y equals: 1 - 0.82.

	^ GtWardleyMapScriptExampleResult new
		originalScript: aScript;
		resultingWardleyMap: anImporter wardleyMap
]

{ #category : #'examples - imports' }
GtWardleyMapScriptImporterExamples >> importScriptWithPipeline [
	<gtExample>
	<return: #GtWardleyMapScriptExampleResult>
	| aScript anImporter aMap aNodeA aNodeB aNodeC aNodeD aNodeE aNodeF |
	aScript := self scriptWithPipeline.
	anImporter := GtWardleyMapScriptImporter new
			stream: aScript readStream;
			import.

	aMap := anImporter wardleyMap.

	self assert: aMap title equals: 'map with pipeline'.
	self assert: aMap isTitleVisible.
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
		equals: aNodeB x - GtWardleyMapConstants pipelineRelativeOffset.
	self
		assert: aNodeA pipelineCoordinate y
		equals: aNodeE x + GtWardleyMapConstants pipelineRelativeOffset.

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
	<return: #GtWardleyMapScriptExampleResult>
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
		equals: aNodeB x - GtWardleyMapConstants pipelineRelativeOffset.
	self
		assert: aNodeA pipelineCoordinate y
		equals: aNodeC x + GtWardleyMapConstants pipelineRelativeOffset.

	self
		assert: aNodeD pipelineCoordinate x
		equals: aNodeE x - GtWardleyMapConstants pipelineRelativeOffset.
	self
		assert: aNodeD pipelineCoordinate y
		equals: aNodeG x + GtWardleyMapConstants pipelineRelativeOffset.

	^ GtWardleyMapScriptExampleResult new
		originalScript: aScript;
		resultingWardleyMap: anImporter wardleyMap
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptImporterExamples >> scriptWithNewSyntaxForPipeline [
	<gtExample>
	<return: #ByteString>
	^ GtWardleyMapScriptExamples new withNewSyntaxForPipelinesCr
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptImporterExamples >> scriptWithNewSyntaxForPipelineSimplified [
	<gtExample>
	<return: #ByteString>
	^ GtWardleyMapScriptExamples new withNewSyntaxForPipelinesCrSimplified
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptImporterExamples >> scriptWithNoteLf [
	<gtExample>
	<return: #ByteString>
	^ GtWardleyMapScriptExamples new withNoteLf
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptImporterExamples >> scriptWithPipeline [
	<gtExample>
	<return: #ByteString>
	^ GtWardleyMapScriptExamples new withPipelineCr
]

{ #category : #'examples - scripts' }
GtWardleyMapScriptImporterExamples >> scriptWithTwoPipelines [
	<gtExample>
	<return: #ByteString>
	^ GtWardleyMapScriptExamples new withTwoPipelinesCr
]
