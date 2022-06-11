<%
    ui.decorateWith("kenyaemr", "standardPage", [ layout: "sidebar" ])
    ui.includeJavascript("ehrconfigs", "datatables/jquery.dataTables.min.js")
    ui.includeCss("ehrconfigs", "jquery.dataTables.min.css")

%>
<div class="ke-page-sidebar">
</div>
<div class="ke-page-content">
    ${ ui.includeFragment("ehrwaiver", "waiverList") }
</div>
