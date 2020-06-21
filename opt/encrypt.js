// https://developer.github.com/v3/actions/secrets/#create-or-update-a-repository-secret

const sodium = require('tweetsodium');

const key = process.argv[2];
const value = process.argv[3];

// Convert the message and key to Uint8Array's (Buffer implements that interface)
const messageBytes = Buffer.from(value);
const keyBytes = Buffer.from(key, 'base64');

// Encrypt using LibSodium.
const encryptedBytes = sodium.seal(messageBytes, keyBytes);

// Base64 the encrypted secret
const encrypted = Buffer.from(encryptedBytes).toString('base64');

console.log(encrypted);
