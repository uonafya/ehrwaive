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
<script type="text/javascript">
    function printReceipt() {
        var printDiv = jQuery("#printDiv").html();
        var printWindow = window.open('height=500,width=400');
        //printWindow.document.write('<html><head><title>Patient Information</title>'); not needed
        printWindow.document.write('<body style="font-family: Dot Matrix Normal,Arial,Helvetica,sans-serif; font-size: 12px; font-style: normal;">');
        printWindow.document.write(printDiv);
        printWindow.document.write('</body>');
        printWindow.document.write('</html>');
        //hide print button
        printWindow.document.getElementById("printSlip").style.visibility = "hidden";
        printWindow.print();
        printWindow.close();

    }

</script>
<style>
#breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
    text-decoration: none;
}

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

.catg {printReceipt
    color: #363463;
    margin: 35px 10px 0 0;
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

.formfactor label {
    color: #f26522;
    padding-left: 5px;printReceipt
}

.formfactor input {
    border: 1px solid #aaa;
    color: #222;
    display: block;
    height: 29px;
    margin: 5px 0;
    min-width: 98%;
    padding: 5px 10px;
}

.formfactor h2 {
    display: inline-block;
    float: right;
    margin-top: -40px;
    padding-right: 10px;
}

td input {
    background: transparent none repeat scroll 0 0;
    border: 1px solid #aaa;
    padding-right: 10px;
    text-align: right;
    width: 80px;
}

table th, table td {
    border: 1px solid #ddd;
    padding: 5px 20px;
}

#datafield {
    display: none;
}

#waiverAmount {
    margin-left: -12px;
    margin-right: -12px;
    width: 137px;
}
.name {
    color: #f26522;
}
</style>

<div id="printDiv">

<div class="container">
    <div class="example">
        <ul id="breadcrumbs">
            <li>
                <i class="icon-home small"></i></a>
            </li>
        </ul>
    </div>
    <div class="patient-header new-patient-header">
        <div class="demographics">
            <h1 class="name">
                <span id="surname"></span>
                <span id="othname"></span>
            </h1>
        </div>

    </div>



    <div id="stacont" class="status-container">
        <span class="status active"></span>
        Visit Status

        <div class="close"></div>
    </div>

    <table>
        <thead>
        <tr>
            <th style="width: 40px; text-align: center;">#</th>
            <th>Service Name</th>
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
                <input data-bind="value: quantity">
            </td>

            <td style="text-align: right;">
                <span data-bind="text: formattedPrice"></span>
            </td>

            <td style="text-align: right;">
                <span data-bind="text: itemTotal().toFixed(2)"></span>
            </td>

            <td style="text-align: center;">
                <a class="remover" href="#" data-bind="click: \$root.removeWaiveItem">
                    <i class="icon-remove small" style="color:red"></i>
                </a>
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



    <form method="post" id="billsForm" style="padding-top: 10px">
        <input id="patientId" type="hidden" value="">
        <textarea name="waive" style="display:none;"></textarea>
%{--        <button data-bind="click: submitwaiver enable: waiveItems().length > 0 " class="confirm">Save</button>--}%
%{--        <button data-bind="click: cancelWaiveAddition" class="cancel">Cancel</button>--}%

    </form>

</div>


<table>
    <thead>
    <tr>
        <th style="width: 40px; text-align: center;">#</th>
        <th>Name</th>
        <th style="width: 90px">Department</th>
        <th style="width:120px; text-align:right;">Date</th>
        <th style="width:120px; text-align:right;">Approved</th>
        <th style="width:120px; text-align:right;">not Approved</th>
        <th style="width:20px; text-align:center;">&nbsp;</th>
    </tr>
    </thead>

    <tbody id="datafield" data-bind="foreach: waiveItems, visible: waiveItems().length > 0">
    <tr>
        <td style="text-align: center;"><span class="nombre"></span></td>
        <td data-bind="text: initialWaiver().name"></td>

        <td>
            <input data-bind="value: quantity">
        </td>
        <td>
            <input data-bind="value: quantity">
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

        <td style="text-align: center;">
            <a class="remover" href="#" data-bind="click: \$root.removeWaiveItem">
                <i class="icon-remove small" style="color:red"></i>
            </a>
        </td>
    </tr>
    </tbody>

    <tbody>
    <tr style="border: 1px solid #ddd;">
        <td style="text-align: center;"></td>
        <td colspan="1"><b></b></td>

        <td style="text-align: right;">
            <span data-bind="text: totalSurcharge().toFixed(2)"></span>
        </td>
        <td style="text-align: right;"></td>
    </tr>

    <tr style="border: 1px solid #ddd;">
        <td style="text-align: center;"></td>
        <td colspan="1"><b></b></td>

        <td style="text-align: right;">
            <input id="waiverAmount" data-bind="value: waiverAmount"/>
        </td>

    <tr style="border: 1px solid #ddd;">
        <td style="text-align: center;"></td>
        <td colspan="1"><b></b></td>

        <td style="text-align: right;">
            <input id="waiverAmount" data-bind="value: waiverAmount"/>
        <td style="text-align: right;"></td>
    </tr>
    </tbody>

</table>

<div id="waiverCommentDiv" style="padding-top: 10px;">
    <label for="waiverComment" style="color: rgb(54, 52, 99);">Waiver Number/Comment</label>
    <textarea type="text" id="waiverComment" name="waiverComment" size="7" class="hasborder" style="width: 99.4%; height: 60px;" data-bind="value: comment"></textarea>
</div>



<form method="post" id="waiverForm" style="padding-top: 10px">

    <button data-bind="click: submitwaiver, enable: waiveItems().length > 0 " class="confirm">Save</button>
    <button data-bind="click: cancelwaiverAddition" class="cancel">Cancel</button>

</form>
<div class="col2">
    <span class="button task" id="printSlip" onclick="printReceipt();window.location.href='waiveQueue.page';" style="float:right; display:inline-block; margin-left: 5px;">
        <i class="icon-print small"></i>&nbsp; Print</a>
    </span>
</div>
</div>




