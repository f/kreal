<img src="https://cdn.rawgit.com/f/kreal/master/assets/logo.svg" width="90">

# Kreal

Kreal is a model sharing & RPC library built on and works with [Kemal](http://github.com/sdogruyol/kemal) seamlessly with slick debugging interface.

![Debug](http://i.imgur.com/mNWxlg5.png)

## Short Tutorial

### 1. Create your remote models.

```crystal
# 1. Load Kreal!
require "kreal"

# 2. Create your class
class Maths
  # Share your method to call remotely
  share :square

  # Remote method must have arguments.
  def self.square(args)
    args[0] * args[0]
  end
end

# Register your remote procedure
kreal Maths

# Rest of your Kemal app...
get "/" do
  # do not forget to load scripts/kreal.js
end

# Do not forget to run Kemal.
Kemal.run
```

### 2. Use your models via JavaScript API.

Add this to your scripts:
```html
<script src="/scripts/kreal.js"></script>
```

Call your remote methods via **Kreal** magically.
```js
(new Kreal).connect(function (KR) {

  // Call your function with a callback!
  KR.Maths.square(2, function (result) {
    console.log(result); // "Hello World!
  });

});
```

## Kreal Debugger

Kreal debugger enables itself when Kemal is on debug mode.

```
crystal build src/yourapp.cr

# Use the parameters of Kemal since it's built on Kemal.
yourapp -e development
[development] Kemal is ready to lead at http://0.0.0.0:3000
```

Now you have a debugging view at [http://0.0.0.0:3000/kreal](http://0.0.0.0:3000/kreal)

### Let's build a simple example

Let's build a simple **OS bridge**!

```crystal
class OSBridge
  share :run

  def self.run(args)
    # Run command at os.
    `#{args[0]}`
  end
end

kreal OSBridge
```

Done!

Now use it from your JavaScript! 👌

<img src="http://i.imgur.com/GxTatWD.png" width="550">

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  kreal:
    github: f/kreal
```

## Contributing

1. Fork it ( https://github.com/f/kreal/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [@f](https://github.com/f) Fatih Kadir Akın - creator, maintainer
