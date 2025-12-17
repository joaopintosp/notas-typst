// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!

// Packages to include by default
#import "@preview/hydra:0.6.2": hydra                          // Package for headers
#import "@preview/physica:0.9.7": *                            // Package to write physics and math better

#let project(title: "", authors: (), date: none, body) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)

  set page(
    margin: (left: 25mm, right: 25mm, top: 30mm, bottom: 30mm),
    header: context {
      if counter(page).get().first() > 1 {                      // To prevent header in first page
        emph(hydra(2))                                          // Name of heading in header (only 2 level heading) on the left
        h(1fr)
        counter(page).display("1")                              // Page number on the right
        line(length: 100%)                                      // Line below header
      }
    },
  )

  set text(font: "Libertinus Serif", lang: "pt")

  set heading(numbering: "1.1.", supplement: "Secção")
  show heading: set block(above: 2em, below: 1em) // espaçamento antes e depois dos cabeçalhos
  show heading.where(level: 1): set block(spacing: 2em) // espaçamento extra para cabeçalhos de nível 1

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #v(2em, weak: true)
    #date
  ]

  // Author information.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center)[
        *#author.name* \
        #author.email \
        #author.affiliation
      ]),
    ),
  )

  // Main body.
  set par(justify: true, first-line-indent: (amount: 1.5em, all: true)) // para alterar espaçamento entre linhas, utilizar leading: 0.52em (default)

  // Numbered equations
  set math.equation(numbering: "(1)", number-align: right, supplement: [Eq.])

  // Table caption position
  show figure.where(kind: table): set figure.caption(position: top)

  // Custom table appearance
  show table.cell.where(y: 0): set text(weight: "bold")
  // show table.cell.where(x: 0): set text(weight: "bold")
  set table(
    stroke: none,
    gutter: 0.2em,
    fill: (x, y) => if calc.even(y) == false { gray.transparentize(80%) },
    // inset: (x: 1em, y: 0.3em), // espaçamento entre texto e célula
    row-gutter: 0em,
    column-gutter: 0em,
  )

  body
}

#let d = datetime.today()
#let meses = (
  "janeiro",
  "fevereiro",
  "março",
  "abril",
  "maio",
  "junho",
  "julho",
  "agosto",
  "setembro",
  "outubro",
  "novembro",
  "dezembro",
)
