Write-Information > Write-Host

June Blender writing for [Hey, Scripting Guy! Blog][2]:

> The dilemma was how to fix the harmful aspects of Write-Host (can't suppress,
> capture, or redirect), but keep it from polluting the output stream. And of
> course, the solution must be backward compatible.
>
> This most elegant solution is provided by the information stream and the
> Write-Information cmdlet. The information stream is a new output stream that
> works much like the error and warning streams.

The information stream is a feature of powershell versions 5.x that I missed
when it came out. Thus I have been avoiding using Write-Host in favour of
Write-Verbose since reading about [Write-Host Considered Harmful][1].

If you care about writing reusable automation friendly code, go have a read.

Tags: powershell, streams

[1]: http://www.jsnover.com/blog/2013/12/07/write-host-considered-harmful/
[2]: https://blogs.technet.microsoft.com/heyscriptingguy/2015/07/04/weekend-scripter-welcome-to-the-powershell-information-stream/
