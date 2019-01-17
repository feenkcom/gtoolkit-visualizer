Class {
	#name : #GtGradHierarchicalLayoutCurrentComponentSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'theCurrentComponent'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical-Signals'
}

{ #category : #accessing }
GtGradHierarchicalLayoutCurrentComponentSignal >> theCurrentComponent [
	^ theCurrentComponent
]

{ #category : #accessing }
GtGradHierarchicalLayoutCurrentComponentSignal >> theCurrentComponent: anObject [
	theCurrentComponent := anObject
]
