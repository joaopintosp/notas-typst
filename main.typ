// Import the template
#import "template.typ": *

// Additional packages
// #import "@preview/chemformula:0.1.1": ch // For writing chemical equations with #ch()

// Preamble
#show: project.with(
  title: "Template",
  authors: (
    (
      name: "João Sá Pereira",
      email: "up201906772@up.pt",
      affiliation: "DECG - Faculdade de Engenharia da Universidade do Porto",
    ),
  ),
  date: [
    #d.day() de #meses.at(d.month() - 1) de #d.year()
  ],
  // or manual date
  // date: "10 de dezembro de 2025",
)

// Body

= Introduction
#lorem(60)

== In this paper
#lorem(20)

=== Contributions
#lorem(40)

= Related Work
#lorem(500)

// Uncomment next line for bibliography
// #bibliography("references.bib", style: "american-psychological-association", full: true)
