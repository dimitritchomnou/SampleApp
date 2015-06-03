module ApplicationHelper
	# Retourner un titre basé sur la page.
	def titre
		base_titre = "Simple App du Tutoriel Ruby on Rails"
		if @titre.nil?
			base_titre
		else
			"#{base_titre} | #{@titre}"
	    end
	end

	def logo
		#tag pour insersion du logo
		image_tag("http://railstutorial.org/images/sample_app/logo.png", :alt => "Application Exemple", :class => "round")
	end
end
