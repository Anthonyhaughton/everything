
add-content -path c:/users/ahaughton/.ssh/config -value @'

Host ${hostname}
    HostName ${hostname}
    User ${user}
    IdentityFile ${indentityfile}
'@