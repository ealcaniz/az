node default {
  #include stdlib

  $eapjboss_user = jboss
  $eapjboss_pass = "TNhg1kZ"
  $eapjboss_home = '/opt/jboss'
  $eapjboss_install_zip = 'jboss-eap-6.4.0.zip'
  $eapjboss_version = 6.4
  $eapjboss_hc = true
  $eapjboss_dc = true


  class { 'eapjboss':
    jboss_user	=> $eapjboss_user,
    jboss_pass	=> $eapjboss_pass,
    jboss_home	=> $eapjboss_home,
    jboss_version => $eapjboss_version,
    jboss_install_zip => $eapjboss_install_zip,
    jboss_hc 	=> $eapjboss_hc,
    jboss_dc 	=> $eapjboss_dc,
  }

}
