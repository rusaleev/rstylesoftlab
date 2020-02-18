package com.rstylesoftlab.creditcalculator.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix="settings")
public class Config {

	private String settingsURL;

	public String getSettingsURL() {
		return settingsURL;
	}

	public void setSettingsURL(String settingsURL) {
		this.settingsURL = settingsURL;
	}
}