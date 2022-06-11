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

        jq('#surname').html(strReplace('${patient.names.familyName}') + ',<em>surname</em>');
        jq('#othname').html(strReplace('${patient.names.givenName}') + ' &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <em>other names</em>');
        jq('#agename').html('${patient.age} years (' + moment('${patient.birthdate}').format('DD,MMM YYYY') + ')');

        jq("#commentField").hide();
        jq("#okButton").hide();

        jq('#initialtotal').text(formatAccounting(jq('#initialtotal').text().trim()));
        jq("#totalValue2").html(toWords(jq("#total").val()));

        jq('.cancel').on('click', function () {
            jq("#commentField").toggle();
            jq("#okButton").toggle();
        });

        jq('.confirm').on('click', function () {
            jq("#printSection").print({
                globalStyles: false,
                mediaPrint: false,
                stylesheet: '${ui.resourceLink("pharmacyapp", "styles/print-out.css")}',
                iframe: false,
                width: 600,
                height: 700
            });
            jq("#billForm").submit();
        });


    });

    function validate() {
        if (StringUtils.isBlank(jQuery("#comment").val())) {
            alert("Please enter comment");
            return false;
        }
        else {

            var patientId = ${patient.patientId};
            var billType = "free";
            var comment = jQuery("#comment").val();
            window.location.href = emr.pageLink("ehrcashier", "addPatientServiceBillForBD", {
                "patientId": patientId,
                "billType": billType,
                "comment": comment
            });
        }
    }
    function formatAccounting(nStr) {
        nStr = parseFloat(nStr).toFixed(2);
        nStr += '';
        x = nStr.split('.');
        x1 = x[0];
        x2 = x.length > 1 ? '.' + x[1] : '';
        var rgx = /(\\d+)(\\d{3})/;
        while (rgx.test(x1)) {
            x1 = x1.replace(rgx, '\$1' + ',' + '\$2');
        }
        return x1 + x2;
    }

    function stringReplace(word) {
        var res = word.replace("[", "");
        res=res.replace("]","");
        return res;
    }
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

body{
    background-color: whitesmoke;
}
.additional-info-form{
    margin: 0 auto;
    width: 80%;
}

legend{
    font-weight: bold;
}

label{
    margin-top: 20px;
}

input[type=text]{
    border-top: none;
    border-left: none;
    border-right: none;
    border-bottom: 1px solid black;
    height: 40px;
    margin-top: 10px;
}

fieldset{
    display: flex;
    flex-direction: column;
}


#waiver-reasons{
    margin-top: 50px;
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
        <table>
            <thead>
            <tr>
                <th style="width: 40px; text-align: center;">#</th>
                <th>Service Name</th>
                <th style="width:120px; text-align:right;">Approve Bill</th>
                <th style="width: 90px">Unit Price</th>
                <th style="width:120px; text-align:right;">Amount Waived</th>
                <th style="width:120px; text-align:right;">Item Total</th>
                <th style="width:20px; text-align:center;">&nbsp;</th>
            </tr>
            </thead>

            <tbody id="datafield" data-bind="foreach: waiveItems, visible: waiveItems().length > 0">
            <tr>
                <td style="text-align: center;"><span class="nombre"></span></td>
                <td data-bind="text: initialBill().name"></td>

                <td>
                    <input type="checkbox">
                </td>
                <td>
                    <input data-bind="value: quantity">
                </td>

                <td style="text-align: right;">
                    <span data-bind="text: formattedPrice"></span>
                </td>

                <td style="text-align: right;">
                    <span data-bind="text: itemTotal().toFixed(2)"></span>
                </td>

            </tr>
            </tbody>

            <tbody>
            <tr style="border: 1px solid #ddd;">
                <td style="text-align: center;"></td>
                <td colspan="3"><b>Total surcharge: Kshs</b></td>

                <td style="text-align: right;">
                    <span data-bind="text: totalSurcharge().toFixed(2)"></span>
                </td>
                <td style="text-align: right;"></td>
            </tr>

            <tr style="border: 1px solid #ddd;">
                <td style="text-align: center;"></td>
                <td colspan="3"><b>Waiver Amount: Kshs</b></td>

                <td style="text-align: right;">
                    <input id="waiverAmount" data-bind="value: waiverAmount"/>
                </td>
                <td style="text-align: right;"></td>
            </tr>
            </tbody>

        </table>

        <div class="additional-info-form">
            <form action="">
                <fieldset>
                    <legend class="legend-style">
                        OBSERVATION BY OFFICER RECOMMENDING WAIVER
                    </legend>

                    <label for="">What is the patient's general appearance</label>

                    <textarea name="general-appearance" id="" cols="10" rows="5" style="width:50%"></textarea>

                    <label for="">Specify the reasons below</label>

                    <textarea style="width:50%" name="waiver-reasons" id="" cols="30" rows="10"></textarea>

                    <label for="">Date</label>
                    <input type="date" name="datepicker" id="">
                </fieldset>
            </form>
        </div>

        <form method="post" id="billsForm" style="padding-top: 10px">
            <input id="patientI" type="hidden" value="">
            <textarea name="waive" data-bind="value: ko.toJSON(\$root)" style="display:none;"></textarea>
        </form>
        <form method="post" id="waiverForm" style="padding-top: 10px">
            <input id="patientId" type="hidden" value="">
            <textarea name="waiver" data-bind="value: ko.toJSON(\$root)" style="display:none;"></textarea>
            <button data-bind="click: submitwaiver, enable: waiveItems().length > 0 " class="confirm">Save</button>
            <button data-bind="click: cancelwaiverAddition" class="cancel">Cancel</button>

        </form>

    </div>
</div>
