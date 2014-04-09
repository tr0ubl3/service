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