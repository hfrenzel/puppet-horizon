# these parameters need to be accessed from several locations and
# should be considered to be constant
class horizon::params {
  include ::openstacklib::defaults
  $pyvers = $::openstacklib::defaults::pyvers

  $logdir                 = '/var/log/horizon'
  $django_wsgi            = '/usr/share/openstack-dashboard/openstack_dashboard/wsgi.py'
  $manage_py              = '/usr/share/openstack-dashboard/manage.py'
  $wsgi_application_group = '%{GLOBAL}'

  case $::osfamily {
    'RedHat': {
      $http_service                = 'httpd'
      $http_modwsgi                = 'mod_wsgi'
      $package_name                = 'openstack-dashboard'
      $config_file                 = '/etc/openstack-dashboard/local_settings'
      $httpd_config_file           = '/etc/httpd/conf.d/openstack-dashboard.conf'
      $httpd_listen_config_file    = '/etc/httpd/conf/httpd.conf'
      $root_url                    = '/dashboard'
      $static_path                 = '/usr/share'
      $apache_user                 = 'apache'
      $apache_group                = 'apache'
      $wsgi_user                   = 'apache'
      $wsgi_group                  = 'apache'
      $memcache_package            = "python${pyvers}-memcached"
    }
    'Debian': {
      $http_service                = 'apache2'
      $config_file                 = '/etc/openstack-dashboard/local_settings.py'
      $httpd_listen_config_file    = '/etc/apache2/ports.conf'
      $root_url                    = '/horizon'
      $static_path                 = '/var/lib'
      $apache_user                 = 'www-data'
      $apache_group                = 'www-data'
      $wsgi_user                   = 'horizon'
      $wsgi_group                  = 'horizon'
      $memcache_package            = "python${pyvers}-memcache"
      case $::os_package_type {
        'debian': {
            $package_name          = 'openstack-dashboard-apache'
            $httpd_config_file     = '/etc/apache2/sites-available/openstack-dashboard-alias-only.conf'
        }
        default: {
            $package_name          = 'openstack-dashboard'
            $httpd_config_file     = '/etc/apache2/conf-available/openstack-dashboard.conf'
        }
      }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, \
module ${module_name} only support osfamily RedHat and Debian")
    }
  }
}
