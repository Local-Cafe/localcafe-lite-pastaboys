#   /priv/menu/example-item.md
#   This File repersents a menu item as seen on the home page and also as a single show page for this given item.
#   * Note It's url path will be created based on its file name so be mindful when naming these files and replace spaces with -
#   Example: `example-item.md` will result in the url of `/menu/example-item.html` for the browser.
#
#   Title - Page title and H1 tag on the show view
#
#   Price - A single price or a key value price in a list example ["Small Drink": "$4.50", large: "$5.50"]
#   * Note the different forms of lables on the price.
#
#   Tags - A list of strings that repersent a tag
#
#   Description - A short description that will be seen on the home page card and on the top of the menu item's show view
#
#   Image - a image path relative to the domain
#   * Note the domain is set in the /priv/home.md *
#
#   Position - a index used to order the menu items. The order is in asscending order, IE starting at 0 and counting out.
#   * Note - You can have many items on the same position and the secondary order is based on the title. *
#
#   The body - Everything below the --- will be treaded as Markdown text and converted to standard html
#   * Note - to learn more about markdown formating please review https://www.markdownguide.org/


%{
  title: "Tea",
  prices: "$3.99",
  tags: ["drink", "cold"],
  description: "Espresso is a concentrated coffee drink made by forcing hot, high-pressure water through finely-ground coffee beans.",
  image: "/images/example-item.png",
  position: 0
}
---

## This is a H2 tag

Ed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.

### This is a H3 tag

Sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.

* Some list item 1
* Some list item 2
* Some list item 3

basic [link](https://example.com)

> Some quote
