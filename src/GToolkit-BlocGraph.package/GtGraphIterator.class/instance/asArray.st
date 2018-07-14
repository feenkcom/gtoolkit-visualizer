api - converting
asArray
	"Return a collection of all items enumerable by this iterator"
	<return: #Array of: #Object>

	^ Array streamContents: [ :aStream | self do: [ :anObject | aStream nextPut: anObject ] ]