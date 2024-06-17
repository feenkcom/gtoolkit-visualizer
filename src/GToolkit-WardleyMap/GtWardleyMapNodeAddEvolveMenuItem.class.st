Class {
	#name : #GtWardleyMapNodeAddEvolveMenuItem,
	#superclass : #Object,
	#traits : 'TGtWardleyMapContextMenuItem',
	#classTraits : 'TGtWardleyMapContextMenuItem classTrait',
	#category : #'GToolkit-WardleyMap-Helpers - Context Menu'
}

{ #category : #converting }
GtWardleyMapNodeAddEvolveMenuItem >> createElementUsingContext: aContextMenuItem [
	<return: #BlElement or: nil>
	^ GtWardleyMapNodeAddEvolveButton new
		wardleyMapNodeViewModel: aContextMenuItem wardleyMapNodeViewModel
]
