CREATE TABLE participants (
    id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    created TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated TIMESTAMPTZ,
    deleted TIMESTAMPTZ,
    public_key TEXT NOT NULL,

    -- TODO: Verify public key size
    CONSTRAINT CK_public_key CHECK (public_key ~ '^[a-fA-F0-9]{64}$')
);

CREATE TABLE secrets (
    id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    created TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated TIMESTAMPTZ,
    deleted TIMESTAMPTZ,
    expiry TIMESTAMPTZ,
    decrypted_digest TEXT NOT NULL,
    threshold INTEGER NOT NULL,
    num_invites INTEGER NOT NULL,
    public BOOLEAN NOT NULL DEFAULT FALSE,
    dealer_id UUID NOT NULL,

    FOREIGN KEY(dealer_id) REFERENCES participants(id),

    -- TODO: Verify public key size
    CONSTRAINT CK_decrypted_digest CHECK (decrypted_digest ~ '^[a-fA-F0-9]{64}$'),
    CONSTRAINT CK_threshold CHECK (threshold < num_invites),
    CONSTRAINT CK_expiry CHECK (expiry > created)
);

CREATE TABLE invites (
    id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    created TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted TIMESTAMPTZ,
    accepted_by UUID,

    FOREIGN KEY(accepted_by) REFERENCES participants(id),
    FOREIGN KEY(secret_id) REFERENCES secrets(id),
);

CREATE TABLE shares (
    id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    created TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated TIMESTAMPTZ,
    deleted TIMESTAMPTZ,
    owned_by UUID NOT NULL,
    secret_id UUID NOT NULL,

    FOREIGN KEY(owned_by) REFERENCES participants(id),
    FOREIGN KEY(secret_id) REFERENCES secrets(id)
);

CREATE TABLE votes (
    id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    created TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated TIMESTAMPTZ,
    deleted TIMESTAMPTZ,
    action TEXT NOT NULL,
    entity TEXT NOT NULL,
    initiated_by UUID NOT NULL,

    FOREIGN KEY(initiated_by) REFERENCES participants(id),

    CONSTRAINT CK_action CHECK (action ~ '^(REMOVE)|(ACTIVATE)'),
    CONSTRAINT CK_entity CHECK (entity ~ '^(SWITCH)|(TRUSTEE)$')
);

CREATE TABLE switches (
    id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    created TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated TIMESTAMPTZ,
    deleted TIMESTAMPTZ,
    state TEXT NOT NULL,
    secret_id UUID NOT NULL,

    FOREIGN KEY(secret_id) REFERENCES secrets(id),

    CONSTRAINT CK_state CHECK (state ~ '^(OPEN)|(HALF_OPEN)|(CLOSED)')
);