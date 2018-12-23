Downgrade Gentoo from testing to stable

At some point in my main Gentoo boxes life I added the ~amd64 keyword into 
my make.conf. I don't remeber why I did this, but I can't think of a reason
I need my entire install to be bleeding edge.

I did some googling around on the best approach to achieve this and from
what I read on forums, having a bunch of testing packages downgrade to 
stable is not such a good idea. 

One reason might be that per app config files are usually only designed to 
be backward compatible, not forward compatible.

At any rate, the idea is to gather a list of currently installed testing
packages and add them to package.keywords for their current version.

With this method, eventually those packages will become stable.

The method I used is basically from the [sabayon wiki](https://wiki.sabayon.org/index.php?title=HOWTO:_Switch_from_Test_to_Stable_Packages) with a few
tweaks.

1. First, edit make.conf ACCEPT_KEYWORDS to:

        ACCEPT_KEYWORDS=amd64

2. Now use equery, sed and grep to construct a new packge.keywords

        equery -C -N list -F '=$cpv $mask2' '*' | \
            grep \~ | sed 's/\[~amd64 keyword\]/~amd64/' > \
            /etc/portage/package.keywords/testpackages
_Basically I added '-C' to remove colours and grep_

3. Examine testpackages for sanity, and then test with a world upgrade.

        emerge --ask --update --newuse --deep --with-bdeps=y @world

        These are the packages that would be merged, in order:

        Calculating dependencies... done!

        Nothing to merge; quitting.


Tags: gentoo, portage
