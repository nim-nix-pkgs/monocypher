Monocypher for Nim
==================

Allows the [Monocypher] cryptography library to be used in [Nim]. Please refer
to its [manual] for detailed usage and security considerations.

### Examples

Create a secret key using the [sysrandom] library, and ensure that it is
erased from memory once it's no longer used:

```nim
import monocypher
import sysrandom

let secretKey = getRandomBytes(sizeof(Key))
defer: crypto_wipe(secretKey)
```

Exchange a shared symmetric key using public keys:

```nim
let yourPublicKey = crypto_key_exchange_public_key(secretKey)
let theirPublicKey = # obtain public key from other party
let sharedKey = crypto_key_exchange(secretKey, theirPublicKey)
defer: crypto_wipe(sharedKey)
```

Encrypt a message using a symmetric key:

```nim
let nonce = getRandomBytes(sizeof(Nonce))
let plaintext = cast[seq[byte]]("hello")
let (mac, ciphertext) = crypto_lock(sharedKey, nonce, plaintext)
```

Decrypt a message using a symmetric key:

```nim
let decrypted = crypto_unlock(sharedKey, nonce, mac, ciphertext)
defer: crypto_wipe(decrypted)
```

Sign a message:

```nim
let publicKey = crypto_sign_public_key(secretKey)
let message = cast[seq[byte]]("hello")
let signature = crypto_sign(secretKey, publicKey, message)
```

Hash a byte array or a string:

```nim
let hashOfBytes = crypto_blake2b([1u8, 2u8, 3u8])
let hashOfString = crypto_blake2b("hello")
```

Timing-safe comparisons for byte arrays of length 16, 32 or 64:

```nim
let hash1 = crypto_blake2b("one")
let hash2 = crypto_blake2b("two")
let hashesAreEqual = crypto_verify(hash1, hash2) # false
```

[Monocypher]: https://monocypher.org
[manual]: https://monocypher.org/manual/
[Nim]: https://nim-lang.org
[sysrandom]: https://github.com/euantorano/sysrandom.nim
