class UserJdts < Jdts

	def columns
		%w[first_name approved_at email updated_at created_at admin_id]
	end

	def data
		records.map do |record|
			[
				h(''),
				link_to("#{record.first_name} #{record.last_name}", record),
				h(record.approved_at? ? 'Yes' : 'No'),
				h(record.email),
				h(date_format(record.updated_at, time: true)),
				h(date_format(record.created_at, time: true)),
				h(record.admin_id? ? record.admin_user.full_name : 'Na')
			]
		end
	end

	def fetch_records
		records = get_custom_data
		records = records.page(page).per_page(per_page)
		if params[:sSearch].present?
			records = records.where("first_name like :search or last_name like :search", search: "%#{params[:sSearch]}%")
		end
		records
	end

	def get_custom_data
		return User.where(admin: eval(params[:admin])).order("#{sort_column} #{sort_direction}")
	end
end