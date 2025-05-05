Class {
	#name : #GtWardleyMapNodePullDirectionExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #accessing }
GtWardleyMapNodePullDirectionExamples >> horizontalPullDirection_3_5 [
	<gtExample>
	<return: #'GtWardleyMapNodeHorizontalPullDirection class'>
	| aDirection |
	aDirection := GtWardleyMapNodePullDirection fromDragDelta: 3 @ 5.

	self assert: aDirection equals: GtWardleyMapNodeHorizontalPullDirection.

	^ aDirection
]

{ #category : #accessing }
GtWardleyMapNodePullDirectionExamples >> horizontalPullDirection_5_m1 [
	<gtExample>
	<return: #'GtWardleyMapNodeHorizontalPullDirection class'>
	| aDirection |
	aDirection := GtWardleyMapNodePullDirection fromDragDelta: 5 @ -1.

	self assert: aDirection equals: GtWardleyMapNodeHorizontalPullDirection.

	^ aDirection
]

{ #category : #accessing }
GtWardleyMapNodePullDirectionExamples >> verticalPullDirection_10_10 [
	<gtExample>
	<return: #'GtWardleyMapNodeVerticalPullDirection class'>
	| aDirection |
	aDirection := GtWardleyMapNodePullDirection fromDragDelta: 10 @ 10.

	self assert: aDirection equals: GtWardleyMapNodeVerticalPullDirection.

	^ aDirection
]

{ #category : #accessing }
GtWardleyMapNodePullDirectionExamples >> verticalPullDirection_6_m10 [
	<gtExample>
	<return: #'GtWardleyMapNodeVerticalPullDirection class'>
	| aDirection |
	aDirection := GtWardleyMapNodePullDirection fromDragDelta: 6 @ -10.

	self assert: aDirection equals: GtWardleyMapNodeVerticalPullDirection.

	^ aDirection
]
