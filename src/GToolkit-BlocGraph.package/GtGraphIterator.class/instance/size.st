api - accessing
size
	"Return amount of items that can be returned by this iterator.
	Please note, I have to iterate over all items, so complexity is linear"
	<return: #Number>
	| aCounter |

	aCounter := 0.
	self do: [ :anObject | aCounter := aCounter + 1 ].
	^ aCounter