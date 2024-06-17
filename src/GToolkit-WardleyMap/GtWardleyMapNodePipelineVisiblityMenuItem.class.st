Class {
	#name : #GtWardleyMapNodePipelineVisiblityMenuItem,
	#superclass : #Object,
	#traits : 'TGtWardleyMapContextMenuItem',
	#classTraits : 'TGtWardleyMapContextMenuItem classTrait',
	#category : #'GToolkit-WardleyMap-Helpers - Context Menu'
}

{ #category : #converting }
GtWardleyMapNodePipelineVisiblityMenuItem >> createElementUsingContext: aContextMenuItem [
	<return: #BlElement or: nil>
	^ GtWardleyMapPipelineVisibilityCheckbox new
		wardleyMapNodeViewModel: aContextMenuItem wardleyMapNodeViewModel
]
