class Tweeet < ApplicationRecord
    mount_uploader :image, ImageUploader

    belongs_to :user
    has_many :likes, dependent: :destroy

    def set_success(format, opts)
        self.success = true
    end
end
