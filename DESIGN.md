# Design

`deadman` is a [dead man's switch](https://en.wikipedia.org/wiki/Dead_man%27s_switch) making use of modern cryptography to share secrets among trustees on an untimely death or other means of switch activation such as the compromise of a machine running in supervision mode.

### Users/user terminology

### Terminology
* `supervision` - when a user/agent wants to be monitored and actively has the deadman agent looking for deauthentication/triggers
* `participant` - any entity involved in the protocol, this includes dealers and trustees; both human and not
#### Users
* `dealer` - the entity with a secret to be shared or with knowledge to be distributed upon failure to check in with the switch
* `trustee` - the participants in the protocol that will receive the secret from the dealer
#### Technical/detailed
A dealer distributes a secret to `n` trustees by breaking apart the secret in a way that can only be reconstructed after the switch is triggered and a threshold number of shares are released for reconstruction. The participants of the protocol can prove the sharebox can be decrypted with their keys using a zero-knowledge proof. The participants in this protocol can be humans, or even machines. Participants are all participating to a publicly verifiable secret-sharing scheme. Again, the shares are signed. Each participant's share will be paired with a proof to verify ownership with math to uphold claims in a court of law. Any participant can verify 

This service knows nothing about its users except the participants' public keys, data is end-to-end encrypted. To ensure all requests are verified from the specified user, they must use HTTP signature authentication. We can verify ownership of the request based on their signature which requires use of their private key - again, client-side. Again, within the math of the protocol - a zero-knowledge proof is used to verify the participant still knows their private key. All requests sent to clients will be signed as our authoritative service. 
### Context
The problem this software aims to solve is getting information to necessary entities at end-of-life or upon compromise. A secure protocol is needed for this to happen. Furthermore, rigid math problems should define the validity of each message/transaction/participant.

This project has several emergent sub-projects. The first is an agent for passive-behavioral-authentication from a mobile device. This will be a separate project and generic as I plan to sell a working implementation fintech and government agencies. The second will be an agent for machines that will trigger from indicators of compromise. This whole second project can become a second security company.
## Goals/non-goals
### Goals
* Non-interactive switch activation via mobile agent or machine compromise agent.
* Interactive voting between participants.
* Zero-knowledge proofs in cryptography to provide proofs (for court and sanity of participants)
	* Of private key ownership
	* Proof of a decryptable sharebox
	* Proof of ownership for a decrypted share
* Anonymity for users
* Finite state machine for events that can happen in a secret's lifetime
* Finite state machine for malice detection engine
* HTTP signed requests/responses
* Event log in ELF
* UI graph of interactions with secret
* Stamp this evidence in the blockchain
- SSR for Tor service - no JavaScript allowed
- All private key interactions happen client-side
### Non-goals
* Anything outside the goals described above
* Disclosure of this until I figure out how to patent
### Milestones
* Smoke-testable
	* Raw net/http server or lightweight router like Chi stood up in Golang
	* Modify go-pvss to use ED25519 instead of secp256k
	* HTTP signature authentication for back end
	* Core front end cryptography library created
	* Core front end passive behavioral authentication library created
	* React front end created for web
	* React-native created for mobile
	* All components are talking to each other and pass smoke-testing with unit testing frameworks set up
	* Separate Tor project with SSR created
* Participants
	* CREATE participant
		* Provides public key
	* DELETE participant
		* If voting occurred and participant was found to be malicious
		* Deleted by dealer
	* UPDATE participant
		* public key
	* READ participant
		* By ID
		* By public key
	* READ participants
		* Member of specified secret
	* React Native view
	* React view
* Secrets
	* CREATE secret
		* Must provide hash of unencrypted data
		* Must provide the threshold number of participants
		* Must provide how many participants are to be invited
		* Must create entries in `invites` table to show when users have used the invite and joined the protocol
	* UPDATE secret
		* Hash of unencrypted data
		* Threshold
		* Number of participants
		* Must redistribute shares in secret is not waiting on a valid number of participants
	* DELETE secret
		* By ID
		* Can only be deleted by secret owner
	* READ secret
		* By ID
		* By hash
	* READ secrets
		* By requestor's participant ID - can't read into others' secrets but can see all of their own/they participate in.
	* React Native view
	* React view
* Invites
	* DELETE invite
		* When adjusting secret
	* UPDATE invite
		* Create participant with public key provided
		* Accept invite and deactivate it
		* Assign ownership to new participant
	* READ invites
		* Get invite list upon secret creation, secret modification
	* React Native view
	* React view
- Non-interactive mobile agent
	- Read sensor data
	- Experiment and research aggregating behavioral biometric methods to find a reasonable statistic that can train online as the user ages, acquires a new limp, etc.
- Machine compromise agent
	- Define indicators of compromise
	- Hook into other IDS/IPS, etc.
- Solidity contract to stamp event logs onto the blockchain
- Hidden service with SSR
## Threat model
* Protect participants from being able to know about each other
* Protect from voting behavior that may indicate the group is trying to release the secret early
* Protect server key for signatures or create a key escrow/federation system for multiple nodes
* Protect from another person keeping you alive by trying to keep you alive by taking your phone
* Protect secret from being blocked last minute exits from protocol that went under the threshold.
* Protect online learning of model to not adapt slowly to a different user, must be very precise on many behavioral biometrics.
