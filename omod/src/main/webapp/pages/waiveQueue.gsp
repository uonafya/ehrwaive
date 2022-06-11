<%
	ui.decorateWith("kenyaemr", "standardPage")
	ui.includeCss("ehrconfigs", "jquery.dataTables.min.css")
	ui.includeCss("ehrconfigs", "onepcssgrid.css")
	ui.includeJavascript("ehrconfigs", "moment.js")
	ui.includeJavascript("ehrconfigs", "jquery.dataTables.min.js")
	ui.includeJavascript("ehrconfigs", "jq.browser.select.js")
	ui.includeJavascript("ehrconfigs", "knockout-3.4.0.js")
	ui.includeJavascript("ehrconfigs", "jquery-ui-1.9.2.custom.min.js")
	ui.includeJavascript("ehrconfigs", "underscore-min.js")
	ui.includeJavascript("ehrconfigs", "emr.js")
	ui.includeCss("ehrconfigs", "jquery-ui-1.9.2.custom.min.css")
	// toastmessage plugin: https://github.com/akquinet/jquery-toastmessage-plugin/wiki
	ui.includeJavascript("ehrconfigs", "jquery.toastmessage.js")
	ui.includeCss("ehrconfigs", "jquery.toastmessage.css")
	// simplemodal plugin: http://www.ericmmartin.com/projects/simplemodal/
	ui.includeJavascript("ehrconfigs", "jquery.simplemodal.1.4.4.min.js")
	ui.includeCss("ehrconfigs", "referenceapplication.css")
	def props = ["identifier", "fullname", "age", "gender", "action"]
	def ipdprops = ["patientIdentifier", "patientName", "gender", "action"]
%>
<head>
    <style>
		body {
			margin-top: 20px;
		}
		.col1, .col2, .col3, .col4, .col5, .col6, .col7, .col8, .col9, .col10, .col11, .col12 {
			color: #555;
			text-align: left;
		}
		form input,
		form select {
			margin: 0px;
			display: inline-block;
			min-width: 50px;
			padding: 2px 10px;
			height: 32px !important;
		}
		.info-header span {
			cursor: pointer;
			display: inline-block;
			float: right;
			margin-top: -2px;
			padding-right: 5px;
		}
		.dashboard .info-section {
			margin: 2px 5px 5px;
		}
		.toast-item {
			background-color: #222;
		}
		@media all and (max-width: 768px) {
			.onerow {
				margin: 0 0 100px;
			}
		}
		form .advanced {
			background: #363463 none repeat scroll 0 0;
			border-color: #dddddd;
			border-style: solid;
			border-width: 1px;
			color: #fff;
			cursor: pointer;
			float: right;
			padding: 6px 0;
			text-align: center;
			width: 27%;
		}
		form .advanced i {
			font-size: 22px;
		}
		.col4 label {
			width: 110px;
			display: inline-block;
		}
		.col4 input[type=text] {
			display: inline-block;
			padding: 4px 10px;
		}
		.col4 select {
			padding: 4px 10px;
		}
		form select {
			min-width: 50px;
			display: inline-block;
		}

		.identifiers span {
			border-radius: 50px;
			color: white;
			display: inline;
			font-size: 0.8em;
			letter-spacing: 1px;
			margin: 5px;
		}
		table.dataTable thead th, table.dataTable thead td {
			padding: 5px 10px;
		}
		form input:focus {
			border: 1px solid #00f !important;
		}
		input[type="text"], select {
			border: 1px solid #aaa;
			border-radius: 2px !important;
			box-shadow: none !important;
			box-sizing: border-box !important;
			height: 32px;
		}
		.newdtp {
			width: 166px;
		}
		#lastDayOfVisit label {
			display: none;
		}
		#lastDayOfVisit input {
			width: 160px;
		}
		.add-on {
			color: #f26522;
			float: right;
			left: auto;
			margin-left: -29px;
			margin-top: 10px;
			position: absolute;
		}
		.chrome .add-on {
		  margin-left:-31px;
		  margin-top:-27px !important;
		  position:relative !important;
		}
		#lastDayOfVisit-wrapper .add-on{
			margin-top: 5px;
		}
		.ui-widget-content a {
			color: #007fff;
		}
		#breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
			text-decoration: none;
		}
		.new-patient-header .identifiers {
			margin-top: 5px;
		}
		.name {
			color: #f26522;
		}
		#inline-tabs {
			background: #f9f9f9 none repeat scroll 0 0;
		}
		.formfactor{
			background: #f3f3f3 none repeat scroll 0 0;
			border: 1px solid #ddd;
			margin-bottom: 5px;
			padding: 5px 10px;
			text-align: left;
			width: auto;
		}
		.formfactor .lone-col{
			display: inline-block;
			margin-top: 5px;
			overflow: hidden;
			width: 100%;
		}
		.formfactor .first-col{
			display: inline-block;
			margin-top: 5px;
			overflow: hidden;
			width: 300px;
		}
		.formfactor .second-col{
			display: inline-block;
			float: right;
			margin-top: 5px;
			overflow: hidden;
			width: 600px;
		}
		#datetime label{
			display: none;
		}
		.formfactor .lone-col input,
		.formfactor .first-col input,
		.formfactor .second-col input{
			margin-top: 5px;
			padding: 5px 15px;
			width: 100%;
		}
		.formfactor .lone-col label,
		.formfactor .first-col label,
		.formfactor .second-col label{
			padding-left: 5px;
			color: #363463;
			cursor: pointer;
		}
		.ui-tabs-panel h2{
			display: inline-block;
		}
		td a:hover{
			text-decoration: none;
		}
		#modal-overlay {
			background: #000 none repeat scroll 0 0;
			opacity: 0.4 !important;
		}
    </style>
</head>

<body>
	<div class="clear"></div>
	<div class="container">
		<div class="example">
			<ul id="breadcrumbs">


				<li>
					<i class="icon-chevron-right link"></i>
					<a>Waive UI</a>
				</li>

				<li>
					<i class="icon-chevron-right link"></i>
					Patient Waiver Portal
				</li>
			</ul>
		</div>
		<div class="patient-header new-patient-header">

			<div id="tabs" style="margin-top: 40px!important;">

				<div id="tabs-1">
					<h2 style="display: inline-block;">Waive Patient Queue</h2>

                    <div class="ke-page-content">
                        ${ ui.includeFragment("ehrwaiver", "waiverList") }
                    </div>


                </div>

			</div>
		</div>
	</div>



