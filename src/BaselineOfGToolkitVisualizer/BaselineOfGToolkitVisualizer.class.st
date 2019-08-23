"
!Visualizer

Visualization is a first class citizen in Glamorous Toolkit. 

Currently, the projects contains:
- Mondrian, an engine that offers a fluent API for scripting graph-based visualizations.
- Connector, an engine that allows you to create a visual way to navigate graphs.

!!Mondrian

Mondrian is an engine for scripting graph-based visualization like this one:

${example:GtMondrianClassHierarcyExamples>>#classHierarchyHorizontalTreeWithClassNames|previewExpanded=|noCode=|previewShow=gtLiveFor:|previewHeight=250}$

Learn more about it: ${class:GtMondrianBasicExamples}$, and ${class:GtMondrianDomainExamples}$.


!!Connector

Connector is an engine for scripting a visual exploration of a graph. For example, below we can see an instantiation of the engine for navigating examples. Just click on the dots.

${example:GtConnectorExamples>>#exampleMethodsExample|noCode|previewShow=gtLiveFor:|previewHeight=300}$



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
				spec repository: 'github://feenkcom/Brick:v0.7.45/src' ];
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:0ba3c998da3849e6d1d00a6245699cd795d3bd65/repository' ].
		spec 
			package: 'GToolkit-BlocGraph' with: [
				spec requires: #(#Brick ). ];
			package: 'GToolkit-BlocGraph-Grad' with: [
				spec requires: #('GToolkit-BlocGraph' ). ];
			package: 'GToolkit-BlocGraph-Layouts' with: [
				spec requires: #('GToolkit-BlocGraph' ). ];
			package: 'GToolkit-Mondrian' with: [
				spec requires: #(#Brick 'GToolkit-BlocGraph' 'GToolkit-BlocGraph-Layouts' 'Beacon' ). ];
			package: 'GToolkit-Mondrian-Glamour' with: [
				spec requires: #('GToolkit-Mondrian' ). ];
			package: 'GToolkit-Connector' with: [
				spec requires: #(#Brick 'GToolkit-BlocGraph' 'GToolkit-BlocGraph-Layouts' ). ];
			package: 'GToolkit-Diagrammer' with: [
				spec requires: #(#Brick ). ];
			package: 'GToolkit-TreeMap' with: [
				spec requires: #(#Brick ). ];
			package: 'GToolkit-Plotter' with: [
				spec requires: #(#Brick ). ]. ].

]
