module Cross
  CONTAINER_MANAGER=ENV["CONTAINER_MANAGER"]||"podman"
end

require 'error'
require 'platform'
require 'tools'

