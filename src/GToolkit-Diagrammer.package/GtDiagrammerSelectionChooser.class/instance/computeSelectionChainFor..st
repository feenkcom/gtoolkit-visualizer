private
computeSelectionChainFor: anElement
	<return: #Collection of: #BlElement>
	| theParents |

	"first we have to collect all parents of the given element"
	theParents := Array streamContents: [ :aStream |
		aStream nextPut: anElement.
		anElement parentsDo: [ :aParentElement | aStream nextPut: aParentElement ] ].

	"then select only those ones that are parents of the element marked as selection leaf (cutting point).
	Note: selection leaf is included in the chain, however selection can not `dive-in` in the leaf"
	theParents := (Array streamContents: [ :aStream |
		| aCurrentParent anIndex |
		anIndex := theParents size.

		[ anIndex > 0 and: [ (aCurrentParent := theParents at: anIndex) isDiagrammerSelectionLeaf not ] ] whileTrue: [
			aStream nextPut: aCurrentParent.
			anIndex := anIndex - 1 ].

		aCurrentParent isDiagrammerSelectionLeaf
			ifTrue: [ aStream nextPut: aCurrentParent ] ]) reversed.
		
	^ theParents