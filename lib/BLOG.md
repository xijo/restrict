Let's assume the following controller:

```ruby
class GoodiesController < ApplicationController

  def delete
    # Remove all the goodies
  end
end
```

You want to protect that controller action, the normal way is: write a before_filter to check and redirect.

This is what `denied` does for you
