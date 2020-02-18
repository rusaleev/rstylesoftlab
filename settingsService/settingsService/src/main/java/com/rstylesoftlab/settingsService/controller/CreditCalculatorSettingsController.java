package com.rstylesoftlab.settingsService.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.rstylesoftlab.settingsService.model.CreditCalculatorSettings;

@RestController
public class CreditCalculatorSettingsController {

	@GetMapping("/")
	public CreditCalculatorSettings settings() {
		CreditCalculatorSettings settings = new CreditCalculatorSettings();
		return settings;
	}
}
