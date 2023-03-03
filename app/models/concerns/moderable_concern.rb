require 'cgi'

module Moderable
    extend ActiveSupport::Concern

    included do        
        before_create :attribute_to_moderate


        def moderate(champs)
            unless self.is_accepted == false
                self.accept?(champs) == 1? self.is_accepted = true : self.is_accepted = false
            end
        end

        private

        def accept?(champs)
            probability = get_probability(champs)
            probability <= 0.5? (return 1) : (return 0)
        end
    
        def get_probability(champs)
            response = HTTParty.get("https://moderation.logora.fr/predict?text=#{CGI.escape(champs)}")
            parsed = JSON.parse(response.body)
            return parsed["prediction"]["0"].to_f if response.code == 200
        end
    end
end