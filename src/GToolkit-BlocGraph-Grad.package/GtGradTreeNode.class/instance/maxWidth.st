api - geometry
maxWidth
	"Return the maximum width of my direct children nodes"
	<return: #Number>
	
	^ self nodes
		ifEmpty: [ 0 ]
		ifNotEmpty: [ (self nodes detectMax: [ :aTreeNode | aTreeNode width ]) width ]