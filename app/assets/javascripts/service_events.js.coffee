# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	EnteredArray = []
	InvalidArray = []
	ExistingArray = $("#acdp").find("p.alarm_code_add").map( -> 
		$(@).attr("data-alarmnumber")).get()
	temp_alarm_value = 0
	acfi = $("#alarm_code")
	doChk = (e) ->
		acfi.closest('.control-group').removeClass('error')
		if e.keyCode is 13
			e.preventDefault()
			doChkVal(e)
	doChkArrays = (chk_entered) ->
		concat_array = EnteredArray.concat(InvalidArray, ExistingArray)
		# console.log(concat_array)
		for value in concat_array
			if chk_entered is value then exists = true
		if exists is true
			doAlarmError(chk_entered)
		else
			doSearchAlarm(chk_entered)
	doChkVal = ->
		alarm_value = acfi.val()
		regex = /^[0-9]{5,6}$/
		if alarm_value? and regex.test(alarm_value) is on then doChkArrays(alarm_value)
		else
			doAlarmError(alarm_value)
	doSearchAlarm = (value) -> 
		temp_alarm_value = value
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
			InvalidArray.push(temp_alarm_value)
			alert("Invalid alarm")
			doAlarmError(response)
	doAlarmError = ->
		acfi.closest('.control-group').addClass('error')
	doInsertAlarm = (json_data) ->
		alarm_id = json_data[0].id
		alarm_number = json_data[0].number
		alarm_text = json_data[0].text
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
		EnteredArray.push(alarm_number.toString())
		# console.log("array now is " + EnteredArray)
		acfi.val("")
	doDeleteAlarm = (click) ->
		object = $(@)
		hidden_field = object.next()
		value = object.attr("data-alarmnumber")
		# console.log("clicked " + value)
		confirmation = confirm("Are you sure you want to delete alarm:" + "\n" + value)
		if confirmation is true
			EnteredArray.splice(EnteredArray.indexOf(value),1)
			ExistingArray.splice(ExistingArray.indexOf(value),1)
			object.remove()
			hidden_field.remove()
			# console.log("remaining now are " + EnteredArray + " and " + ExistingArray)
	acfi.on("keydown", doChk)
	$("#acjs").on("click", doChkVal)
	$('body').on('click', '.alarm_code_add', doDeleteAlarm)
	# $("#acdp").on("DOMNodeInserted", getAlarmArray)