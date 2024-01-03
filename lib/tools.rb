module Cross
  module Toolchain
    module Clang
      def self.image(os, arch)
        case os
        when "linux"
          "clang-linux-gnu:#{Cross::Platform::parse_arch(arch)}-latest"
        else
          Cross::Err::invalid_os(os)
        end
      end

      def self.run(tool, os, arch, args)
        system %(#{Cross::CONTAINER_MANAGER} run \
          --rm \
          --platform #{Cross::Platform::get(os, arch)} \
          #{Clang::image(os, arch)} \
          #{tool} #{Cross::Tool::parse_args(args)})
      end
      
      require 'securerandom'

      Instance = Struct.new(:name) do
        def self.get(name)
          Instance.new(name)
        end

        def self.start(os, arch)
          image = Cross::Toolchain::Clang::image(os, arch)
          name = "cross-#{SecureRandom.uuid}"
          platform = Cross::Platform::get(os, arch)
          # puts "Started intance #{name} for platform #{platform} with image #{image}"
          system "#{Cross::CONTAINER_MANAGER} run \
            --platform #{platform} \
            --name #{name} \
            -d -i -t \
            #{image}"
          return Instance.new(name)
        end

        def exec(args)
          # a = [Cross::CONTAINER_MANAGER, "exec", self.name, *args]
          # a = a.map { |a| a.to_s }
          # p a
          system Cross::CONTAINER_MANAGER,
            "exec",
            self.name,
            *args
        end

        def stop
          system "#{Cross::CONTAINER_MANAGER} stop #{self.name} --time 1"
        end
      end
    end
  end

  module Tool
    def self.get_toolchain(tool)
      case tool
      when "clang", "clang++", "ar"
        return Cross::Toolchain::Clang
      else
        Cross::Err::invalid_tool(tool)
      end
    end

    def self.get_env_name(tool_name)
      case tool_name
      when "clang" then "CC"
      when "ar" then "AR"
      when "clang++" then "CXX"
      end
    end

    # deprecated
    def self.parse_args(args)
      args.map { |a| "\"#{a}\"" }.join(" ")
    end
  end
end
