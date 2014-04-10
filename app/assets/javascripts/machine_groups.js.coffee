# //= require jquery.dataTables
# //= require jquery.dataTables-bootstrap.js
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