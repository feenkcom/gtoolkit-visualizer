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
				spec repository: 'github://feenkcom/Brick:v0.8.1654/src' ].
		spec
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:791ef3c1ef13abff0d9f035cc5a9ec3f5342a668/repository' ].
		spec
			baseline: 'GToolkit4SmaCC' with: [
				spec repository: 'github://feenkcom/gt4smacc:v0.8.595/src' ].
		spec
			baseline: 'GToolkitAnnouncerUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.389/src' ].
		spec
			baseline: 'GToolkitPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-phlow:v0.8.1803/src' ].
		spec
			baseline: 'GToolkit4Pharo' with: [
				spec repository: 'github://feenkcom/gt4pharo:v0.6.2391/src' ].
		spec
			baseline: 'GToolkitPresenter' with: [
				spec repository: 'github://feenkcom/gtoolkit-presenter:v0.8.2520/src' ].
		spec
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.8.2261/src' ].

		spec package: 'GToolkit-BlocGraph' with: [
			spec requires: #(#Brick) ].
		spec package: 'GToolkit-BlocGraph-Grad' with: [
			spec requires: #(#'GToolkit-BlocGraph') ].
		spec package: 'GToolkit-BlocGraph-Layouts' with: [
			spec requires: #(#'GToolkit-BlocGraph') ].
		spec package: 'GToolkit-Mondrian' with: [
			spec requires: #(#Brick #'GToolkit-BlocGraph' #'GToolkit-BlocGraph-Layouts' #'GToolkit-BlocGraph-Grad' #Beacon #GToolkitPhlow #GToolkit4Pharo) ].
		spec package: 'GToolkit-Mondrian-Glamour' with: [
			spec requires: #(#'GToolkit-Mondrian') ].
		spec package: 'GToolkit-Connector' with: [
			spec requires: #(#Brick #'GToolkit-BlocGraph' #'GToolkit-BlocGraph-Layouts' #'GToolkit-BlocGraph-Grad' #GToolkitPhlow #GToolkitPresenter) ].
		spec package: 'GToolkit-Diagrammer' with: [
			spec requires: #(#Brick) ].
		spec package: 'GToolkit-TreeMap' with: [
			spec requires: #(#Brick #'GToolkit-BlocGraph-Layouts') ].
		spec package: 'GToolkit-Plotter' with: [
			spec requires: #(#Brick) ].
		spec package: 'GToolkit-WardleyMap' with: [
			spec requires: #(#Brick #GToolkit4SmaCC #GToolkitAnnouncerUtility #GToolkitCoder) ].
		spec package: 'GToolkit-SequenceDiagram' with: [
			spec requires: #(#Brick #GToolkitAnnouncerUtility) ].
	]
]
