# DCrypt

This is a stub application for introducing cryptographic misuse and cryptographic API design.

The stub application is quite simple: You can drop files into the application in order to encrypt or decrypt files. Only the content is encrypted. Encrypted files are named like the original with the `.dcrypt` file extension in addition, e.g., if you encrypt `README.md` it will produce a file `README.md.dcrypt`.

⚠️ This project is for educational purposes only. Do not use this for productive purposes!

## Goals

- Check out and open the project:

  ```sh
  git clone --recursive https://github.com/AppPETs/DCrypt.git
  cd DCrypt
  open DCrypt.xcodeproj
  ```

- Implement encryption and decryption in `DCrypt.swift` by using the [Tafelsalz framework](https://blochberger.github.io/Tafelsalz).

- (Optional) Implement unit tests for encryption and decryption in `DCryptTests.swift`.

- Check if your application can still decrypt files if you quit and relaunch it.

## References

- [Tafelsalz documentation](https://blochberger.github.io/Tafelsalz)
- [The Swift Programming Language](https://docs.swift.org/swift-book/)

## In Action

| Date       | Event                                                      |
| ---------- | ---------------------------------------------------------- |
| 2018-11-16 | [GI DevCamp 2018](https://hamburg.dev-camp.com) (workshop) |

