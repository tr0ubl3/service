# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require ./ember/service

window.Service = Ember.Application.create(
	rootElement: '#app'
	LOG_TRANSITIONS: true
	LOG_VIEW_LOOKUPS: true
	)