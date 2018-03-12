event handling
onEditorChanged: anAnnouncement
	| anEditor anEditorIndex |
	
	anEditor := anAnnouncement editor.
	anEditorIndex := self editors
		indexOf: anEditor
		ifAbsent: [ ^ self ].

	self notifyItemsChanged: (anEditorIndex to: anEditorIndex)