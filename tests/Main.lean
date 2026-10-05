import LeanOntology
open Ontology

private def check (label : String) (ok : Bool) : IO Unit := do
  unless ok do throw (IO.userError s!"FAIL: {label}")
  IO.println s!"ok: {label}"

private def roundTrip [Wire α] [BEq α] (value : α) : Bool :=
  match (Wire.codec (α := α)).decode ((Wire.codec (α := α)).encode value) with
  | .ok decoded => decoded == value
  | .error _ => false

private def accepts (v : Validation α) : Bool := match v with | .ok _ => true | .error _ => false

def main : IO Unit := do
  check "email: canonical form is accepted" (accepts (Email.parse "asha@example.com"))
  check "email: missing domain is rejected" (!accepts (Email.parse "asha@"))
  check "name: blank is rejected" (!accepts (Name.parse "   "))
  check "title: accepted" (accepts (Title.parse "Housewarming"))
  check "instant: RFC 3339 on the wire" ((parseRfc3339? "2026-10-17T19:00:00Z").isSome)
  check "instant: RFC 3339 round trip" ((parseRfc3339? "2026-10-17T19:00:00Z").map formatRfc3339 == some "2026-10-17T19:00:00Z")
  check "instant: garbage is rejected" ((parseRfc3339? "yesterday").isNone)
  check "nat: wire round trip" (roundTrip (42 : Nat))
  check "string list: wire round trip" (roundTrip ["a", "b"])
  match Email.parse "asha@example.com" with
  | .ok email => check "email: wire round trip" (roundTrip email)
  | .error _ => throw (IO.userError "FAIL: email parse")
