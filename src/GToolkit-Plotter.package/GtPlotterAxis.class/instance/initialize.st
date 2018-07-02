initialization
initialize
	super initialize.
	
	name := 'Axis'.
	scale := GtPlotterIdentityScale new.
	projections := GtPlotterAxisProjections on: self.
	minLimit := GtPlotterAxisAutoMinLimit new axis: self.
	maxLimit := GtPlotterAxisAutoMaxLimit new axis: self