Extension { #name : #BlLayoutCommonConstraints }

{ #category : #'*GToolkit-BlocGraph-Layouts' }
BlLayoutCommonConstraints >> graph [
	^ self at: GtGraphLayout
]

{ #category : #'*GToolkit-BlocGraph-Layouts' }
BlLayoutCommonConstraints >> treemap [
	^ self at: GtGraphTreemapLayout
]
