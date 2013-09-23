// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.ro
//= require_tree .

$(document).ready(function() {
	$('#test').popover();
	$('#event_date').datepicker({
               format: 'dd.mm.yyyy',
               autoclose: true,
               startView: 0
               });
	$('.field_with_errors').closest('.control-group').addClass('error');
	// $('.error').popover({
	// 	animation: false,
	// 	placement: 'right',
	// 	selector: 'input',
	// 	trigger: 'click',
	// 	content: 'Correct error'
	// 	});
// acjs - alarm code button java script

	var AlarmArray = [];
	(function() {

		// insert data using enter key	
		$('#alarm_code').on('keydown', doChk);
		function doChk(e) {
			if(e.keyCode == 13) {
				doVal(e);
			}
		};

		// insert data using button	
		$('#acjs').on('click', doVal);

	// function for inserting data	
	function doVal(e) {
		// acfi = alarm_code field id
		acfi = $('#alarm_code');
		// val = current value of field alarm_code
		val = acfi.val();
		var regex = /^\d{5,6}$/;
		e.preventDefault();
		acfi.closest('.control-group').removeClass('error');
		if(val === '') {
			console.log('empty string detected');
		}

		else if (!(regex.test(val)) ? true:false ) {
			console.log('value '+ val +' is not a number or does not have the required length')
		}

		else {
			// acfi.closest('.control-group').append(val);
			var ValVerify = true;
			//verificare daca eroare introdusa nu a fost deja introdusa
			$.each(AlarmArray, function() {
				if(val == this) {
					console.log('Alarm ' + this + ' already introduced');
					ValVerify = false;
					return;
				}
			});
			console.log(ValVerify);
			if(ValVerify != false) {
				$('#acdp').css('display', 'block');
				AlarmArray.push(val);
				console.log('My alarms are '+ AlarmArray);
				var search_text = $.ajax({
											url: "new",
											type: "get",
											async: "false",
											// contentType: 'json',
											cache: "false",
											data: {"search": val},
											dataType: "json",
											success: function( results ) {
													if (results.length != 0) {
													var alarm_text = results[0].text;
													console.log("this is the one "+alarm_text);
																	$('<p></p>', {
																					text: val + " - " + alarm_text,
																					class: 'alarm_code_add',
																					data: val
																				}).appendTo('#acdp');
																				acfi.val('');

												    }
												    else {
												    	alert('Invalid alarm');
												    }
												}
											});
				// console.log('Ajax merge, valoarea este: ' + search_text);

			}
			else {
				acfi.closest('.control-group').addClass('error');
				}
			}
		}
	})();


	//anonymous function for deleting alarm after clicking on it
	(function() {
		$('body').on('click', '.alarm_code_add', function () {
			var t = $(this);
			var text = t.text();
			var elem = AlarmArray.indexOf(text);
			var confirmation = confirm("Are you sure you want to delete alarm:" + "\n" + text);
			if (confirmation==true)
			{
				t.remove();
				AlarmArray.splice(elem, 1);
				// console.log('textul este ' + text)
				// console.log('ordinea este ' + elem);
				console.log('array now is: ' + AlarmArray);
			}

		}
		);
	})();

	});
