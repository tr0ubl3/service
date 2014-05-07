$ ->
	$('#machine_group_machines').dataTable()
	$('#machine_group_alarms').dataTable
		bProcessing: true
		bServerSide: true
		sAjaxSource: $('#machine_group_alarms').data('source')
		fnServerParams: (aoData) ->
			aoData.push("name":"machine_group_id", "value": location.pathname.split("/")[2])
	$('#machine_group_alarms > thead > tr > th.sorting_disabled').css('width', 10)
	$('input#csv_alarms').on "change", ->
		value = @value.split(/[\/\\]/).pop()
		extension = value.split('.').pop()
		if extension? and extension is "csv"
			$("span#upload-file-info").html(value)
		else
			$(@).val(null)
			delete @files[0]
			alert("." + extension + " invalid file format")