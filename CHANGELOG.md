[0.1.1] - 2019-11-26
  * Bug fix release to actually work in rails ¯\_(ツ)_/¯

[0.1.0] - 2019-11-25
  * Support controller inheritance

[0.0.7] - 2014-08-25
  * Breaking change part 2: restrict without action names will now implicitly restrict all actions
  * :all_actions modifier is gone

[0.0.6] - 2014-08-25
  * Breaking change: use :unless instead of :allow_if

[0.0.4] - 2014-08-23
  * Bugfixes
  * Multiple restrictions for the same action are possible

[0.0.3] - 2014-08-23
  * Added railtie to require controller extension instantly
  * Added :all_actions matcher
  * Configuration for authentication_validation_method

[0.0.1] - 2014-08-21 Initial import
  * Includes plain and conditional restrictions
  * ..and RSpec matcher
