# LeanOntology

Typed wire codecs and checked value types for Lean 4, shared by every layer of the Theoric stack:

- **[LeanDB](https://github.com/theoriclabs/LeanDB)** stores domain values with these codecs.
- **[LeanAPI](https://github.com/theoriclabs/leanapi)** sends them over HTTP.
- **[LeanReact](https://github.com/theoriclabs/lean-react)** decodes them in the browser.

It depends on nothing beyond Lean and Std, so it compiles for the browser too.

- `Ontology.Wire α` / `Ontology.Codec α`: a JSON codec with a schema, and decoding that reports where and why it failed.
- `Ontology.Validation`: typed validation results with paths.
- `Ontology.EntityId`, `Ontology.Descriptor`, `Ontology.Schema`: identities and descriptions of records and variants.
- `Ontology.Name`, `Title`, `Text`, `Email`, `Password`, `PasswordHash`, `Instant`: checked values whose only constructor is their parser (`Email.parse : String → Validation Email`).

```sh
lake build
lake exe leanontology_tests
```

Lean 4.33.0. MIT licensed.
