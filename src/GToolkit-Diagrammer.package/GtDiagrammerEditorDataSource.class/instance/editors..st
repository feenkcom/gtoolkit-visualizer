accessing
editors: aCollectionOfEditors
	editors := aCollectionOfEditors.
	editors do: [ :anEditor | anEditor changedSend: #onEditorChanged: to: self ].
	
	self notifyChanged