// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(title: "", authors: (), subtitle: none, body, toc: true) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "New Computer Modern", lang: "fr")
  set heading(numbering: "1.1.")
  show math.equation: set text(weight: 400)

  // Title row.

  grid(
    columns: 2,
    [#align(left + horizon, image("logo.png", width: 70%))],
    [#align(right + horizon, image("INP_N7.png", width: 110%))],
  )
  v(10%)
  align(center)[
    #line(length: 95%, stroke: black)
    #block(text(weight: 700, 1.75em, title))

    #line(length: 95%, stroke: black)
    #subtitle

  ]
  v(15%)
  pad(top: 0.5em, bottom: 0.5em, x: 2em, grid(
    columns: (1fr,) * calc.min(3, authors.len()),
    gutter: 1em,
    ..authors.map(author => align(center, strong(author))),
  ))
  // Author information.

  pagebreak()
  if toc {
    outline(depth: 2, indent: true)

    pagebreak()
  }
  // Main body.
  set par(justify: true)

  body
}