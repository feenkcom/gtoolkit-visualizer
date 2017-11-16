private
findExampleSendsIn: anAST
	^ anAST allChildren select: [ :each | 
		each isMessage and: [ 
			each isSelfSend and: [ 
				each isUnary and: [
					(anAST methodNode methodClass canPerform: each selector) and: [ 
						(anAST methodNode methodClass lookupSelector: each selector) isGTExampleMethod ] ] ] ] ]