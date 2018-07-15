api - geometry
nodeOffsetLength: aNodeElement
	"Return the length of the offset of the given node element"
	<return: #Number>

	^ aNodeElement constraints gradTree computedOffset y
