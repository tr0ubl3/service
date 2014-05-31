# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require jquery-fileupload/basic
#= require bootstrap-datepicker/core
#= require bootstrap-datepicker/locales/bootstrap-datepicker.ro
#= require fancybox
#= require mediaelement-and-player
#= require jquery.tokeninput

$(document).ready ->
	$('#event_date').datepicker({
               format: 'dd.mm.yyyy',
               autoclose: true,
               startView: 0
               })

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
			url: $('#alarm_code').data('path')
			type: "get"
			async: "true"
			contentType: "json"
			cache: "false"
			data:
				"search": value
			dataType: "json"
			success: doCheckJsonResponse
	doCheckJsonResponse = (response) ->
		# console.log(response.service_events[0].service_events.text)
		if response.service_events.length isnt 0 then doInsertAlarm(response.service_events[0].service_events)
		else
			InvalidArray.push(temp_alarm_value)
			alert("Invalid alarm")
			doAlarmError(response)
	doAlarmError = ->
		acfi.closest('.control-group').addClass('error')
	doInsertAlarm = (json_data) ->
		alarm_id = json_data.id
		alarm_number = json_data.number
		alarm_text = json_data.text
		$('#acdp').css('display', 'block');
		$("<p></p>",
			text: alarm_number + " - " + alarm_text
			class: "alarm_code_add"
			data: alarm_number)	
		.appendTo("#acdp").attr("data-alarmnumber", alarm_number)
		$("<input />",
			id: "alarms"
			multiple: "true"
			name: "service_event[alarm_ids][]"
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
	evtnm = $("div#recurrent_event>div.modal-body>div:nth-child(1)>li:nth-child(odd)")
	event_id = null
	event_name = null
	doShowEvntDesc = (e) ->
		t = $(@)
		if t.hasClass("active") is false
			event_id = t.data("eventid")
			event_name = t.text()
			t.addClass('active')
			t.siblings().removeClass('active')
			# console.log("li is clicked " + event_id)
			pmed = $('p#modal-event-description')
			pmed.empty()
			t.next().first().clone().appendTo(pmed)
	evtnm.on("click", doShowEvntDesc)
	evtnmCloseBtn = $("div#recurrent_event>div.modal-footer>p.btn.btn-primary")
	evntnameappend = $("label > input#service_event_recurrent_true + label")
	doCloseEvntDesc = ->
		$("#recurrent_event").modal('hide')
		$("#service_event_parent_event").val(event_id)
		$("service_event_recurrent_true").prop("checked", true)
		evntnameappend.siblings("p").remove()
		evntnameappend.after("<p>, the parent event is <b>"+event_name+"</b></p>")
		# console.log(event_name + " exista")
	evtnmCloseBtn.on("click", doCloseEvntDesc)
	doShowEventModal = ->
		$('#recurrent_event').modal('show')
	$('#service_event_recurrent_true').on("click", doShowEventModal)
	doClearTrueRecurent = ->
		$("#service_event_parent_event").val("")
		evntnameappend.siblings("p").remove()
	$('#service_event_recurrent_false').on("click", doClearTrueRecurent)
	if $("#service_event_parent_event").val() != ""
		peval = $("#service_event_parent_event").val()
		txt = $("#recurrent_event > div.modal-body > div:nth-child(1) > li").filter( -> 
			$(@).data("eventid") is parseInt(peval)).text()
		# console.log(a+"val"+peval)
		evntnameappend.after("<p>, the parent event is <b>"+txt+"</b></p>")
	
	$("[id^='new_service_event_file']").fileupload
		acceptFileTypes: /(\.|\/)(gif|jpe?g|png|log|mp4)$/i
		add: (e, data) -> 
			doGetThumbnail = (file) ->
				div_obj = document.createElement("div")
				div_obj.className = "file-container-object"
				div_obj.innerHTML = ["<i class='fa fa-picture-o'></i>", "<p>"+file.name+"</p>"].join('')
				$('<input>', { type: 'checkbox', class: "destroy" }).prependTo(div_obj)	                            
				data.context = $(div_obj).insertBefore("div.file-container > br")
			
			doMakeVideoThumbnail = (file) -> 
				div_obj = document.createElement("div")
				div_obj.className = "file-container-object"
				div_obj.innerHTML = ["<i class='fa fa-film'></i>", "<p>"+file.name+"</p>"].join('')
				$('<input>', { type: 'checkbox', class: "destroy" }).prependTo(div_obj)	                            
				data.context = $(div_obj).insertBefore("div.file-container > br")

			doGetLogFileThumbnail = (file) ->
				div_obj = document.createElement("div")
				div_obj.className = "file-container-object"
				div_obj.innerHTML = ["<i class='fa fa-file-text-o'></i>", "<p>"+file.name+"</p>"].join('')
				$('<input>', { type: 'checkbox', class: "destroy" }).prependTo(div_obj)	                            
				data.context = $(div_obj).insertBefore("div.file-container > br")

			image_types = /(\.|\/)(gif|jpe?g|png)$/i
			video_types = /(\.|\/)(mp4)$/i
			log_file_types = /(\.|\/)(txt|log|text)$/i

			for file in data.files 
				if image_types.test(file.name)
					doGetThumbnail(file)
				else if video_types.test(file.name)
					doMakeVideoThumbnail(file)
				else if log_file_types.test(file.name)
					doGetLogFileThumbnail(file)
			
			$("div#file-submit").on("click", ->
				if data.files.length isnt 0
					if (data.context.is(":visible"))
						data.submit())
			$("div#file-remove").on "click", ->
				if data.context[0].childNodes[0].checked
					index = data.originalFiles.indexOf(data.files[0])
					data.originalFiles.splice(index, 1)
					data.context[0].remove()
					$("#new_service_event_file").trigger("change")
		progressall: (e, data) ->
			progress = parseInt(data.loaded / data.total * 100, 10)
			progressbar = $("div.file-container > div.progress")
			progressbar.css("display", "block")
			$("#new_service_event_file").trigger("change")
			progressbar.children("p").first().text((data.bitrate / (1000000 * 8)).toFixed(2) + " MB/s")
			progressbar.children("div").first().css("width", progress + '%')

	$('#new_service_event_file').on "change", ->
		$("input[name=commit]").css("margin-top", $(@).height() + 15)
		# console.log $(@).height()
	$("table.event-table a").fancybox()
	$("table.event-table video").mediaelementplayer({defaultVideoWidth: 180, defaultVideoHeight: 180})
	
	service_events_table = $('#service_events_list')
	service_events_table.dataTable
		bProcessing: true
		bServerSide: true
		sAjaxSource: service_events_table.data('source')
		fnServerParams: (aoData) ->
			aoData.push("name":"machine_id", "value": location.pathname.split("/")[2])
	service_events_table.find('thead > tr > th:nth-child(2)').css('width', '30%')

	# sectiune cauze si simptome
	# radio boxes
	$('#cause_yes').on 'change', ->
		$('fieldset#tokens_fieldset').show('fast')
	$('#cause_no').on 'change', ->
		$('fieldset#tokens_fieldset').hide('fast')
	
	# implementare dynamic fields
	cause_ids = new Object
	doDynamicFields = ->
		cause_field = $('#service_event_cause_tokens')
		# iteration number
		nr_crt = cause_field.closest('fieldset').children('div').length + 1
		# json data path prepare
		machine_id = location.pathname.split("/")[2]
		json_url = cause_field.data('url') + '?machine=' + machine_id
		# dummy input pt token input
		dummy_input = $("<input />",
					id: "input_cause_" + nr_crt
					name: "input_cause_" + nr_crt
					type: "text")
		# definire select elements
		cause_type_select = $('<select>',
														id: 'cause_type_select_' + nr_crt
														name: 'cause_type_select_' + nr_crt).
												html("
													<option value disabled selected>select type ...</option>
													<option value='Software'>Software</option>
													<option value='Hardware'>Hardware</option>")
		cause_category_select = $('<select>',
															id: 'cause_category_select_' + nr_crt
															name: 'cause_category_select_'+ nr_crt	
															).html("
																<option value disabled selected>select category ...</option>
																<option value='Electric'>Electric</option>
																<option value='Hydraulic'>Hydraulic</option>
																<option value='Mechanical'>Mechanical</option>
																<option value='Pneumatic'>Pneumatic</option>
															")
		cause_problem_select = $("<select>",
														id: 'cause_problem_select_' + nr_crt
														name: 'cause_problem_select_' + nr_crt
														).html("
															<option value disabled selected>select problem ...</option>
															<option value='Malfunction'>Malfunction</option>
															<option value='Adjustment'>Adjustment</option>
														")
		delete_cause = $("<div>",
											id: 'delete_cause_' + nr_crt
														).html("<a href='#' title='delete cause'></a>")
		# div wrapper
		div_wrapper = $("<div>",
											class: "cause_wrapper_" + nr_crt).html(dummy_input)
		div_wrapper.append(cause_type_select)
		div_wrapper.append(cause_category_select)
		div_wrapper.append(cause_problem_select)
		div_wrapper.prepend('<span>' + nr_crt + '.</span>')
		div_wrapper.append(delete_cause)
		# insert div	
		cause_field.prev().before(div_wrapper)
		# implementare tokeninput
		div_wrapper.children('input').tokenInput json_url,
			propertyToSearch: 'cause',
			preventDuplicates: true,
			tokenLimit: 1
		# actiune comuna pt update si delete
		doUpdateCauseObject = ->
			key_values = []
			for key of cause_ids
				key_values.push cause_ids[key] unless cause_ids[key] is ''
			cause_field.val(key_values.toString())
			
		# adaugare trigger on change	
		dummy_input_id = 'input_cause_' + nr_crt
		div_wrapper.children('input').on 'change', ->
			cause_ids[dummy_input_id] = div_wrapper.children('input').val()
			doUpdateCauseObject()
		# adaugare trigger on click pt delete cause
		div_wrapper.children(delete_cause).children('a').on 'click', (e) ->
			e.preventDefault()
			cause_ids[dummy_input_id] = ''
			doUpdateCauseObject()
			delete cause_ids.dummy_input_id
			div_wrapper.remove()


	#implementare add link
	do doInsertButton = ->
		insert_link = $('#service_event_cause_tokens').before("<a href='#' id='new_cause'>Insert new cause</a>")
		doDynamicFields()
		insert_link.prev().on 'click', (e) ->
			e.preventDefault()
			doDynamicFields()

	# $(".token_input").each ->
	# 	el = $(@)
	# 	machine_id = location.pathname.split("/")[2]
	# 	json_url = $('#service_event_cause_tokens').data('url') + '?machine=' + machine_id
	# 	el.tokenInput json_url,
	# 		propertyToSearch: 'cause',
	# 		preventDuplicates: true,
	# 		tokenLimit: 1
	# # implementare elemente aditionale
	# $('#token-input-input_cause_' + '1').closest('ul').before('<span>1. </span>')
	# $('#input_cause_1').on 'change', ->
	# 	$('#service_event_cause_tokens').val($(@).val())
	# sfarsit cauze si simptome 