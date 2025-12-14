// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(title: "", authors: (), date: none, body) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)

  set page(
    margin: (left: 25mm, right: 25mm, top: 30mm, bottom: 30mm),
    header: context {
      let selector = selector(heading).before(here())
      let level = counter(selector)
      let headings = query(selector)

      if headings.len() == 0 {
        return
      }

      let heading = headings.last()

      emph(level.display(heading.numbering))
      h(0.5em)
      emph(heading.body)
      h(1fr)
      counter(page).display("1")
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
  set par(justify: true) // para alterar espaçamento entre linhas, utilizar leading: 0.52em (default)

  // Numbered equations
  set math.equation(numbering: "(1)", number-align: right, supplement: [Eq.])

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
