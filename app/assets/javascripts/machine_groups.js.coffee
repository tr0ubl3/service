$ ->
	machines_table = $('#machine_group_machines')
	machines_table.dataTable
		bProcessing: true
		bServerSide: true
		bAutoWidth: false
		sAjaxSource: machines_table.data('source')
		fnServerParams: (aoData) ->
			aoData.push("name":"machine_group_id", "value": location.pathname.split("/")[2])
	alarms_table = $('#machine_group_alarms')	
	alarms_table.dataTable
		bProcessing: true
		bServerSide: true
		bAutoWidth: false
		sAjaxSource: alarms_table.data('source')
		fnServerParams: (aoData) ->
			aoData.push("name":"machine_group_id", "value": location.pathname.split("/")[2])
	alarms_table.find('thead > tr > th:nth-child(1)').css('width', 10)
	alarms_table.find('thead > tr > th:nth-child(2)').css('width', '15%')
	$('input#csv_alarms').on "change", ->
		value = @value.split(/[\/\\]/).pop()
		extension = value.split('.').pop()
		if extension? and extension is "csv"
			$("span#upload-file-info").html(value)
		else
			$(@).val(null)
			delete @files[0]
			alert("." + extension + " invalid file format")
	# de adaugat sugestii la machining type in functie de alegerea
	# manufacturer din drop down
	$('#machine_group_manufacturer_id').on 'change', ->
		man_id = $(@).val()
		$.getJSON('/manufacturers/' + man_id).done(
			(data) -> 
				input_opt = $('#machine_group_machining_type')
				input_opt.replaceWith("<div id='m_t' class='input-append btn-group'></div>")
				$('div#m_t.input-append.btn-group').html(
					"<input id='machine_group_machining_type' name='machine_group[machining_type]' size='16' type='text' class='dropdown-toggle' data-toggle='dropdown'></input>
				    <ul class='dropdown-menu'>
				    </ul>
				")
				input_opt_rel = $('#machine_group_machining_type')
				data_array = data.manufacturer.machining_type
				input_opt_rel.val(data_array[0])
				$.each data_array, (val, key) ->
					$('#m_t > ul.dropdown-menu').append("<li><a href='#'>" + key + "</a></li>")
				$('#m_t > ul > li:nth-child(n) > a').on 'click', -> 
					input_opt_rel.val($(this).text())
		)