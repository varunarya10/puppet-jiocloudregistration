# these parameters need to be accessed from several locations and
# should be considered to be constant
class jiocloud_registration::params {

  $logdir = '/var/log/horizon'
   case $::osfamily {
    'RedHat': {
      $http_service                = 'httpd'
      $http_modwsgi                = 'mod_wsgi'
      $config_file                 = '/etc/jiocloud-registration-service/keystone_settings.py'
      $httpd_config_file           = '/etc/httpd/conf.d/jiocloud-registration-service.conf'
      $httpd_listen_config_file    = '/etc/httpd/conf/httpd.conf'
      $root_url                    = '/horizonreg'
      $apache_user                 = 'apache'
      $apache_group                = 'apache'
    }
    'Debian': {
      $http_service                = 'apache2'
      $config_file                 = '/etc/jiocloud-registration-service/keystone_settings.py'
      $httpd_config_file           = '/etc/httpd/conf.d/jiocloud-registration-service.conf'
      $httpd_listen_config_file    = '/etc/apache2/ports.conf'
      $root_url                    = '/horizonreg'
      case $::operatingsystem {
        'Debian': {
            $apache_user           = 'www-data'
            $apache_group          = 'www-data'
        }
        default: {
            $apache_user           = 'horizon'
            $apache_group          = 'horizon'
        }
      }
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat and Debian")
    }
  }
}
