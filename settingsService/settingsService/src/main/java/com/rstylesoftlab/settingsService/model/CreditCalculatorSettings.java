package com.rstylesoftlab.settingsService.model;

public class CreditCalculatorSettings {
	private Integer loanMin = 100000;
	private Integer loanMax = 5000000;
	private Integer durationMin = 12;
	private Integer durationMax = 60;
	private Float percent = 0.129f; //yearly percent from 12.9% to 23.9%
	public Integer getLoanMin() {
		return loanMin;
	}
	public void setLoanMin(Integer loanMin) {
		this.loanMin = loanMin;
	}
	public Integer getLoanMax() {
		return loanMax;
	}
	public void setLoanMax(Integer loanMax) {
		this.loanMax = loanMax;
	}
	public Integer getDurationMin() {
		return durationMin;
	}
	public void setDurationMin(Integer durationMin) {
		this.durationMin = durationMin;
	}
	public Integer getDurationMax() {
		return durationMax;
	}
	public void setDurationMax(Integer durationMax) {
		this.durationMax = durationMax;
	}
	public Float getPercent() {
		return percent;
	}
	public void setPercent(Float percent) {
		this.percent = percent;
	}
}
