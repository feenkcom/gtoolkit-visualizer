accessing
toggleFor: aModel ifFound: aBlockClosure
	self viewModel toggles
		detect: [ :aToggleModel | aToggleModel model = aModel  ]
		ifFound: aBlockClosure