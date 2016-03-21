# Kreal

Kreal is a realtime model sharing front-end framework works
with (Kemal)[http://github.com/sdogruyol/kemal] seamlessly.

## Overview

At back-end:

```crystal
class Hello
  share :world

  def self.world(args)
    "Hello World!"
  end
end

kreal Hello
```

At front-end:

```js
var kr = new Kreal()
kr.connect(function (models) {
  models.Hello.world(function (result) {
    console.log(result) // "Hello World!"
  })
});
```

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
