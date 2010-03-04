@types
Feature: Type unification

  Scenario: A single type
    Given the prefix f as "http://dh.tamu.edu/ns/fabulator/1.0#"
      And the prefix x as "http://dh.tamu.edu/ns/fabulator/xml/1.0#"
    When I unify the types f:string, x:document
    Then I should get the type f:string

  Scenario: Get the type of a parsed string value
    Given a context
      And the prefix f as "http://dh.tamu.edu/ns/fabulator/1.0#"
      And the prefix x as "http://dh.tamu.edu/ns/fabulator/xml/1.0#"
    When I run the expression (x:parse-string("<foo />")/@type)
    Then I should get 1 item
      And item 0 should be [f:uri-prefix('x') + 'document']

  Scenario: Get the type of a parsed string value
    Given a context
      And the prefix f as "http://dh.tamu.edu/ns/fabulator/1.0#"
      And the prefix x as "http://dh.tamu.edu/ns/fabulator/xml/1.0#"
    When I run the expression (x:document("<foo />")/@type)
    Then I should get 1 item
      And item 0 should be [f:uri-prefix('x') + 'document']

  Scenario: Get the value of an element
    Given a context
      And the prefix f as "http://dh.tamu.edu/ns/fabulator/1.0#"
      And the prefix x as "http://dh.tamu.edu/ns/fabulator/xml/1.0#"
    When I run the expression (x:path(x:parse-string("<foo><bar>baz</bar></foo>"), "/foo/bar")/@type)
    Then I should get 1 item
      And item 0 should be [f:uri-prefix('x') + 'node']

