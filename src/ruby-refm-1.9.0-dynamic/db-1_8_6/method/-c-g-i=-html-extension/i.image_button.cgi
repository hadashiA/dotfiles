visibility=public
kind=defined
names=image_button

--- image_button(src = "", name = nil, alt = nil)
       
        �㡧
        image_button("url")
          # <INPUT TYPE="image" SRC="url">

        image_button("url", "name", "string")
          # <INPUT TYPE="image" SRC="url" NAME="name" ALT="string">

        image_button({ "SRC" => "url", "ATL" => "strng" })
          # <INPUT TYPE="image" SRC="url" ALT="string">
