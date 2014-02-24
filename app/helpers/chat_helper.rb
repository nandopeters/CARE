module ChatHelper
	def display_chat_message_with_patient(message, patient)
		unless message.message == nil
			html = ""
			if message.sender_id == current_user.id
				@class = ""
				@sender = "Me"
			else
				@class = "odd"
				@sender = patient.name
			end

			@message = message.message
			# @time_text = message.created_at.strftime("%l:%M %p")
			@time_text = message.created_at.strftime("%l:%M")

			html = '<div class="group-rom">
	            <div class="first-part ' + (@class || "") + '"">' + (@sender || "") +'</div>
	            <div class="second-part">
	                ' + @message + '
	            </div>
	            <div class="third-part">
	            	' + @time_text + '
	            </div>
	        </div>'
	    html.html_safe
	  end
	end
end
