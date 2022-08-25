"
1. Visualizer
Visualization is a first class citizen in Glamorous Toolkit. 

Currently, the projects contains:
- Mondrian, a fluent API for scripting graph-based visualizations.
- TreeMap, for building circular and rectangular treemaps.
- Plotter, a collection of builders of charts like bar charts or timelines. 
- Connector, an engine that allows you to create a visual way to navigate graphs.
1. # Mondrian

Mondrian is an engine for scripting graph-based visualization like this one:

{{gtExample:GtMondrianClassHierarchyExamples>>#classHierarchyHorizontalTreeWithClassNames|previewExpanded=|noCode=|previewShow=gtLiveFor:|previewHeight=250}}

Learn more about it: {{gtClass:GtMondrianBasicExamples}},  {{gtClass:GtMondrianClassHierarchyExamples}}, and {{gtClass:GtMondrianDomainExamples}} .
1. # Connector

Connector is an engine for scripting a visual exploration of a graph. For example, below we can see an instantiation of the engine for navigating examples. Just click on the dots.

{{gtExample:GtConnectorExamples>>#exampleMethodsExample|noCode|previewShow=gtLiveFor:|previewHeight=300}}



"
Class {
	#name : #BaselineOfGToolkitVisualizer,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitVisualizer
}

{ #category : #accessing }
BaselineOfGToolkitVisualizer class >> itself [
	<gtExample>
	^ self
]

{ #category : #baseline }
BaselineOfGToolkitVisualizer >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.8.664/src' ].
		spec
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:b80a3d2fcd2640b288d7fc4cd557d99085a370e6/repository' ].

		spec package: 'GToolkit-BlocGraph' with: [
			spec requires: #('Brick') ].
		spec package: 'GToolkit-BlocGraph-Grad' with: [
			spec requires: #('GToolkit-BlocGraph') ].
		spec package: 'GToolkit-BlocGraph-Layouts' with: [
			spec requires: #('GToolkit-BlocGraph') ].
		spec package: 'GToolkit-Mondrian' with: [
			spec requires: #('Brick' 'GToolkit-BlocGraph' 'GToolkit-BlocGraph-Layouts' 'Beacon') ].
		spec package: 'GToolkit-Mondrian-Glamour' with: [
			spec requires: #('GToolkit-Mondrian') ].
		spec package: 'GToolkit-Connector' with: [
			spec requires: #('Brick' 'GToolkit-BlocGraph' 'GToolkit-BlocGraph-Layouts') ].
		spec package: 'GToolkit-Diagrammer' with: [
			spec requires: #('Brick') ].
		spec package: 'GToolkit-TreeMap' with: [
			spec requires: #('Brick') ].
		spec package: 'GToolkit-Plotter' with: [
			spec requires: #('Brick') ].
		spec package: 'GToolkit-WardleyMap' with: [
			spec requires: #('Brick') ].
		spec package: 'GToolkit-SequenceDiagram' with: [
			spec requires: #('Brick') ].
	]
]
