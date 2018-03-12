initialization
initialize
	super initialize.
	
	self margin: (BlInsets top: 0 left: 0 bottom: 20 right: 0).
	self padding: (BlInsets all: 5).
	self layout: BlLinearLayout vertical.

	titleElement := BlTextElement new.
	titleElement margin: (BlInsets top: 5 right: 5 bottom: 0 left: 5). 
	self addChildFirst: titleElement as: #title.
	
	contentElement := BlElement new.
	self content: contentElement