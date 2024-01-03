module Cross
  module Err
    def self.invalid_os(os)
      raise "Invalid os #{os}"
    end

    def self.invalid_tool(tool)
      raise "Invalid tool #{tool}"
    end
  end
end

