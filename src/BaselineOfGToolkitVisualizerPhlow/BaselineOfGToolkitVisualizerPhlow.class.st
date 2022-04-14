"
1. VisualizerPhlow
I am a utility component that provides Phlow (see {{gtClass:BaselineOfGToolkitPhlow}} extensions that include visualizations (see {{gtClass:BaselineOfGToolkitVisualizer}}.


"
Class {
	#name : #BaselineOfGToolkitVisualizerPhlow,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitVisualizerPhlow
}

{ #category : #baseline }
BaselineOfGToolkitVisualizerPhlow >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GToolkitPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-phlow:v0.8.591/src' ].
		spec
			baseline: 'GToolkitVisualizer' with: [
				spec repository: 'github://feenkcom/gtoolkit-visualizer:v0.8.633/src' ].

		spec package: 'GToolkit-Mondrian-Phlow' with: [
			spec requires: #('GToolkitPhlow' 'GToolkitVisualizer') ].
	]
]
