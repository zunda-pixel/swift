// RUN: %target-typecheck-verify-swift -Wwarning EmbeddedRestrictions -verify-additional-prefix none-
// RUN: %target-typecheck-verify-swift -Wwarning EmbeddedRestrictions -sanitize=address -verify-additional-prefix address-
// RUN: %target-typecheck-verify-swift -Wwarning EmbeddedRestrictions -sanitize=thread -verify-additional-prefix thread-

// REQUIRES: swift_feature_Embedded

// Whether a diagnostic location is active when compiling Embedded Swift is
// determined with a separate evaluation of '#if' conditions, which must also
// understand 'moduleInstrumentation'.

protocol Q: AnyObject {
  func f<T>(_ t: T)
}

#if moduleInstrumentation(address)
func addressOnly(q: any Q) {
  q.f(1) // expected-address-warning {{cannot use generic instance method 'f' on a value of type 'any Q' in Embedded Swift}}
}
#endif

#if moduleInstrumentation(thread)
func threadOnly(q: any Q) {
  q.f(1) // expected-thread-warning {{cannot use generic instance method 'f' on a value of type 'any Q' in Embedded Swift}}
}
#endif
