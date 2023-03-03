require_relative "concerns/moderable_concern.rb"

class ModeratedModel < ApplicationRecord
    include Moderable

    def attribute_to_moderate
        moderate(self.title)
        moderate(self.content)
    end
end
