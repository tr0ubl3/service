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