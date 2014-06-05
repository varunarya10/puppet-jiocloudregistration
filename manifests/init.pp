# == Class: horizon
#
# Installs Horizon dashboard with Apache
#
# === Parameters
#
#  [*secret_key*]
#    (required) Secret key. This is used by Django to provide cryptographic
#    signing, and should be set to a unique, unpredictable value.
#
class jiocloud_registration(
  $fqdn,
  $listen_ssl,
  $horizon_key,
  $horizon_cert,
  $horizon_ca,
  $keystone_public_port,
  $keystone_admin_token,
  $package_ensure = "present",
  $default_project_name = "demo",
  $default_role_name = "_member_",
  $default_domain_name = "Default",
  $project_name_prefix = "project_",
  $settings_template = 'jiocloud_registration/keystone_settings.py.erb',
  $package_name      = 'jiocloud-registration-service',
) {

  include ::jiocloud_registration::params

  package { $::jiocloud_registration::package_name:
    ensure  => $package_ensure,
  }

  file { $::jiocloud_registration::params::config_file:
    content => template($settings_template),
    mode    => '0644',
  }

  if $configure_apache {
    class { 'jiocloud_registration::wsgi::apache':
      bind_address => $bind_address,
      listen_ssl   => $listen_ssl,
      horizon_cert => $horizon_cert,
      horizon_key  => $horizon_key,
      horizon_ca   => $horizon_ca,
    }
  }
}
