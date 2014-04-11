$ ->
	$('#machine_group_alarms, #machine_group_machines').dataTable
				"fnDrawCallback": (oSettings) ->
					if(oSettings.bSorted || oSettings.bFiltered)
							i = 0
							iLen = oSettings.aiDisplay.length
							while i < iLen
								$('td:eq(0)', oSettings.aoData[ oSettings.aiDisplay[i] ].nTr ).html i+1
								i++
				"aoColumnDefs": [
					{ "bSortable": false, "aTargets": [ 0 ] }
				]
				"aaSorting": [[ 1, 'asc' ]]
	$('input#csv_alarms').on "change", ->
		value = @value.split(/[\/\\]/).pop()
		extension = value.split('.').pop()
		if extension? and extension is "csv"
			$("span#upload-file-info").html(value)
		else
			$(@).val(null)
			delete @files[0]
			alert("." + extension + " invalid file format")