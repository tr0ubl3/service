# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready -> 
	AlarmArray = []
	acfi = $("#alarm_code")
	doChk = (e) ->
		acfi.closest('.control-group').removeClass('error')
		if e.keyCode is 13
			e.preventDefault()
			doChkVal(e)
	doChkVal = ->
		alarm_value = acfi.val()
		regex = /^[0-9]{5,6}$/
		if alarm_value? and regex.test(alarm_value) is on then doSearchAlarm(alarm_value)
		else
			doAlarmError(alarm_value)
	acfi.on("keydown", doChk)
	$("#acjs").on("click", doChkVal)
	doSearchAlarm = (value) -> 
		$.ajax
			url: "/service_events/new"
			type: "get"
			async: "false"
			contentType: "json"
			cache: "false"
			data:
				"search": value
			dataType: "json"
			success: doCheckJsonResponse
	doCheckJsonResponse = (response) ->
		if response.length isnt 0 then doInsertAlarm(response)
		else
			alert("Invalid alarm")
			doAlarmError(response)
	doAlarmError = ->
		acfi.closest('.control-group').addClass('error')
	doInsertAlarm = (json_data) ->
		alarm_id = json_data[0].id
		alarm_number = json_data[0].number
		alarm_text = json_data[0].text
		console.log('success ' + alarm_number)
		$('#acdp').css('display', 'block');
		$("<p></p>",
			text: alarm_number + " - " + alarm_text
			class: "alarm_code_add"
			data: alarm_number)	
		.appendTo("#acdp").attr("data-alarmnumber", alarm_number)
		$("<input />",
			id: "alarms"
			multiple: "true"
			name: "alarms[]"
			type: "hidden"
			value: alarm_id)
		.appendTo("#acdp")
		acfi.val("")
