Class {
	#name : #GtWardleyMapEvolutionAxisVisiblityMenuItem,
	#superclass : #Object,
	#traits : 'TGtWardleyMapContextMenuItem',
	#classTraits : 'TGtWardleyMapContextMenuItem classTrait',
	#category : #'GToolkit-WardleyMap-Helpers - Context Menu'
}

{ #category : #converting }
GtWardleyMapEvolutionAxisVisiblityMenuItem >> createElementUsingContext: aContextMenuItem [
	<return: #BlElement or: nil>
	^ GtWardleyMapEvolutionAxisVisibilityCheckbox new
		wardleyMapViewModel: aContextMenuItem wardleyMapViewModel
]

{ #category : #'gt - extensions' }
GtWardleyMapEvolutionAxisVisiblityMenuItem >> gtItemName [
	^ 'Evolution axis visibility checker'
]
