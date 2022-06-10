<div class="ke-panel-frame">
    <div class="ke-panel-heading">Patients to be waived</div>
    <div class="ke-panel-content">
        <table style="text-align: center" border="0" cellpadding="0" cellspacing="0" id="details" width="100%">
            <thead>
            <tr>
                <th>Patient Identifier</th>
                <th>Patient Names</th>
                <th>Sex</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% if (waiverList.empty) { %>
            <tr>
                <td colspan="10">
                    No records to show
                </td>
            </tr>
            <% } %>
            <% if (waiverList) { %>
            <% waiverList.each {%>
            <tr>
                <td>${it.patient.id}</td>
                <td>${it.name}</td>
                <td>${it.gender}</td>
                <td>${it.status}</td>
                <td>
                    <a id="editQueue" style="cursor:pointer;" onclick="javascript:window.location.href = 'waiverForm.page?patientId=${it.patient.id}'"/>Confirm Waiver</a>
                </td>
            </tr>
            <%}%>
            <%}%>
            </tbody>
        </table>
    </div>
</div>