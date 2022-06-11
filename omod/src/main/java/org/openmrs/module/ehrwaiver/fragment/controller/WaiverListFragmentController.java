package org.openmrs.module.ehrwaiver.fragment.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.reporting.common.DateUtil;
import org.openmrs.ui.framework.fragment.FragmentModel;

import java.util.Date;

public class WaiverListFragmentController {
	
	private static Log logger = LogFactory.getLog(WaiverListFragmentController.class);
	
	public void controller(FragmentModel model) {
		HospitalCoreService hospitalCoreService = Context.getService(HospitalCoreService.class);
		Date startDate = DateUtil.getStartOfDay(new Date());
		Date endDate = DateUtil.getEndOfDay(new Date());
		
		model.addAttribute("waiverList", hospitalCoreService.getAllEhrHospitalWaiver(startDate, endDate));
	}
}
