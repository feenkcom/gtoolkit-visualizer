"
!VisualizerPhlow

I am a utility component that provides Phlow (see ${class:BaselineOfGToolkitPhlow}$ extensions that include visualizations (see ${class:BaselineOfGToolkitVisualizer}$.
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
				spec repository: 'github://feenkcom/gtoolkit-phlow:v0.7.210/src' ];
			baseline: 'GToolkitVisualizer' with: [
				spec repository: 'github://feenkcom/gtoolkit-visualizer:v0.7.218/src' ].
		spec package: 'GToolkit-Mondrian-Phlow' with: [
				spec requires: #(#GToolkitPhlow #GToolkitVisualizer ). ]. ].

]
