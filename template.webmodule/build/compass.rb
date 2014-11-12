# main Compass configuration for building SCSS

# compass/import-once/activate guarantee expected @import behavior for SASS instead @import=="@include" by default
require 'compass/import-once/activate'

# Require any additional compass plugins here.

# Set this to the root of your project when deployed:
http_path = "/"
css_dir = (environment == :production) ? "css" : "css-src"
sass_dir = "scss"
images_dir =  "img"
fonts_dir = "fonts"
javascripts_dir = (environment == :production) ? "js" : "js-src"

http_images_dir = "img"
http_fonts_dir = "fonts"
http_stylesheets_path = "/css"
http_javascripts_path = "/js"

# we have fixed structure inside module, but it must can be supplyed to other root
relative_assets = true

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed
output_style = (environment == :production) ? :compressed : :expanded

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false


sourcemap = environment == :production

