# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require bootstrap-datepicker/core
#= require bootstrap-datepicker/locales/bootstrap-datepicker.ro

$(document).ready ->
	$('#machine_delivery_date').datepicker({
               format: 'dd.mm.yyyy',
               autoclose: true,
               startView: 0
               })
	form_container = $('div#new_owner_modal_body')
	doPrepareModalMachineOwner = ->
		form_container.children('h1').remove()
		form_container.find("input[type='submit']").remove()
	$.get("/machine_owners/new.js", (data) ->
		form_container.html ->
			data
	, "html").done ->
		doPrepareModalMachineOwner()
	$('#save_owner_btn').on 'click', ->
		$.post('/machine_owners.js', $('form#new_machine_owner').serialize(), "html")
			.done((text,status,xhr) ->
				$.getJSON xhr.getResponseHeader('Location'), (data) ->
					$.each data, (key, val) ->
						drop_down = $("#machine_machine_owner_id").parent().parent().children('div.controls')
						drop_down.next('span').remove()
						drop_down.html "<a href='#' id='edit_owner'>" + val.name + "</a>
						 				<input type='hidden' id='machine_machine_owner_id' name='machine[machine_owner_id]' value='" + val.id + "'/>"
						$('#new_owner').modal('hide')
						$('#edit_owner').on 'click', ->
							$('#new_owner').modal('show')
						doGetEditMachineOwner(val.id)
			)
			.fail((text) ->
				form_container.html ->
					text.responseText
				doPrepareModalMachineOwner()	
				$('.field_with_errors').closest('.control-group').addClass('error')
			)
	doGetEditMachineOwner = (id) ->
					$.get("/machine_owners/" + id + "/edit.js", (data) ->
						form_container.html ->
							data
					, "html").done ->
						form_container.children('h1').remove()
						form_container.find("input[type='submit']").remove()
					$('#machine_owner_model_header').text("Edit machine owner")
					edit_owner_btn = $('#save_owner_btn')
					edit_owner_btn.text('Update owner')
					edit_owner_btn.attr('id', 'update_owner_btn')
					$('#update_owner_btn').off()
					doUpdateOwner(id)		
	doUpdateOwner = (id) ->
		$('#update_owner_btn').on 'click', ->
			form_data = $('form#edit_machine_owner_' + id).serializeArray()
			json = {}
			$.each form_data, ->
				json[@name] = @value || ''
			# console.log json	
			$.post('/machine_owners/' + id + '.js', json, 'html')
				.done( (text,status,xhr) ->
					$('a#edit_owner').text(json['machine_owner[name]'])
					$('#new_owner').modal('hide')
				)
				.fail((text) ->
					form_container.html ->
						text.responseText
					doPrepareModalMachineOwner()	
					$('.field_with_errors').closest('.control-group').addClass('error')
				)