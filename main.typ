// Import the template
#import "template.typ": *

// Additional packages
// #import "@preview/chemformula:0.1.1": ch // For writing chemical equations with #ch()
// #import "@preview/note-me:0.6.0": * // For adding callouts GitHub style with #note[], #tip[], #warning[]...

// Preamble
#show: project.with(
  title: "Title",
  authors: (
    "author",
  ),
  // abstract: lorem(59),
  date: "date",
)

= Introduction

#lorem(300)

== Description

#lorem(100)

=== Motivations

#lorem(400)

// Uncomment next line for bibliography
// #bibliography("references.bib", style: "american-psychological-association", full: true)
