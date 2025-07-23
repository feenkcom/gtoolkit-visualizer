Class {
	#name : #GtWardleyMapNoteModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'instance creation' }
GtWardleyMapNoteModelExamples >> newNote [
	<gtExample>
	<return: #GtWardleyMapNoteModel>
	| aWardleyNote |
	aWardleyNote := GtWardleyMapNoteModel new.
	self assert: aWardleyNote label equals: 'Note'.
	self assert: aWardleyNote coordinate equals: 0.5 @ 0.5.
	self assert: aWardleyNote color equals: GtWardleyMapConstants nodeColor.

	^ aWardleyNote
]
