if Rails.env.development?
	BetterErrors.editor = :sublime if defined? BetterErrors
end