Ip addresses on your subnet with xargs

[xargs](tag_xargs.html) strikes again. This time I'm going to use it's parallel
feature to ping 255 machines very quickly. xargs has a parem `-Px` where x is 
the number of parallel processes to spawn of the subsequent process. 

---

Together with the bash `{1..255}` expression that expands to output 1 to 255, we
can do something like this
    
    $ s=192.168.11.
    $ echo ${s}{1..254} | xargs -P254 -d' ' -L1 ping -c1 -w1 $_ | grep 'bytes from'

In this example, `-P254` tells xargs to spawn 254 procceses, `-d' '` says to 
split commands with a space instead of the normal newline, and `-L1` says to 
finish building the command after `1` amount of input.

To achieve the same result in powershell is not quite as simple. Out of the box
you could use a `ForeEach-Object` loop like so:


    PS> $s='192.168.11.'
    PS> echo $s[1..254] | %{ Test-Connection $_ -Count 1 -TTL 1 -EA SilentlyContinue }

But it's just a sequential loop. Instead we are going to have to leverage 
the .Net [ping](docs.microsoft.com/dotnet/api/system.net.networkinformation.ping)
class.

Lee Holmes [shared](https://twitter.com/Lee_Holmes/status/646890380995067904) 
this on twitter back in 2015:

> Sweep a /16 in 30s: 
>
>               $t=$ips|%{
>                   (New-Object Net.NetworkInformation.Ping).SendPingAsync($_,250)};
>                   [Threading.Tasks.Task]::WaitAll($t);
>                   $t.Result

Before you run this, build out an array of ips, like so:

    PS> $ips=[1..254] | %{"192.168.11.$_"}

This use of powershell seems a bit too obtuse for me, and not something likely
to stick in my head. 

I did find other ways to do it in powershell. A collegue of mine Darryl, 
[dardie](https://github.com/dardie) on github added [this](https://github.com/zigford/USC-SCCM/commit/d9813d5626cbb52201541a574a0adf51e99466d8#diff-73c8dfd0435ecc73e3fc408a851841c2)
commit to a module I maintain which has pretty good results. Again however not
something you could commit to memory as you need to write a function to use it.

## Final thoughts

In this case it looks to me like bash wins, if not in performance, but by being
simpler to implement and commit to memory, or recreate from memory. But if I
ever need to do this in powershell again, I can just come back to my site for
reference.

If you have any comments or feedback, please [email](mailto:jesse@zigford.org) me
and let me know if you will allow your feedback to be posted here.

Tags: bash-v-powershell, powershell, xargs, bash, ping
