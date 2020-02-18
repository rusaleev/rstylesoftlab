package com.rstylesoftlab.creditcalculator.controller;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.rstylesoftlab.creditcalculator.config.Config;
import com.rstylesoftlab.creditcalculator.dto.CreditCalculatorSettings;
import com.rstylesoftlab.creditcalculator.dto.LoanParams;

@Controller
public class MainController {

	@Autowired
	RestTemplate restTemplate;
	
	@Autowired
	Config config;

	@GetMapping("/")
	public String main() {
		return "index";
	}

	@PostMapping("/")
	public @ResponseBody CreditCalculatorSettings settings(@RequestBody(required = false) LoanParams loan) {
		if (loan==null){
			System.out.println(loan);
			loan = new LoanParams();
		}
		System.out.println(loan.getSum());
		System.out.println(loan.getWeeks());
		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		HttpEntity<LoanParams> requestEntity = new HttpEntity<LoanParams>(loan);
		return restTemplate.exchange(config.getSettingsURL(), HttpMethod.GET, requestEntity, CreditCalculatorSettings.class).getBody();
	}
}
