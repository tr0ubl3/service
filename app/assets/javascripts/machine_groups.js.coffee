$ ->
	$('#machine_group_machines').dataTable()
	$('#machine_group_alarms').dataTable
		bProcessing: true
		bServerSide: true
		bAutoWidth: false
		sAjaxSource: $('#machine_group_alarms').data('source')
		fnServerParams: (aoData) ->
			aoData.push("name":"machine_group_id", "value": location.pathname.split("/")[2])
	$('#machine_group_alarms > thead > tr > th:nth-child(1)').css('width', 10)
	$('#machine_group_alarms > thead > tr > th:nth-child(2)').css('width', '15%')
	#machine_group_alarms > thead > tr > th.sorting_asc
	$('input#csv_alarms').on "change", ->
		value = @value.split(/[\/\\]/).pop()
		extension = value.split('.').pop()
		if extension? and extension is "csv"
			$("span#upload-file-info").html(value)
		else
			$(@).val(null)
			delete @files[0]
			alert("." + extension + " invalid file format")