visibility=public
kind=added
names=pretty_print_inspect

--- pretty_print_inspect    -> ()
Is #inspect implementation using #pretty_print.
If you implement #pretty_print, it can be used as follows.

  alias inspect pretty_print_inspect

However, doing this requires that every class that #inspect is called on
implement #pretty_print, or a RuntimeError will be raised.

