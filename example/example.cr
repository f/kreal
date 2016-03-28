require "../src/kreal"

class Todos
  share_class_methods :create, :get

  def self.file
    "./example/todos.txt"
  end

  def self.read
    File.read(file).chomp
  end

  def self.create(args)
    File.write(file, "#{read}\n- #{args[0]}")
    "#{args[0]} added."
  end

  def self.get(args)
    read
  end
end

kreal Todos

Kemal.run
