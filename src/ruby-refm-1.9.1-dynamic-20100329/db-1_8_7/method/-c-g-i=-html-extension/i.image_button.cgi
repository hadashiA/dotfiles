kind=defined
names=image_button
visibility=public

--- image_button(src = "", name = nil, alt = nil)
       
        Œ„°ß
        image_button("url")
          # <INPUT TYPE="image" SRC="url">

        image_button("url", "name", "string")
          # <INPUT TYPE="image" SRC="url" NAME="name" ALT="string">

        image_button({ "SRC" => "url", "ALT" => "string" })
          # <INPUT TYPE="image" SRC="url" ALT="string">

