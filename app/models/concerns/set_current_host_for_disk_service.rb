module Concerns
  module SetCurrentHostForDiskService
    extend ActiveSupport::Concern

    included do
      before_action :set_current_host_for_disk_service, if: -> { ActiveStorage::Blob.service.is_a?(ActiveStorage::Service::DiskService) }
    end

    private

    def set_current_host_for_disk_service
      ActiveStorage::Current.host = request.base_url
    end
  end
end