require "kemal"
require "dyncall"
require "./kreal/macros"
require "./kreal/helper"
# Require Paths
require "./kreal/client"
require "./kreal/server"

if Kemal.config.env == "development"
  # If env is dev, enable debug interface
  debug_kreal
end
