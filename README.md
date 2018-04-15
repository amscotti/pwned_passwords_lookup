# Pwned Passwords Lookup
Using the API from `https://api.pwnedpasswords.com/`, will use the range endpoint to look up an hash of your password.

## To Build
* Install Nim v1.8.0
* Run `nimble build`

## To Run
```bash
$ ./pwnedpasswords_lookup
Password to lookup:
Your password was found in the haveibeenpwned.com database
```