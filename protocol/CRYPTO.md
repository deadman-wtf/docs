# Crypto

The protocol makes heavy use of elliptic curve cryptography through several algorithms.

### Publicly Verifiable Secret Sharing

The heart of this entire protocol is a publicly verifiable secret sharing algorithm. It allows participants of the protocol to act in secret/anonymously waiting for a secret to be released while retaining attestation as to the secret release's validity.

When the switch is activated, shares may be released and decrypted by their owners. When enough are released and decrypted to meet the protocol's threshold, they can reconstruct the original secret by the dealer as the switch has reached its end-of-life.

### Zero-Knowledge-Proofs

For proving that you know a secret without revealing the secret - this protocol uses a zero-knowledge-proof called DLEQ in several places.

1. Proving you own a private key
2. Proving the sharebox can be decrypted
3. Proving a decrypted share came from the protocol.

### HTTP Signature Auth

For signing each request and verifying origins by private-key; the protcol uses HTTP signatures to/from the server for all operations outside of joining the platform. Your key is your authentication and we never want to know it. The ED25519 key gets passed from signature auth, to a query for your key identifier, your public key is then passed to the publicly verifiable secret sharing scheme for any operations or zero-knowledge-proofs. 