Class {
	#name : #GtPlotterHorizontalBarChartBuilderExamples,
	#superclass : #GtPlotterBuilderExamples,
	#category : #'GToolkit-Plotter-Examples'
}

{ #category : #'as yet unclassified' }
GtPlotterHorizontalBarChartBuilderExamples >> barChart [
	<gtExample>
	| aPlotter barChart |

	aPlotter := GtPlotter new.

	barChart := aPlotter horizontalBarChart.
	barChart barStencil: [
		BlElement new
			geometry: BlStadium new;
			margin: (BlInsets top: 4 bottom: 4);
			background: (Color gray alpha: 0.5)].
	barChart barWidthScale: (GtPlotterDurationScale new domainFrom: 0 minutes to: 20 minutes).
	barChart barHeightScale: (GtPlotterLinearScale new
		domainFrom: 0 to: (self websiteVisits max: #third);
		rangeFrom: 10 to: 50).
	barChart ticks: 2.
	barChart barLabelFormat: [ :eachDataItem | eachDataItem first ].
	barChart barWidthData: [ :eachDataItem | eachDataItem second ].
	barChart barHeightData: [ :eachDataItem | eachDataItem third ].
	barChart with: self websiteVisits.

	^ aPlotter
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilderExamples >> websiteVisits [
	^ { 
		{ 'Google.com'. (Duration days: 0 hours: 0 minutes: 12 seconds: 09). 14.66 }.
		{ 'Youtube.com'. (Duration days: 0 hours: 0 minutes: 11 seconds: 40). 6.67 }.
		{ 'Tmall.com'. (Duration days: 0 hours: 0 minutes: 6 seconds: 57). 2.91 }.
		{ 'Facebook.com'. (Duration days: 0 hours: 0 minutes: 17 seconds: 52). 7.85 }.
		{ 'Baidu.com'. (Duration days: 0 hours: 0 minutes: 7 seconds: 00). 4.54 }.
		{ 'Qq.com'. (Duration days: 0 hours: 0 minutes: 3 seconds: 49). 4.00 }.
		{ 'Sohu.com'. (Duration days: 0 hours: 0 minutes: 3 seconds: 47). 4.55 }.
		{ 'Taobao.com'. (Duration days: 0 hours: 0 minutes: 4 seconds: 48). 3.54 }.
		{ 'Login.tmall.com'. (Duration days: 0 hours: 0 minutes: 5 seconds: 12). 1.00 }.
		{ 'Yahoo.com'. (Duration days: 0 hours: 0 minutes: 4 seconds: 34). 4.40 }.
		{ '360.cn'. (Duration days: 0 hours: 0 minutes: 3 seconds: 21). 3.96 }.
		{ 'Jd.com'. (Duration days: 0 hours: 0 minutes: 3 seconds: 41). 4.53 }.
		{ 'Amazon.com'. (Duration days: 0 hours: 0 minutes: 9 seconds: 42). 9.04 }.
		{ 'Wikipedia.org'. (Duration days: 0 hours: 0 minutes: 3 seconds: 55). 2.96 }.
		{ 'Weibo.com'. (Duration days: 0 hours: 0 minutes: 3 seconds: 10). 3.75 }.
		{ 'Sina.com.cn'. (Duration days: 0 hours: 0 minutes: 2 seconds: 58). 3.51 }.
		{ 'Pages.tmall.com'. (Duration days: 0 hours: 0 minutes: 1 seconds: 16). 1.48 }.
		{ 'Reddit.com'. (Duration days: 0 hours: 0 minutes: 7 seconds: 58). 5.66 }.
		{ 'Live.com'. (Duration days: 0 hours: 0 minutes: 4 seconds: 53). 4.97 }.
		{ 'Netflix.com'. (Duration days: 0 hours: 0 minutes: 3 seconds: 15). 2.65 }.
		{ 'Okezone.com'. (Duration days: 0 hours: 0 minutes: 5 seconds: 08). 4.34 }.
		{ 'Vk.com'. (Duration days: 0 hours: 0 minutes: 7 seconds: 51). 4.03 }.
		{ 'Alipay.com'. (Duration days: 0 hours: 0 minutes: 2 seconds: 41). 3.18 }.
		{ 'Blogspot.com'. (Duration days: 0 hours: 0 minutes: 3 seconds: 32). 2.70 }.
		{ 'Csdn.net'. (Duration days: 0 hours: 0 minutes: 3 seconds: 33). 4.99 }.
		{ 'Xinhuanet.com'. (Duration days: 0 hours: 0 minutes: 2 seconds: 49). 5.19 }.
		{ 'Instagram.com'. (Duration days: 0 hours: 0 minutes: 7 seconds: 08). 6.79 }.
		{ 'Bongacams.com'. (Duration days: 0 hours: 0 minutes: 3 seconds: 06). 1.66 }.
		{ 'Livejasmin.com'. (Duration days: 0 hours: 0 minutes: 2 seconds: 22). 1.55 }.
		{ 'Yahoo.co.jp'. (Duration days: 0 hours: 0 minutes: 8 seconds: 26). 7.46 }.
		{ 'Bing.com'. (Duration days: 0 hours: 0 minutes: 3 seconds: 01). 3.04 }.
		{ 'Office.com'. (Duration days: 0 hours: 0 minutes: 7 seconds: 04). 6.70 }.
		{ 'Aliexpress.com'. (Duration days: 0 hours: 0 minutes: 12 seconds: 24). 9.03 }.
		{ 'Google.com.hk'. (Duration days: 0 hours: 0 minutes: 3 seconds: 21). 5.02 }.
		{ 'Babytree.com'. (Duration days: 0 hours: 0 minutes: 2 seconds: 39). 4.98 }.
		{ 'Microsoft.com'. (Duration days: 0 hours: 0 minutes: 3 seconds: 25). 3.13 }.
		{ 'Twitter.com'. (Duration days: 0 hours: 0 minutes: 10 seconds: 44). 7.77 }.
		{ 'Ebay.com'. (Duration days: 0 hours: 0 minutes: 9 seconds: 54). 7.23 }.
		{ 'Twitch.tv'. (Duration days: 0 hours: 0 minutes: 5 seconds: 33). 3.00 }.
		{ 'Naver.com'. (Duration days: 0 hours: 0 minutes: 14 seconds: 30). 10.30 }.
		{ 'Stackoverflow.com'. (Duration days: 0 hours: 0 minutes: 5 seconds: 56). 3.80 }.
		{ 'Amazon.co.jp'. (Duration days: 0 hours: 0 minutes: 7 seconds: 32). 9.52 }.
		{ 'Google.co.in'. (Duration days: 0 hours: 0 minutes: 5 seconds: 41). 9.22 }.
		{ 'Tianya.cn'. (Duration days: 0 hours: 0 minutes: 2 seconds: 59). 5.11 }.
		{ 'Tribunnews.com'. (Duration days: 0 hours: 0 minutes: 3 seconds: 38). 1.94 }.
		{ 'Pornhub.com'. (Duration days: 0 hours: 0 minutes: 10 seconds: 03). 3.40 }.
		{ 'Panda.tv'. (Duration days: 0 hours: 0 minutes: 2 seconds: 47). 5.15 }.
		{ 'Apple.com'. (Duration days: 0 hours: 0 minutes: 3 seconds: 42). 3.69 }.
		{ 'Amazon.in'. (Duration days: 0 hours: 0 minutes: 11 seconds: 42). 9.64 }.
		{ 'Zhanqi.tv'. (Duration days: 0 hours: 0 minutes: 2 seconds: 49). 5.19 }.
	}
]
