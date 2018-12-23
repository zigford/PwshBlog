Gentoo local overlay

I find myself having to create a local overlay to test/develop a new ebuild
without affecting my main system from time to time. I usually fire up a clean
kvm Gentoo guest to start working on, but I've usually forgotten the proceedure

This is a quick instruction on a straight-forward local overlay

1. Create the local path tree where the overlay will reside:

        mkdir -p /usr/local/portage/overlay/{metadata,profiles}

2. Create the `layout.conf` file and `repo_name` file

        cd /usr/local/portage/overlay
        echo "masters = gentoo" > metadata/layout.conf
        echo  "$(hostname)" > profiles/repo_name

3. Create a repos.conf file:

        cat <<EOF>/etc/portage/repos.conf/$(hostname).conf
        [$(hostname)]
        location = /usr/local/portage/overlay
        auto-sync = no
        priority = 10
        EOF

## done.

Now you can begin to populate the local repo with custom ebuilds. I usually do
this and then upload my new ebuild to my [github][1] repository.

See also:

[repos.conf][2], [Custom Repository][3]

Tags: gentoo, portage-overlay

[1]: https://github.com/zigford/gentoo-zigford
[2]: https://wiki.gentoo.org/wiki//etc/portage/repos.conf
[3]: https://wiki.gentoo.org/wiki/Custom_repository
