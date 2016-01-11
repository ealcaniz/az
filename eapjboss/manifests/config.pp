class eapjboss::config {

  # Grouping the common attributes.
  File {
    ensure	=> directory,
    owner	=> jboss,
    group	=> jboss,
    mode	=> 0700,
  }

  # Create user jboss
  user { 'jboss_user':
    name 	=> $eapjboss::jboss_user,
    ensure	=> present,
    shell	=> '/bin/bash',
    password	=> sha1("$eapjboss::jboss_pass"),
    home	=> $eapjboss::jboss_home,
    system	=> true, #Makes sure user has uid less than 500
    managehome	=> true,
  }

  # change folder rights
  file { 'jboss_home':
   name		=> $eapjboss::jboss_home,
   require	=> User['jboss_user'],
  }

  if $eapjboss::jboss_hc {

    # Configure folder rights   
    file { 'hc':
     name 	=> "$eapjboss::jboss_home/hc",
     require	=> File['jboss_home'],
    }

    # Extract jboss
    exec { 'jboss_unzip_hc':
      command	=> "/usr/bin/unzip $eapjboss::jboss_home/$eapjboss::jboss_install_zip -d $eapjboss::jboss_home/hc",
      cwd	=> $eapjboss::jboss_home,
      path	=> '/usr/bin',
      user	=> $eapjboss::jboss_user,
      require	=> File['hc'],
      unless	=> "test -f $eapjboss::jboss_home/hc/jboss-eap-$eapjboss::jboss_version/version.txt",
    } 

  }

  if $eapjboss::jboss_dc {

    # Configure folder rights   
    file { 'dc':
     name 	=> "$eapjboss::jboss_home/dc",
     require	=> File['jboss_home'],
    }
 
    # Extract jboss
    exec { 'jboss_unzip_dc':
      command	=> "/usr/bin/unzip $eapjboss::jboss_home/$eapjboss::jboss_install_zip -d $eapjboss::jboss_home/dc",
      cwd	=> $eapjboss::jboss_home,
      path	=> '/usr/bin',
      user	=> $eapjboss::jboss_user,
      require	=> File['dc'],
      unless	=> "test -f $eapjboss::jboss_home/dc/jboss-eap-$eapjboss::jboss_version/version.txt",
    } 
  
  }

  # Copy over zip file
  file { 'jboss_zip':
    name 	=> "$eapjboss::jboss_home/$eapjboss::jboss_install_zip",
    source	=> "puppet:///modules/eapjboss/$eapjboss::jboss_install_zip",
    require	=> File['jboss_home'],
  }


}
