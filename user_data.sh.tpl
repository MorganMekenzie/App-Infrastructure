#!/bin/bash

#update the instance
sudo apt-get -y update
#install latest version of WP-CLI
# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# chmod +x wp-cli.phar
# sudo mv wp-cli.phar /usr/local/bin/wp

#install the latest version of jq
sudo apt-get install jq -y

export AWS_DEFAULT_REGION="us-east-2"


#getting the wp username and password for secret manager
username=$(aws secretsmanager get-secret-value --secret-id WordPress_DB_Credentials --query SecretString --output text | jq ".wordpress_username")
password=$(aws secretsmanager get-secret-value --secret-id WordPress_DB_Credentials --query SecretString --output text | jq ".wordpress_password")



#Creating the wp_config.php file
cat <<EOT >> /var/www/challenge-week/wp-config.php
<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress_db' );

/** Database username */
define( 'DB_USER', $username );

/** Database password */
define( 'DB_PASSWORD', $password );

/** Database hostname */
define( 'DB_HOST', '${db_hostname}' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'hN0q<iqRdS+1=gFy7/z=KR,uht,[{5 TdDuu])9g(oMKK@894~7D3Yv4:-T-FdJ`' );
define( 'SECURE_AUTH_KEY',  '=n054 T*;MpsnoTQNpjcGE`qJ%Q0vwVUjjqBHag>AY}3dhyav^knig8b ]8Zq^-b' );
define( 'LOGGED_IN_KEY',    'Av{,./e|`[YEKIm/&Z8PUJ6NKNLPH+CvyMh/;f-o7U5er3`sX+4@H2)8k#tie>5$' );
define( 'NONCE_KEY',        'F(b$`88VE++.A8=j<0CyoZD>yg4`4eSSpJr!c~XXLvlp]5{Zlq4k_}hAXP,w5LXX' );
define( 'AUTH_SALT',        '%$0Ww-*G-2M9Rm|ELq5*h{?.0~>Y!Qsb[0&,%Mfwud~>vTFjl,10{tja|Kt-S_ <' );
define( 'SECURE_AUTH_SALT', 'X|-{bVp?vM{$<1v@iwx1TGj;V8FQR|wT&n}Sn!Ixg(%d4H(8tVH*-P3PZtz(h)x.' );
define( 'LOGGED_IN_SALT',   '_Aa;mSj1Gz=v,bslPrx5py+l3|5b!4j-21k9Zr^E9WX@K!T+*{k0UG$mu)z>NULu' );
define( 'NONCE_SALT',       'EI`w~&JradY+)2@mB(tQ {a&*mt$.Iw@n2l$Nj$_Y,2D8,&XEnn?0?U22``u)oH+' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
\$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
EOT

#restarting the appache
service apache2 restart