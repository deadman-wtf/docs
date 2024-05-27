# Threat model

## What are we working on?

Finding weaknesses in the protocol, software, and operation of our software within the context of deadman.wtf

## What can go wrong?

* Participants knowing who eachother are (initiating biased voting)
* Participants teaming up to release a secret early (taking advantage of deauth that shouldn't activate switch)
* Key compromise
* Container/server compromise
* User gets key stolen
* Dealer gets key stolen
* A malicious actor takes a user's phone in supervision mode
* A user loses their phone in supervision mode
* Members of the protocol become inactive
* Members of the protocol dips below threshold
* Members block the release of a secret by exiting the protocol via previous method
* Slow retraining of online model by a malicious actor
* Hacked phone with malicious actor recording/replaying biometrics into driver
* Protect online learning of model to not adapt slowly to a different user, must be very precise on many behavioral biometrics.
* Decoding of passive-behavioral-auth model
* Insecure libraries
* Insecure containers
* Insecure configuration
* Insecure validation
* Insecure protocols
* Insider threat
