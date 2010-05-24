Feature: XPath evaluation

  @1
  Scenario: Get the value of an element
    Given a context
      And the prefix f as "http://dh.tamu.edu/ns/fabulator/1.0#"
      And the prefix x as "http://dh.tamu.edu/ns/fabulator/xml/1.0#"
    When I run the expression (x:path(x:parse-string("<foo><bar>baz</bar></foo>"), "/foo/bar"))
    Then I should get 1 item
      And item 0 should be ['baz']

  Scenario: Get the value of an element without prior parsing
    Given a context
      And the prefix f as "http://dh.tamu.edu/ns/fabulator/1.0#"
      And the prefix x as "http://dh.tamu.edu/ns/fabulator/xml/1.0#"
    When I run the expression (x:path("<foo><bar>baz</bar></foo>", "/foo/bar"))
    Then I should get 1 item
      And item 0 should be ['baz']

  Scenario: Get the value of an element without prior parsing
    Given a context
      And the prefix f as "http://dh.tamu.edu/ns/fabulator/1.0#"
      And the prefix x as "http://dh.tamu.edu/ns/fabulator/xml/1.0#"
    When I run the expression (let $d := x:document("<foo><bar>baz</bar></foo>"); x:path($d, "/foo/bar"))
    Then I should get 1 item
      And item 0 should be ['baz']

  Scenario: Get the value of an element with namespaces
    Given a context
      And the prefix f as "http://dh.tamu.edu/ns/fabulator/1.0#"
      And the prefix x as "http://dh.tamu.edu/ns/fabulator/xml/1.0#"
    When I run the expression (x:path(x:parse-string("<g:foo xmlns:g='http://dh.tamu.edu/ns/fabulator/1.0#'><g:bar>baz</g:bar></g:foo>"), "/f:foo/f:bar"))
    Then I should get 1 item
      And item 0 should be ['baz']

