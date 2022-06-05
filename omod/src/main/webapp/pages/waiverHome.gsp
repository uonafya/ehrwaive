<%
    ui.decorateWith("kenyaemr", "standardPage", [ layout: "sidebar" ])
%>
<div class="ke-page-sidebar">
</div>
<div class="ke-page-content">
    ${ ui.includeFragment("ehrwaiver", "waiverList") }
</div>




