class eapjboss::install {

File {
   ensure    => 'directory',
   owner     => 'jboss',
   group     => 'jboss',
   mode	     => '0700',
}

# Create user jboss
  user { 'jboss':
    name      => 'jboss',    
    ensure    => 'present',
    shell     => '/bin/bash',
 #   passwod   => sha1('hola'),
    home      => '/opt/jboss',
    system    => true, #Makes sure user has uid less than 500
    managehome => true,
  }

  # create jboss directory     
  file { '/opt/jboss/hc':
    require  => User['jboss'],
  }


 # Configure folder rights   
  file { '/opt/jboss':
   require   => User['jboss'],
  }

# Copy over zip file
file { '/opt/jboss/jboss-eap-6.4.0.zip':
  source => 'puppet:///modules/eapjboss/jboss-eap-6.4.0.zip',
  require => File["/opt/jboss"],
  notify => Exec['unzip'],
}


# Extract jboss
exec { 'unzip':
  command     => 'unzip /opt/jboss/jboss-eap-6.4.0.zip -d /opt/jboss/hc/',
  cwd         => '/opt/jboss/',
  user        => 'jboss',
  require     => [File["/opt/jboss/jboss-eap-6.4.0.zip"],File["/opt/jboss/hc"]],
#  refreshonly => true,
} 

}
