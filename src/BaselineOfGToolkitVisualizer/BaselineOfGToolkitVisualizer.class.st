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
				spec repository: 'github://feenkcom/Brick:main/src' ];
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon/repository' ];
			baseline: 'GToolkit4SmaCC' with: [
				spec repository: 'github://feenkcom/gt4smacc:main/src' ];
			baseline: 'GToolkitAnnouncerUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'GToolkitPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-phlow:main/src' ];
			baseline: 'GToolkit4Pharo' with: [
				spec repository: 'github://feenkcom/gt4pharo:main/src' ];
			baseline: 'GToolkitPresenter' with: [
				spec repository: 'github://feenkcom/gtoolkit-presenter:main/src' ];
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:main/src' ].
				
		spec 
			package: 'GToolkit-BlocGraph' with: [
				spec requires: #('Brick' ). ];
			package: 'GToolkit-BlocGraph-Grad' with: [
				spec requires: #('GToolkit-BlocGraph' ). ];
			package: 'GToolkit-BlocGraph-Layouts' with: [
				spec requires: #('GToolkit-BlocGraph' ). ];
			package: 'GToolkit-Mondrian' with: [
				spec requires: #(
					'Brick' 
					'GToolkit-BlocGraph' 
					'GToolkit-BlocGraph-Layouts' 
					'GToolkit-BlocGraph-Grad' 
					'Beacon'
					'GToolkitPhlow'
					'GToolkit4Pharo' ). ];
			package: 'GToolkit-Mondrian-Glamour' with: [
				spec requires: #('GToolkit-Mondrian' ). ];
			package: 'GToolkit-Connector' with: [
				spec requires: #(
					'Brick' 
					'GToolkit-BlocGraph' 
					'GToolkit-BlocGraph-Layouts' 
					'GToolkit-BlocGraph-Grad'
					'GToolkitPhlow'
					'GToolkitPresenter' ). ];
			package: 'GToolkit-Diagrammer' with: [
				spec requires: #('Brick' ). ];
			package: 'GToolkit-TreeMap' with: [
				spec requires: #('Brick' 'GToolkit-BlocGraph-Layouts' ). ];
			package: 'GToolkit-Plotter' with: [
				spec requires: #('Brick' ). ];
			package: 'GToolkit-WardleyMap' with: [
				spec requires: #(
					'Brick' 
					'GToolkit4SmaCC' 
					'GToolkitAnnouncerUtility'
					'GToolkitCoder' ). ];
			package: 'GToolkit-SequenceDiagram' with: [
				spec requires: #('Brick' 'GToolkitAnnouncerUtility' ). ]. ].

]
