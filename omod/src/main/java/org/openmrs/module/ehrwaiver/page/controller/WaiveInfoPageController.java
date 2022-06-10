package org.openmrs.module.ehrwaiver.page.controller;

import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.BillingService;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.hospitalcore.util.PatientUtils;
import org.openmrs.module.kenyaui.annotation.AppPage;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;
import java.util.Map;

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
		if(patient.getGender().equals("F")){
			pageModel.addAttribute("gender", "Female");
		}else{
			pageModel.addAttribute("gender", "Male");
		}
		return null;
	}
}
