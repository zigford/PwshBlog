Manage a hosts file

Most people have long forgotten the lowly [hosts][1] file, but from time to
time there is still a need to use it.

So I wrote some powershell functions to automate it in a simpler way.

---

Maybe your on a home network with a router that doesn't have dynamic dns. 
Today I had to resort to editing a hosts file to work around a side effect
of enabling on-prem single sign-on with ADFS.

I won't go into too much detail, but to say that if your on a local network
with ADFS, but your using a non domain-joined device, your device will be
redirected to a type of authentication which is incompatible with Windows
Hello or longform@upn type usernames.

The reason this is, is because it uses split DNS to redirect you to the 
appropriate web login on internal vs external.

Anywhoo, a quick workaround is to set a static hosts file record, so that
when your device tries to resolve the hostname, instead of getting one from
DNS, you can specify and force the external Forms based auth at all times.

Normally, I would just edit my Hosts file and be done with it. But I've been
experimenting with Intune and got a bunch of my collegues onto the same non
domain-joined setup. With Intune, you can't do a great deal, but you can
deploy a powershell script.

Thus I wrote a couple of functions, `Get-HostsRecord`, `Set-HostsRecord`
and `Remove-HostsRecord`

You can [download][2] a zipped copy here if your interested.

_As a side, I wrote it on my Macbook, so it's PSCore/Unix compatible_

Enjoy.

Tags: powershell, intune, hostsfile

[1]: https://en.wikipedia.org/wiki/Hosts_(file)
[2]: scripts/Hostsfile.ps1.zip
