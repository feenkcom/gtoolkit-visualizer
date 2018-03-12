api - script
from: anObjectOrBlock
	"Add all editors for an object as my sub-editors when condition meets"
	| aDeclaration |

	aDeclaration := self newDeclaration.
	aDeclaration condition: [ self meetsCondition ].
	aDeclaration editors: [ self class editorsOf: anObjectOrBlock value ].

	editorDeclarations add: aDeclaration