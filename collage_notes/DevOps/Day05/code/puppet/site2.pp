# Install Apache2 package
package { 'nginx':
    ensure => installed
}

# Ensure Apache2 service is running and starts on boot
service { 'nginx':
    ensure    => running, # start the service
    enable    => true, # enable the service for autostart
    require   => Package['nginx'],  # Wait for package installation
}
