package com.rstylesoftlab.creditcalculator.dto;

public class CreditCalculatorSettings {
	private Integer loanMin;
	private Integer loanMax;
	private Integer durationMin;
	private Integer durationMax;
	private Float percent; // yearly percent from 12.9% to 23.9%

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
