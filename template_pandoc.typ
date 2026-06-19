// ===========================================================================
//  Pandoc Typst template — adaptado do template "project" do João.
//  Uso:
//    pandoc notas.md -o notas.pdf --pdf-engine=typst --template=joao-notes.typ
//  Metadados (no YAML do markdown):  title, author (lista), date, abstract, lang
// ===========================================================================

// --- Pacotes (descarregados do registry @preview na 1.ª compilação) --------
//#import "@preview/hydra:0.6.2": hydra                          // Package for headers
#import "@preview/physica:0.9.7": *                            // Package to write physics and math better
#import "@preview/typsium:0.3.1": *                            // Package for chemical equations
#import "@preview/unify:0.7.1": num, numrange, qty, qtyrange   // for units

// --- Definições exigidas pela saída Typst do pandoc -----------------------
//  (blockquote, horizontalrule, endnote são referenciadas pelo corpo gerado)
#let blockquote(body) = [
  #set text( size: 0.92em )
  #block(inset: (left: 1.5em, top: 0.2em, bottom: 0.2em))[#body]
]

#let horizontalrule = [
  #line(start: (25%,0%), end: (75%,0%))
]

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms: it => {
  it.children
    .map(child => [
      #strong[#child.term]
      #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
      ])
    .join()
}

// --- Função de estilo (o teu "project", praticamente igual) ----------------
#let project(
  title: none,
  abstract: none,
  authors: (),
  date: none,
  lang: "pt",
  body,
) = {
  set page(
    margin: (left: 30mm, right: 30mm, top: 30mm, bottom: 30mm),
    header: context {
      if counter(page).get().first() > 1 {
        // To prevent header in first page
        emph(title) // Name of heading in header (only 2 level heading) on the left
        h(1fr)
        counter(page).display("1") // Page number on the right
        line(length: 100%) // Line below header
      }
    },
  )
  set text(font: "Libertinus Serif", lang: lang)

  // Title row.
  if title != none {
    align(left)[
      #block(text(weight: 700, 1.5em, title))
      #v(1em, weak: true)
      // Author information.
      #if authors.len() > 0 {
        pad(
          top: 0.5em,
          grid(
            columns: (1fr,) * calc.min(3, authors.len()),
            gutter: 1em,
            ..authors.map(author => align(left, strong(author))),
          ),
        )
      }
      #date
      #v(1.5em, weak: true)
    ]
    line(length: 100%, stroke: 1pt + gray)
  }

  // Main body.
  set par(justify: true, first-line-indent: (amount: 1em, all: false)) // para alterar espaçamento entre linhas, utilizar leading: 0.52em (default)
  // Numbered equations
  set math.equation(numbering: "(1)", number-align: right, supplement: [Eq.])
  // Table caption position
  show figure.where(kind: table): set figure.caption(position: top)
  // Custom table appearance
  show table.cell.where(y: 0): set text(weight: "bold")
  set table(
    stroke: none,
    gutter: 0.2em,
    fill: (x, y) => if calc.even(y) == false { gray.transparentize(80%) },
    row-gutter: 0em,
    column-gutter: 0em,
  )
  set enum(indent: 1.5em)
  set list(indent: 1.5em)
  set heading(numbering: "1.1.")
  show heading: set block(above: 1.5em, below: 1em)
  show heading.where(level: 1): set block(above: 2em, below: 1em)
  let h1-seen = state("h1-seen", false)
  show heading.where(level: 1): it => {
    if it.outlined {
      context {
        if h1-seen.get() {
          pagebreak(weak: true)
        }
      }
      h1-seen.update(true)
    }
    it
  }

  // Abstract — só é renderizado se for fornecido
  if abstract != none {
    {
      show heading: set block(above: 0em, below: 0em)
      show heading.where(level: 1): set block(above: 1em, below: 1em)
      heading(outlined: false, numbering: none, text(0.85em, smallcaps[Abstract]))
    }
    abstract
    v(1.5em, weak: true)
    line(length: 100%, stroke: 1pt + gray)
  }

  body
}

// --- Metadados do documento (texto simples, p/ propriedades do PDF) --------
//  Nota: usa o texto simples do título/autores. Se o título contiver markup
//  (ex.: *itálico*) ou aspas, ajusta aqui manualmente.
#set document(
$if(title)$
  title: "$title$",
$endif$
$if(author)$
  author: ($for(author)$"$author$", $endfor$),
$endif$
)

// --- Aplica o estilo a todo o documento ------------------------------------
#show: doc => project(
$if(title)$
  title: [$title$],
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(abstract)$
  abstract: [$abstract$],
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
  authors: ($for(author)$[$author$], $endfor$),
  doc,
)

$for(header-includes)$
$header-includes$

$endfor$
$for(include-before)$
$include-before$

$endfor$
$if(toc)$
#outline(
  title: auto,
  depth: none,
);
$endif$

$body$

$for(include-after)$

$include-after$
$endfor$
