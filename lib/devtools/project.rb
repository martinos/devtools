module Devtools
  # The project devtools supports
  class Project
    include Adamantium

    # Return project root
    #
    # @return [String] root
    #
    # @api private
    #
    attr_reader :root

    # Initialize object
    #
    # @param [Pathname] root
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(root)
      @root = root
    end

    # Return shared gemfile path
    #
    # @return [String]
    #
    # @api private
    #
    def shared_gemfile_path
      root.join('Gemfile.devtools')
    end
    memoize :shared_gemfile_path

    # Return lib directory
    #
    # @return [String]
    #
    # @api private
    #
    def lib_dir
      root.join('lib')
    end
    memoize :lib_dir

    # Return file pattern
    #
    # @return [String]
    #
    # @api private
    #
    def file_pattern
      lib_dir.join('**/*.rb')
    end
    memoize :file_pattern

    # Return spec root
    #
    # @return [Pathname]
    #
    # @api private
    #
    def spec_root
      root.join('spec')
    end
    memoize :spec_root

    # Setup rspec
    #
    # @return [self]
    #
    # @api private
    #
    def setup_rspec
      require 'rspec'
      Devtools.require_shared_examples
      require_shared_examples_and_support
      prepare_18_specific_quirks
    end

    # Return config directory
    #
    # @return [String]
    #
    # @api private
    #
    def config_dir
      root.join('config')
    end
    memoize :config_dir

    # Return flog configuration
    #
    # @return [Config::Flog]
    #
    # @api private
    #
    def flog
      Config::Flog.new(self)
    end
    memoize :flog

    # Return roodi configuration
    #
    # @return [Config::Roodi]
    #
    # @api private
    #
    def roodi
      Config::Roodi.new(self)
    end
    memoize :roodi

    # Return yardstick configuration
    #
    # @return [Config::Yardstick]
    #
    # @api private
    #
    def yardstick
      Config::Yardstick.new(self)
    end
    memoize :yardstick

    # Return flay configuration
    #
    # @return [Config::Flay]
    #
    # @api private
    #
    def flay
      Config::Flay.new(self)
    end
    memoize :flay

    # Return mutant configuration
    #
    # @return [Config::Mutant]
    #
    # @api private
    #
    def mutant
      Config::Mutant.new(self)
    end
    memoize :mutant

  private

    # Require shared examples and spec support
    #
    # Requires all files in $root/spec/{shared,support}/**/*.rb
    #
    # @return [self]
    #
    # @api private
    #
    def require_shared_examples_and_support
      Dir[spec_root.join('{shared,support}/**/*.rb')].each { |file| require(file) }
      self
    end

    # Prepare spec quirks for 1.8 
    #
    # @return [self]
    #
    # @api private
    #
    def prepare_18_specific_quirks
      if Devtools.ruby18?
        require 'rspec/autorun'
      end

      self
    end

  end
end
