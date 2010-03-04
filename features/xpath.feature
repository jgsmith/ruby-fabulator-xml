Feature: XPath evaluation

  Scenario: Get the value of an element
    Given a context
      And the prefix f as "http://dh.tamu.edu/ns/fabulator/1.0#"
      And the prefix x as "http://dh.tamu.edu/ns/fabulator/xml/1.0#"
    When I run the expression (x:xpath(x:parse-string("<foo><bar>baz</bar></foo>"), "/foo/bar"))
    Then I should get 1 item
      And item 0 should be ['baz']

  Scenario: Get the value of an element without prior parsing
    Given a context
      And the prefix f as "http://dh.tamu.edu/ns/fabulator/1.0#"
      And the prefix x as "http://dh.tamu.edu/ns/fabulator/xml/1.0#"
    When I run the expression (x:xpath("<foo><bar>baz</bar></foo>", "/foo/bar"))
    Then I should get 1 item
      And item 0 should be ['baz']

  Scenario: Get the value of an element without prior parsing
    Given a context
      And the prefix f as "http://dh.tamu.edu/ns/fabulator/1.0#"
      And the prefix x as "http://dh.tamu.edu/ns/fabulator/xml/1.0#"
    When I run the expression (let $d := x:document("<foo><bar>baz</bar></foo>"); x:xpath($d, "/foo/bar"))
    Then I should get 1 item
      And item 0 should be ['baz']
