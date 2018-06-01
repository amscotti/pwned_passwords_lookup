import
  httpclient, terminal, sequtils, std/sha1, strutils

type
  PasswordHash = tuple[prefix: string, suffix: string]

const
  APIEndpoint = "https://api.pwnedpasswords.com/range/"


proc getPassword(): PasswordHash =
  var password: TaintedString = ""
  discard readPasswordFromStdin(prompt = "Password to lookup: ", password)

  let hash = secureHash(password)
  return (prefix: ($hash)[0..<5], suffix: ($hash)[5..^1])


proc lookupPassword(hashPassword: PasswordHash): bool =
  result = false

  let client = newHttpClient()
  let response = client.get(APIEndpoint & hashPassword.prefix)
  if response.code.is2xx:
    let hashLines = response.body.splitLines()
    result = hashLines.any(proc (x: string): bool = hashPassword.suffix == x.split(":")[0])


when isMainModule:
  let found = getPassword().lookupPassword()
  if found:
    echo "Your password was found in the haveibeenpwned.com database."
  else:
    echo "Looks like your password wasn't found in the haveibeenpwned.com database!"
