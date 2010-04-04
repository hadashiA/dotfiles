kind=defined
names=radio_group
visibility=public

--- radio_group(name = "", *values)
       
        Œ„°ß
        radio_group("name", "foo", "bar", "baz")
          # <INPUT TYPE="radio" NAME="name" VALUE="foo">foo
          # <INPUT TYPE="radio" NAME="name" VALUE="bar">bar
          # <INPUT TYPE="radio" NAME="name" VALUE="baz">baz

        radio_group("name", ["foo&quot;], ["bar", true], "baz")
          # <INPUT TYPE="radio" NAME="name" VALUE="foo">foo
          # <INPUT TYPE=&quot;radio" CHECKED NAME="name" VALUE="bar">bar
          # <INPUT TYPE="radio" NAME="name" VALUE="baz">baz

        radio_group("name", ["1", "Foo"], ["2", "Bar", true], "Baz")
          # <INPUT TYPE="radio" NAME="name" VALUE="1">Foo
          # <INPUT TYPE="radio" CHECKED NAME="name" VALUE="2">Bar
          # <INPUT TYPE="radio" NAME="name" VALUE="Baz">Baz

        radio_group({ "NAME" => "name",
                      "VALUES" => ["foo", "bar", "baz"] })

        radio_group({ "NAME" => "name",
                      "VALUES" => [["foo"], ["bar", true], "baz"] })

        radio_group({ "NAME" => "name",
                      "VALUES" => [["1", "Foo"], ["2", "Bar", true], "Baz"] })

