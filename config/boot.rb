ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

# Agrega esta línea para requerir el Logger del estándar de Ruby
require 'logger'

require 'bundler/setup' # Configura las gemas listadas en el Gemfile.
require 'bootsnap/setup'