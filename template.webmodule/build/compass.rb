# main Compass configuration for building SCSS

# compass/import-once/activate guarantee expected @import behavior for SASS instead @import=="@include" by default
require 'compass/import-once/activate'

# Require any additional compass plugins here.

# Set this to the root of your project when deployed:
sourcemap = true
http_path = "/"
css_dir = (environment == :production) ? "dist/css" : "src/css"
sass_dir = "./src/css"
images_dir =  "./dist/img"
fonts_dir = "./dist/fonts"
javascripts_dir = "./dist/js"
http_images_dir = "img"
http_fonts_dir = "fonts"
http_stylesheets_path = "/css"
http_javascripts_path = "/js"
Encoding.default_external = "utf-8"

# we have fixed structure inside module, but it must can be supplyed to other root
relative_assets = true

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed
output_style = (environment == :production) ? :compressed : :expanded

require "./hooks/aftercompass.rb"
__go()