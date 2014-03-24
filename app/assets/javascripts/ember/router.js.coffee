# For more information see: http://emberjs.com/guides/routing/


Service.Router.map ()->
  @resource('solving_steps', {path: "/"}, ->
  	@route('new')
  )

Service.Router.reopen(
  rootURL: '/solving_steps'
)