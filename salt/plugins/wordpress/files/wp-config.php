{% set mysql_database_host = salt.pillar.get('mysql_database_host') %}
{% set mysql_database_name = salt.pillar.get('mysql_database_name') %}
{% set mysql_database_user = salt.pillar.get('mysql_database_user') %}
{% set mysql_database_pass = salt.pillar.get('mysql_database_pass') %}

{% set wp_auth_key = salt.pillar.get('wp_auth_key') %}
{% set wp_secure_auth_key = salt.pillar.get('wp_secure_auth_key') %}
{% set wp_logged_in_key = salt.pillar.get('wp_logged_in_key') %}
{% set wp_nonce_key = salt.pillar.get('wp_nonce_key') %}
{% set wp_auth_salt = salt.pillar.get('wp_auth_salt') %}
{% set wp_secure_auth_salt = salt.pillar.get('wp_secure_auth_salt') %}
{% set wp_logged_in_salt = salt.pillar.get('wp_logged_in_salt') %}
{% set wp_nonce_salt = salt.pillar.get('wp_nonce_salt') %}

<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', "{{ mysql_database_name }}" );

/** MySQL database username */
define( 'DB_USER', "{{ mysql_database_user }}" );

/** MySQL database password */
define( 'DB_PASSWORD', "{{ mysql_database_pass }}" );

/** MySQL hostname */
define( 'DB_HOST', "{{ mysql_database_host }}" );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         "{{ wp_auth_key }}" );
define( 'SECURE_AUTH_KEY',  "{{ wp_secure_auth_key }}" );
define( 'LOGGED_IN_KEY',    "{{ wp_logged_in_key }}" );
define( 'NONCE_KEY',        "{{ wp_nonce_key }}" );
define( 'AUTH_SALT',        "{{ wp_auth_salt }}" );
define( 'SECURE_AUTH_SALT', "{{ wp_secure_auth_salt }}" );
define( 'LOGGED_IN_SALT',   "{{ wp_logged_in_salt }}" );
define( 'NONCE_SALT',       "{{ wp_nonce_salt }}" );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
  define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
