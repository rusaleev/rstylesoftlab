<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>

<c:url value="/css/main.css" var="jstlCss" />
<link href="${jstlCss}" rel="stylesheet" />

</head>
<body>

	<div class="container">

		<div class="starter-template">
			<h1>Loan calculator</h1>
			<label for="loan_sum">Loan Amount</label>
			<br>
			<input type="text" id="loan_sum"
				data-bind="value: loanSum, event:{change:updatePercent}, attr:{title:amountTitle}">
			<br>
			<label for="duration">Duration(months)</label>
			<br>
			<input
				type="text" id="duration"
				data-bind="value: duration, event:{change:updatePercent}, attr:{title:durationTitle}">
			<br>
			<label for="percent">Percent</label>
			<br>
			<input
				type="text" id="percent" disabled="disabled"
				data-bind="value: percentDisplay, attr:{title:percentTitle}">
			<br>
		</div>
		
		<div>
			<table>
			<thead>
			<tr>
				<th>Payment No</th>
				<th>Loan Payment</th>
				<th>Percent Payment</th>
				<th>Loan Remainder</th>
				<th>Total Payment</th>
			</tr>
			</thead>
			<tbody data-bind="foreach:schedule">
			<tr>
				<td data-bind="text:number"></td>
				<td data-bind="text:loan_pay"></td>
				<td data-bind="text:percent_pay"></td>
				<td data-bind="text:loan_remainder"></td>
				<td data-bind="text:monthly_pay"></td>
			</tr>
			</tbody>
			
			
			</table>
		</div>

	</div>

	<script type="text/javascript" src="webjars/knockout/3.4.1/knockout.js"></script>

	<script type="text/javascript">
		// Here's my data model
		var ViewModel = function(loanSum, duration, percent) {
			var self = this;
			this.loanSum = ko.observable(loanSum);
			this.duration = ko.observable(duration);
			this.percent = ko.observable(percent);
			this.minSum = ko.observable(loanSum);
			this.maxSum = ko.observable(loanSum);
			this.minDuration = ko.observable(duration);
			this.maxDuration = ko.observable(duration);
			
			this.schedule = ko.observableArray();

			this.amountTitle = ko.pureComputed(function() {
				return "Loan amout. Min value is "+this.minSum()+". Max value is "+this.maxSum();
			}, this);
			this.durationTitle = ko.pureComputed(function() {
				return "Loan duration (weeks). Min value is "+this.minDuration()+". Max value is "+this.maxDuration();
			}, this);
			this.percentTitle = ko.pureComputed(function() {
				return "Loan percentage";
			}, this);
			
			this.percentDisplay = ko.pureComputed(function() {
				return parseFloat((this.percent()*100).toFixed(2))+"%";
			}, this);
			
			this.validate = ()=>{
				if (self.loanSum()<self.minSum())
					self.loanSum(self.minSum());
				if (self.loanSum()>self.maxSum())
					self.loanSum(self.maxSum());
				if (self.duration()<self.minDuration())
					self.duration(self.minDuration());
				if (self.duration()>self.maxDuration())
					self.duration(self.maxDuration());
				if (isNaN(Number(self.loanSum())))
					self.loanSum(self.minSum());
				if (isNaN(Number(self.duration())))
					self.duration(self.minDuration());
			}
			
			this.buildSchedule = ()=>{
				self.schedule.removeAll();
				var loan_remainder = self.loanSum();
				var monthly_percent = self.percent()/12
				var monthly_pay = Math.round(100*self.loanSum()*monthly_percent/(1-Math.pow(1+monthly_percent,-self.duration())))/100;
				for (var i = 0; i<self.duration(); i++){
					var month = (i % 12)+1;
					var year = ((i+1-month) / 12)+1;
					var percent_pay = Math.round(100*loan_remainder*monthly_percent)/100;
					if (i!=self.duration()-1){
						var loan_pay = Math.round(100*(monthly_pay-percent_pay))/100;
						loan_remainder = Math.round(100*(loan_remainder-loan_pay))/100;
						self.schedule.push({number:"month "+month+"/year "+year,monthly_pay:monthly_pay,loan_pay:loan_pay,percent_pay:percent_pay,loan_remainder:loan_remainder});
					} else {
						var loan_pay = loan_remainder;
						monthly_pay = Math.round(100*(loan_pay + percent_pay))/100;
						loan_remainder = 0;
						self.schedule.push({number:"month "+month+"/year "+year,monthly_pay:monthly_pay,loan_pay:loan_pay,percent_pay:percent_pay,loan_remainder:loan_remainder});
					}
				}
				
			}
			
			this.updatePercent = ()=>{
				self.validate();
				var xhttp = new XMLHttpRequest();
				  xhttp.onreadystatechange = function() {
				    if (this.readyState == 4 && this.status == 200) {
				     console.log(this.responseText);
				     var res = JSON.parse(this.responseText);
				     self.minSum(res.loanMin);
				     self.maxSum(res.loanMax);
				     self.minDuration(res.durationMin);
				     self.maxDuration(res.durationMax);
				     self.percent(res.percent);
				     self.validate();
				     self.buildSchedule();
				    }
				  };
				  var data = {sum:this.loanSum(),weeks:this.duration()};
				  xhttp.open("POST", window.location.href, true);
				  xhttp.setRequestHeader("Content-Type","application/json");
				  xhttp.send(JSON.stringify(data));
			}
			
			this.updatePercent();
		};

		ko.applyBindings(new ViewModel(10000, 12, 0.129));
	</script>

</body>

</html>