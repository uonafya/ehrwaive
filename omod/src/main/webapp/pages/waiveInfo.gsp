<%
    ui.decorateWith("kenyaemr", "standardPage")
    ui.includeCss("ehrcashier", "paging.css")

    ui.includeJavascript("ehrcashier", "moment.js")
    ui.includeJavascript("ehrcashier", "paging.js")
    ui.includeJavascript("ehrcashier", "common.js")
    ui.includeJavascript("ehrcashier", "jq.print.js")
    ui.includeJavascript("ehrconfigs", "knockout-3.4.0.js")
    ui.includeJavascript("ehrconfigs", "jquery-ui-1.9.2.custom.min.js")
    ui.includeJavascript("ehrconfigs", "emr.js")
    ui.includeJavascript("ehrconfigs", "jquery.simplemodal.1.4.4.min.js")

    ui.includeCss("ehrconfigs", "jquery-ui-1.9.2.custom.min.css")
    ui.includeCss("ehrconfigs", "referenceapplication.css")

    def props = ["sno", "service", "select", "quantity", "pay", "unitprice", "itemtotal"]
%>

<script type="text/javascript">
    jq(document).ready(function () {
        function strReplace(word) {
            var res = word.replace("[", "");
            res = res.replace("]", "");
            return res;
        }
        jq(".compute").on("click", function () {
                    console.log("Compute clicked!");
                    let totalUnitPrice = 0;
                    let totalWaivedAmount = 0;
                    let totalBalance = 0;
                    jq("tr.item").each(function (){
                        const unitPrice = jq(this).find("td.unitprice").text();
                        const amountWaived = jq(this).find("input.amountwaived").val();
                        if (parseFloat(unitPrice) >= parseFloat(amountWaived)){
                            let bal = unitPrice-amountWaived;
                            totalUnitPrice += parseFloat(unitPrice);
                            totalWaivedAmount += parseFloat(amountWaived);
                            jq(this).find("td.total").text(bal);
                        } else {
                            totalUnitPrice += parseFloat(unitPrice);
                            totalWaivedAmount += 0;
                            jq(this).find("input.amountwaived").val("0.00");
                            jq(this).find("td.total").text(unitPrice);
                        }
                    });
                    jq("#total-unit-price").text(totalUnitPrice);
                    jq("#total-waived-amount").text(totalWaivedAmount);
                    totalBalance = totalUnitPrice - totalWaivedAmount;
                    jq("#total-balance").text(totalBalance);
                });
        jq('#surname').html(strReplace('${patient.names.familyName}') + ',<em>surname</em>');
        jq('#othname').html(strReplace('${patient.names.givenName}') + ' &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <em>other names</em>');
        jq('#agename').html('${patient.age} years (' + moment('${patient.birthdate}').format('DD,MMM YYYY') + ')');

        jq(function () {
            var additionalInfoDialog = emr.setupConfirmationDialog({
                dialogOpts: {
                    overlayClose: false,
                    close: true
                },
                selector: '#additional-info',
                actions: {
                    confirm: function () {
                        // TODO Verify data

                        // TODO call post method to save the additional info

                        //for now, we just close the dialog
                        additionalInfoDialog.close();
                    },
                    cancel: function () {
                        additionalInfoDialog.close();
                    }
                }
            });
            jq("#waive-confirm").on("click", function (e) {
                e.preventDefault();
                additionalInfoDialog.show();
            });
        });
    });


</script>

<style>
.name {
    color: #f26522;
}

.form-textbox {
    height: 12px !important;
    font-size: 12px !important;
}

.hidden {
    display: none;
}

.retired {
    text-decoration: line-through;
    color: darkgrey;
}

/*#breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
    text-decoration: none;
}
*/
.new-patient-header .demographics .gender-age {
    font-size: 14px;
    margin-left: -55px;
    margin-top: 12px;
}

.new-patient-header .demographics .gender-age span {
    border-bottom: 1px none #ddd;
}

.new-patient-header .identifiers {
    margin-top: 5px;
}

.tag {
    padding: 2px 10px;
}

.tad {
    background: #666 none repeat scroll 0 0;
    border-radius: 1px;
    color: white;
    display: inline;
    font-size: 0.8em;
    margin-left: 4px;
    padding: 2px 10px;
}

.status-container {
    padding: 5px 10px 5px 5px;
}

.catg {
    color: #363463;
    margin: 35px 10px 0 0;
}

@media print {
    .donotprint {
        display: none;
    }

    .spacer {
        margin-top: 70px;
        font-family: "Dot Matrix Normal", Arial, Helvetica, sans-serif;
        font-style: normal;
        font-size: 14px;
    }

    .printfont {
        font-family: "Dot Matrix Normal", Arial, Helvetica, sans-serif;
        font-style: normal;
        font-size: 14px;
    }
}

