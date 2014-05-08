# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$("td").find("#user_list").tooltip(placement: "right")
	users_table_admin = $('#manage_users_table_admin')
	users_table_admin.dataTable
		bProcessing: true
		bServerSide: true
		bAutoWidth: false
		sAjaxSource: users_table_admin.data('source')
		fnServerParams: (aoData) ->
			aoData.push('name':'admin', 'value':'true')
	users_table_regular = $('#manage_users_table_regular')
	users_table_regular.dataTable
		bProcessing: true
		bAutoWidth: false
		bServerSide: true
		sAjaxSource: users_table_admin.data('source')
		fnServerParams: (aoData) ->
			aoData.push('name':'admin', 'value':'false')
	users_table_regular.find('thead > tr > th:nth-child(2)').css('width', '15%')
	users_table_admin.find('thead > tr > th:nth-child(2)').css('width', '15%')
