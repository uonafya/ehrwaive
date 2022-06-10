<%
    ui.decorateWith("kenyaemr", "standardPage")


    ui.includeJavascript("ehrcashier", "paging.js")
    ui.includeJavascript("ehrcashier", "moment.js")
    ui.includeJavascript("ehrcashier", "common.js")
    ui.includeJavascript("ehrcashier", "jquery.PrintArea.js")
    ui.includeJavascript("ehrcashier", "knockout-3.4.0.js")

    ui.includeCss("ehrcashier", "paging.css")
    ui.includeCss("ehrconfigs", "referenceapplication.css")
#waive form

%>
  <script>
    var pData;

    jq(function () {
        var waive = new waiveItemsViewModel();
        pData = getwaiveServices();

		jq('#surname').html(stringReplace('${patient.names.familyName}')+',<em>surname</em>');
		jq('#othname').html(stringReplace('${patient.names.givenName}')+' &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <em>other names</em>');
		jq('#agename').html('${patient.age} years ('+ moment('${patient.birthdate}').format('DD,MMM YYYY') +')');
		jq('.tad').text('Last Visit: '+ moment('${previousVisit}').format('DD.MM.YYYY hh:mm')+' HRS');

		jq("#waiverCommentDiv").hide();

		jq('#waiverAmount').on('change keyup paste', function () {
			var numb = jq('#waiverAmount').val();

			if (!isNaN(parseFloat(numb)) && isFinite(numb) && numb>0){
				jq("#waiverCommentDiv").show();
			}
			else {
				jq("#waiverCommentDiv").hide();
			}
        });

        jq('#waiverAmount').on('focus', function () {
            var numb = jq('#waiverAmount').val();
            if (!isNaN(parseFloat(numb)) && isFinite(numb) && numb > 0) {
                jq('#waiverAmount').val(parseFloat(jq('#waiverAmount').val()))
            }
            else {
                jq("#waiverAmount").val('');
            }
        });

        jq('#waiverAmount').on('blur', function () {
            var numb = jq('#waiverAmount').val();
            if (!isNaN(parseFloat(numb)) && isFinite(numb) && numb > 0) {
                jq('#waiverAmount').val(formatAccounting(numb));
            }
            else {
                jq("#waiverAmount").val('0.00');
            }
        });


        // Class to represent a row in the bill addition grid
        function BillItem(quantity, initialBill) {
            var self = this;
            self.quantity = ko.observable(quantity);
            self.initialBill = ko.observable(initialBill);

            self.formattedPrice = ko.computed(function () {
                var price = self.initialBill().price;
                return price ? price.toFixed(2) : "0.00";
            });

            self.itemTotal = ko.computed(function () {
                var price = self.initialBill().price;
                var quantity = self.quantity();
                var runningTotal = price * quantity;
                return runningTotal ? runningTotal : "0.00";
            });
        }

        // Overall viewmodel for this screen, along with initial state
        function waiveItemsViewModel() {
            var self = this;

            // Non-editable catalog data - would come from the server
            self.availableServices = pData;


            // Editable data
            self.waiveItems = ko.observableArray([]);

            // Computed data
            self.totalSurcharge = ko.computed(function () {
                var total = 0;
                for (var i = 0; i < self.waiveItems().length; i++)
                    total += self.waiveItems()[i].itemTotal();
                return total;
            });

            //observable waiver
            self.waiverAmount = ko.observable(0.00);

            //observable comment
            self.comment = ko.observable("");

              }
            self.removewaiveItem = function (item) {
                self.Items.remove(item);
                numberDataTables();
            }
            self.cancelWaiveAddition = function () {
                window.location.replace("waiverServiceBillListForBD.page?patientId=${patientId}&waiveId=${lastwaiveId}")
            }
            self.submitWaive = function () {
                if (self.totalSurcharge() < self.waiverAmount()) {
                    alert("Please enter correct Waiver Amount");
                } else if (isNaN(self.waiverAmount()) || self.waiverAmount() < 0) {
                    alert("Please enter correct Waiver Amount");
                } else {
                    //submit the details to the server
                    jq("#waiveForm").submit();

                }
            }
        }

        ko.applyBindings(waive, jq("#example")[0]);

        jq("#service").autocomplete({
            minLength: 3,
            source: function (request, response) {
                jq.getJSON('${ ui.actionLink("ehrwiave", "WaiverServiceWaiveAdd", "loadWaiverServices") }',
                        {
                            name: request.term
                        }
                ).success(function (data) {

                            var results = [];
                            for (var i in data) {
                                var result = {label: data[i].name, value: data[i]};
                                results.push(result);
                            }
                            response(results);
                        });
            },
            focus: function (event, ui) {
                jq("#service").val(ui.item.value.name);
                return false;
            },

            }
        });
    });//end of document ready function

    function formatDataTables() {
        if (('#datafield tr').length == 0) {
            jq('#datafield').hide();
        }
        else {
            jq('#datafield').show();
        }
        numberDataTables();
    }

    function numberDataTables() {
        var i = 0;

        jq('#datafield  > tr').each(function () {
            jq('#datafield tr').find("span.nombre").eq(i).text(i + 1);
            i++;
        });
    }

    function getwaiveServices() {
        var toReturn;
        jQuery.ajax({
            type: "GET",
            url: "${ui.actionLink('ehrwaiver','waiverServicewaiveAdd','loadWaiverServices')}",
            dataType: "json",
            data: ({
                name: "ray"
            }),
            global: false,
            async: false,
            success: function (data) {
                toReturn = data;
            }
        });
        return toReturn;
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

	.catg {
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
		padding-left: 5px;
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

<div class="clear"></div>

<div class="container">
    <div class="example">
        <ul id="breadcrumbs">
            <li>
                <a href="${ui.pageLink('kenyaemr', 'userHome')}">
                    <i class="icon-home small"></i></a>
            </li>
        </ul>
    <div class="patient-header new-patient-header">
        <div class="demographics">
            <h1 class="name">
                <span id="surname"></span>
                <span id="othname"></span>
                    <span id="agename"></span>

                </span>
            </h1>

            <div id="stacont" class="status-container">
                <span class="status active"></span>
                Visit Status
            </div>

            <div class="tag">Outpatient ${fileNumber}</div>
        </div>4

        <div class="identifiers">
            <em>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Patient ID</em>
            <span>${patient.getPatientIdentifier()}</span>
            <br>
        </div>

        <div class="close"></div>
    </div>

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
						<input data-bind="value: quantity">
					</td>
                     <td>
                        <input type="checkbox">
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
            <input id="patientId" type="hidden" value="${patientId}">
            <textarea name="waive" data-bind="value: ko.toJSON(\$root)" style="display:none;"></textarea>
        </form>

    </div>

</div>
<table>
        <form method="post" id="waiverForm" style="padding-top: 10px">
            <input id="patientId" type="hidden" value="${patientId}">
            <textarea name="waiver" data-bind="value: ko.toJSON(\$root)" style="display:none;"></textarea>
            <button data-bind="click: submitwaiver, enable: waiveItems().length > 0 " class="confirm">Save</button>
            <button data-bind="click: cancelwaiverAddition" class="cancel">Cancel</button>

        </form>

    </div>

</div>
</table>


