# Create pinger
class KrealHelp
  share :ping, :example

  def self.example(args)
    <<-HOWTO
    require "kemal"
    require "kreal"

    class Example
      share :hello_world

      def self.hello_world(args)
        "Hello \#{args[0]}!"
      end
    end

    kreal KrealPing

    Kemal.run
    ---
    crystal
    HOWTO
  end

  def self.ping(args)
    "pong"
  end
end

kreal KrealHelp

