class rpmforge {

    $execpath = "/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"
    $url      = "http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm"

    exec { 'rpmforge-key':
        command => "rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt",
        user    => "root",
        cwd     => "/root",
        unless  => "rpm -qa gpg-pubkey* | grep '6b8d79e6'",
        path    => $execpath,
    }

    exec { 'rpmforge-install':
        command => "rpm -Uvh $url",
        user    => "root",
        cwd     => "/root",
        path    => $execpath,
        unless  => "rpm -qa | grep rpmforge",
        require => Exec['rpmforge-key']
    }
}
