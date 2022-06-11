<%
    ui.decorateWith("kenyaemr", "standardPage")
%>
<html>
<head>
    <title>Waive Form</title>
</head>
<style>
body {
    background: #f3f3f3;
}
</style>

<script>
    function printReceipt (printDiv){
        var printdata = document.getElementById(printDiv);
        newwin = window.open("");
        newwin.document.write(printdata.outerHTML);
        newwin.print();
        newwin.close();
    }
</script>
<body>
<div id="printDiv">
    <h3>A. BASIC INFORMATION</h3>
    <form action="" method="post">
        <p>Name of patient: <input type="text" name="name" value="" size="35"/>&nbsp; &nbsp; &nbsp;
        IP/No : <input type="text" name="ipno" value="" size="26"/><br/> </p>
        <p>Diagnosis: <input type="text" name="diagnosis" value="" size="35"/>
            Operation : <input type="text" name="operation" value="" size="30"/><br/>
        </p>
        <p>Ward: <input type="text" name="diagnosis" value="" size="25"/>
            DOA : <input type="text" name="operation" value="" size="19"/>
            DOD : <input type="text" name="operation" value="" size="19"/><br/>
        </p>
        <p>Age: <input type="text" name="age" value="" size="37"/>
            Sex : <input type="text" name="sex" value="" size="38"/><br/>
        </p>
        <p>Occupation : <input type="text" name="occupation" value="" size="32"/>
            Residence : <input type="text" name="residence" value="" size="32"/><br/>
        </p>
        <p>Contact Address: <input type="text" name="address" value="" size="46"/>
            Tel : <input type="number" name="tel" value="" size=""/><br/>
        </p>
        <p>Home Counthy: <input type="text" name="counthy" value="" size="30"/>
            Sub-County : <input type="text" name="subcounty" value="" size="30"/><br/>
        </p>
        <p>Location: <input type="text" name="location" value="" size="20"/>
            Sub-Location : <input type="text" name="sublocation" value="" size="17"/>
            Village : <input type="text" name="village" value="" size="16"/><br/>
        </p>
        <p>Chief-Assistant : <input type="text" name="chief" value="" size="16"/><br/></p>
    </form>
    <h3>B. PARTICULARS NEXT OF KIN</h3>
    <form>
        <p>Name : <input type="text" name="pname" value="" size="35"/>
            Relationship to patient : <input type="text" name="rlship" value="" size="24"/><br/>
        </p>
        <p>Contact: <input type="text" name="pcontact" value="" size="22"/>
            Address : <input type="text" name="paddress" value="" size="20"/>
            Tel : <input type="number" name="ptel" value="" size="22"/><br/>
        </p>
        <p>Residence: <input type="text" name="pcontact" value="" size="18"/>
            Occupation : <input type="text" name="poccupation" value="" size="18"/>
            Work : <input type="number" name="pwork" value="" size="20"/><br/>
        </p>
        <p>Place/Address : <input type="text" name="place" value="" size="20"/><br/></p>
    </form>
    <h3>C. OBSERVATION BY OFFICER RECOMMENDING WAIVER</h3>
    <form>
        <p>What's the patient's general appearance? <input type="text" name="appearance" value="" size="56"/><br/></p>
        <p>Who brought him/her to the hospital? <input type="text" name="who" value="" size="58"/><br/></p>
        <p>What does the patient do to earn a living? <input type="text" name="earning" value="" size="55"/><br/></p>
        <p>Any visiting relatives/friends? State the relationship to patient and where they come from </p>
        <textarea type="text" name="other" value="" cols="90" rows="4" size="56">

        </textarea>
        <br/>
    </form>
    <h3>REASONS FOR RECOMMENDING WAIVER [WARD NURSE IN CHARGE, <br/> NURSE IN CHARGE]</h3>
    <textarea type="text" name="reasons" value="" cols="90" rows="4" size="56">

    </textarea>
    <form>
        <p>Name : <input type="text" name="nursename" value="" size="22"/>
            Design : <input type="text" name="design" value="" size="20"/>
            Sign : ..................................................<br/>
        </p>
        <p>Date : <input type="date" name="date" value="" size="16"/><br/></p>
    </form>
    <h3>D. HOSPITAL BILL</h3>
    <form>
        <p>Total Bill Ksh <input type="text" name="total" value="" size="9"/>
            Amount Paid : <input type="text" name="ammpaid" value="" size="9"/>
            Receipt No : <input type="text" name="receipt" value="" size="9"/>
            Date : <input type="date" name="date" value="" size="16"/><br/>
        </p>
    </form>
    <h3>E. COMMITMENT OF CREDIT</h3>
    <p>I ...............................................................................................................
    of ID No ..........................................................<br/></p>
    <p>Hereby commit myself that I will pay the amount credited on/or before .........................................................................</p>
    <p>Sign: ............................................................
    Tel : <input type="number" name="ptel" value="" size="22"/>
        Address : <input type="text" name="paddress" value="" size="20"/><br/>
    </p>
    <h3>F. SOCIAL WORKER'S REMARKS/RECOMMENDATION</h3>
    <textarea type="text" name="remarks" value="" cols="90" rows="4" size="56">

    </textarea>
    <p>
        Name : <input type="text" name="worker" value="" size="30"/>
        Design : <input type="text" name="wdesign" value="" size="22"/>
        Date : <input type="date" name="date" value="" size="16"/><br/>
    </p>
    <h3>G. ACTION BY WAIVER COMMITTEE (Tick where applicable) </h3>
    <p>Amount in Ksh <input type="number" name="realamount" value=""/>
        Approved <input type="checkbox" name="approved"/>
        Not Approved <input type="checkbox" name="notapproved"/></p>
    <h3>COMMENTS</h3>
    <textarea type="text" name="remarks" value="" cols="90" rows="4" size="56">

    </textarea>
    <h4>Confirmed by:- </h4>
    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>Design</th>
            <th>Sign</th>
            <th>Date</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>1. M. Kilonzo</td>
            <td>HAO</td>
            <td>..................................................................</td>
            <td><input type="date" name="date"/></td>
        </tr>
        <tr>
            <td>2. Anne Mutua</td>
            <td>Nurse Manager</td>
            <td>..................................................................</td>
            <td><input type="date" name="date"/></td>
        </tr>
        <tr>
            <td>3. Hamadi Kibwebwe</td>
            <td>Accountant</td>
            <td>..................................................................</td>
            <td><input type="date" name="date"/></td>
        </tr>
        </tbody>
    </table>
    <h4>Authorized By:- </h4>
    <p>Name : <input type="text" name="authorizer" value="" size="50"/></p>
    <p>Sign : ..........................................................................
    Date : <input type="date" name="date" /><br/>
    </p>
    <button id="printSlip"  onclick="printReceipt('printDiv');">Print</button>

</div>
</body>
</html>