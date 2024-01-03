module Cross
  module Platform
    def self.get(os, arch)
      if os == "linux"
        "#{os}/#{parse_arch(arch)}"
      else
        Cross::Err::invalid_os(os)
      end
    end

    def self.parse_arch(arch)
      if arch == "x86_64"
        "amd64"
      else
        arch
      end
    end
  end
end

