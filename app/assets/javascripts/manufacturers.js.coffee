# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	manufacturers_table = $('#manufacturers_list')
	manufacturers_table.dataTable
		bProcessing: true
		bServerSide: true
		sAjaxSource: manufacturers_table.data('source')