# For more information see: http://emberjs.com/guides/routing/


Service.Router.map ()->
	@resource('solving_steps', {path: "/"}, ->
		@resource('solving_step', {path: "/:solving_step_id"}, ->
			@route('edit')
		)
		@route('new')
	)

Service.Router.reopen(
  rootURL: '/solving_steps'
)