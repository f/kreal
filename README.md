# Kreal

Kreal is a realtime model sharing front-end framework built on Kemal [Kemal](http://github.com/sdogruyol/kemal) seamlessly.

## Overview

At back-end:

```crystal
require "kreal"

class Hello
  share :world

  def self.world(args)
    "Hello World!"
  end
end

kreal Hello

# Enable simple debugging interface.
debug_kreal

# Rest of your Kemal app...
get "/" do
  "My Index Page"
end
```

At front-end:

Add this to your scripts:
```html
<script src="/scripts/kreal.js"></script>
```

Call your back-end methods via **Kreal** magically.
```js
var kr = new Kreal()
kr.connect(function (models) {
  models.Hello.world(result => console.log(result)) // "Hello World!
});
```

## Strange Examples

Let's build a simple **OS bridge**!

```crystal
class OSBridge
  share :run

  def self.run(args)
    `#{args[0]}`
  end
end

kreal OSBridge
```

Done!

Now use it from your JavaScript! 👌

![Imgur](http://i.imgur.com/GxTatWD.png)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  kreal:
    github: f/kreal
```

## Usage

```crystal
require "kreal"

# Write your models with shared methods.

kreal YourModel1, YourModel2 #,... Register your models to kreal.

debug_kreal # Run debugging interface at "/kreal" path.
```

## Contributing

1. Fork it ( https://github.com/f/kreal/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [@f](https://github.com/f) Fatih Kadir Akın - creator, maintainer
