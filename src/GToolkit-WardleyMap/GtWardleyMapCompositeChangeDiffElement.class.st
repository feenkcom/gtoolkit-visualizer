Class {
	#name : #GtWardleyMapCompositeChangeDiffElement,
	#superclass : #GtUserActivatableChangeWithExpanderElement,
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #'as yet unclassified' }
GtWardleyMapCompositeChangeDiffElement >> contentElement [
	^ GtWardleyMapElement new
		wardleyMapViewModel: (GtWardleyMapViewModel new
				wardleyMapModel: self activatableChange change highlightedModificationsInPreview);
		height: 300;
		yourself
]

{ #category : #'as yet unclassified' }
GtWardleyMapCompositeChangeDiffElement >> showChangeDiff [
	^ true
]
