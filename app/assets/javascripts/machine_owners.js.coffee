# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$('#machine_owners_list').dataTable
		bProcessing: true
		bServerSide: true
		sAjaxSource: '/machine_owners.json'