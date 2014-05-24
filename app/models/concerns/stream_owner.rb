module StreamOwner

  extend ActiveSupport::Concern

  included do

    has_one :stream, as: :owner

    before_create do
      build_stream
    end

  end


end
