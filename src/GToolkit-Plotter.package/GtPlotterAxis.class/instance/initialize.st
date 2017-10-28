initialization
initialize
	super initialize.
	
	name := 'Axis'.
	scale := GtPlotterIdentityScale new.
	projections := GtPlotterAxisProjections on: self.