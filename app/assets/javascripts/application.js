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

(function() {
	$('#alarm_code').on('keydown', doChk);
	function doChk(e) {
		if(e.keyCode == 13) {
			doVal(e);
		}
	};
	$('#acjs').on('click', doVal);
function doVal(e) {
	// acfi = alarm_code field id
	acfi = $('#alarm_code');

	// val = current value of field alarm_code
	val = acfi.val();
	$('#acdp').css('display', 'block');
	e.preventDefault();
	if(val === '') {
		console.log('empty string detected');
	}
	else {
		// acfi.closest('.control-group').append(val);
		$('<p></p>', {
			text: val,
			class: 'alarm_code_add',
			data: val
		}).appendTo('#acdp');
		acfi.val('');
		}
}
})();

(function() {
	$('body').on('click', '.alarm_code_add', function () {
		var t = $(this);
		var text = t.text();
		var confirmation = confirm("Are you sure you want to delete alarm:" + "\n" + text);
		if (confirmation==true)
		{
			t.remove();
		}

	}
	);
})();

});
