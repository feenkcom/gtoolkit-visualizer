api - geometry
maxHeight
	"Return the maximum height of my direct children nodes"
	<return: #Number>
	
	^ self nodes
		ifEmpty: [ 0 ]
		ifNotEmpty: [ (self nodes detectMax: [ :aTreeNode | aTreeNode height ]) height ]