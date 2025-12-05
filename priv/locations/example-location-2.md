#   /priv/locations/example-location.md
#
#   This File repersents a single location seen in the footer of all pages.
#   You can have one or many locations
#
#   name - Location Name
#
#   street - The street address of the location
#
#   city_state - A string that respersends the second half of the address line
#
#   phone - The phone number of the location
#
#   email - The email address of the location
#
#   hours - A list of strings that can be used to list hours of operation
#
#   image - Optional. Path to an image for this location (e.g., storefront photo, map, etc.)
#
#   The body - Everything below the --- will be treaded as Markdown text and converted to standard html
#   Note - to learn more about markdown formating please review https://www.markdownguide.org/
#   Warning - Its advised to keep this short and simple for the location.


%{
  name: "Main Street Location",
  street: "123 SE Main St",
  city_state: "Portland, OR 97202, USA",
  phone: "(555) 123-4567",
  email: "hello@localcafe.org",
  hours: ["Mon-Fri: 8am - 8pm", "Sat-Sun: 9am - 9pm"]
}
---

Our flagship location in the heart of downtown. Come visit us for fresh, delicious food in a cozy atmosphere!
