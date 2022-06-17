package org.openmrs.module.ehrwaiver.page.controller;

import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.BillingService;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.hospitalcore.model.PatientServiceBill;
import org.openmrs.module.hospitalcore.model.PatientServiceBillItem;
import org.openmrs.module.hospitalcore.util.PatientUtils;
import org.openmrs.module.kenyaui.annotation.AppPage;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@AppPage("ehrwaiver.waive")
public class WaiveInfoPageController {
	
	public String get(PageModel pageModel, @RequestParam("patientId") Integer patientId) {
		Patient patient = Context.getPatientService().getPatient(patientId);
		Map<String, String> attributes = PatientUtils.getAttributes(patient);
		BillingService billingService = Context.getService(BillingService.class);
		HospitalCoreService hcs = Context.getService(HospitalCoreService.class);
		
		pageModel.addAttribute("patientId", patientId);
		pageModel.addAttribute("patient", patient);
		pageModel.addAttribute("age", patient.getAge());
		pageModel.addAttribute("currentDate", new Date());

		List<PatientServiceBill> bills = billingService.getAllPatientServiceBill().stream().filter(bill ->
				bill.getPatient() == patient ).collect(Collectors.toList());
		List<PatientServiceBillItem> patientBills = new ArrayList<>();
		for (PatientServiceBill bill :
				bills) {
			patientBills.addAll(bill.getBillItems());
		}

		pageModel.addAttribute("billedItems",patientBills);
		return null;
	}
}