.formfactor {
    background: #f3f3f3 none repeat scroll 0 0;
    border: 1px solid #ddd;
    margin-bottom: 5px;
    margin-top: 5px;
    min-height: 38px;
    padding: 5px 10px;
    text-align: left;
    width: auto;
}

.dashboard .info-section {
    margin: 0;
    padding-bottom: 10px;
    padding-top: 10px;
    width: 100%;
}

.print-only {
    display: none;
}

.form-content{
    margin-top:20px;
}

input[type=date], textarea{
    width:100%;
}

#additional-info{
    background-color:whitesmoke;
}

#legend-style{
    font-weight: bold;
}

label{
    margin-top: 20px;
}

fieldset{
    display: flex;
    flex-direction: column;
}

</style>

<div class="clear"></div>

<div class="container">
    <div class="example">
        <ul id="breadcrumbs">
            <li>
                <a href="${ui.pageLink('kenyaemr', 'userHome')}">
                <i class="icon-home small"></i></a>
            </li>
<li>
    <i class="icon-chevron-right link"></i>
    <a href="${ui.pageLink('ehrwaive', 'waiveHome')}">Patient Waiver Module</a>
</li>

<li>
    <i class="icon-chevron-right link"></i>
    Service Bills
</li>
</ul>
</div>

<div class="patient-header new-patient-header">
    <div class="demographics">
        <h1 class="name">
            <span id="surname">${patient.names.familyName},<em>surname</em></span>
            <span id="othname">${patient.names.givenName} &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<em>other names</em>
            </span>

            <span class="gender-age">
                <span>
                    ${patient.gender}
                </span>
                <span id="agename">${patient.age} years (15.Oct.1996)</span>

            </span>
        </h1>

        <br/>

        <div id="stacont" class="status-container">
            <span class="status active"></span>
            Visit Status
        </div>



    </div>

    <div class="identifiers">
        <em>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Patient ID</em>
        <span>${patient.getPatientIdentifier()}</span>
        <br>
    </div>

</div>
    <div>
        <table id="bill-amounts">
            <thead>
            <tr>
                <th style="width: 40px; text-align: center;">#</th>
                <th>Service Name</th>
                <th style="width: 90px">Unit Price</th>
                <th style="width:120px; text-align:right;">Amount Waived</th>
                <th style="width:120px; text-align:right;">Item Total</th>
                <th style="width:120px; text-align:right;">Action</th>
            </tr>
            </thead>

            <tbody id="datafield" data-bind="foreach: waiveItems, visible: waiveItems().length > 0">
            <% if (billedItems.empty) { %>
            <tr>
                <td colspan="10">
                    No services to show
                </td>
            </tr>
            <% } %>
            <% if (billedItems) { %>
            <% billedItems.each {%>
            <tr class="item">
                <td style="text-align: center;"><span class="nombre"></span></td>
                <td>${it.name}</td>
                <td class="unitprice">${it.amount}</td>
                <td><input type="text" class="amountwaived" value="0.00"></td>
                <td class="total"></td>
                <td><button class="compute">compute</button></td>
            </tr>
            <%}%>
            <%}%>
            </tbody>

            <tbody>

            <tr style="border: 1px solid #ddd;">
                <td style="text-align: center;"></td>
                <td><b>Totals: Kshs</b></td>
                <td id="total-unit-price">

                </td>
                <td id="total-waived-amount">

                </td>
                <td id="total-balance">

                </td>
                <td><button class="compute">compute</button></td>
            </tr>
            </tbody>

        </table>

        <div>
            <button id="waive-confirm" class="task">Confirm Waiver</button>
        </div>

        <div id="additional-info"  class="dialog" style="display:none;">
            <div class="dialog-header">
                <i class="icon-folder-open"></i>

                <h3>Additional Information</h3>
            </div>
            <div class="dialog-content">
                <form id="form-content" action="">
                    <fieldset>
                        <label for="">What is the patient's general appearance</label>

                        <textarea name="appearance" id="appearance" cols="10" rows="5"></textarea>

                        <label for="">Reasons for recommending waiver</label>

                        <textarea name="reasons" id="reasons" cols="30" rows="5"></textarea>

                        <label for="">Date</label>
                        <input type="date" name="datepicker" id="">
                    </fieldset>

                    <div class="onerow">
                        <button class="button confirm right">Confirm</button>
                        <button class="button cancel">Cancel</button>
                    </div>
                </form>
            </div>
        </div>


    </div>
</div>
