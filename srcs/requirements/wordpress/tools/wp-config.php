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
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Configuration MySQL à partir des variables d'environnement ** //
define( 'DB_NAME', getenv('DB_NAME') ?: 'wordpress' );
define( 'DB_USER', getenv('DB_USER') ?: 'wpuser' );
define( 'DB_PASSWORD', getenv('DB_PASSWORD') ?: 'wppassword' );
define( 'DB_HOST', getenv('DB_HOST') ?: 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define( 'WP_ALLOW_REPAIR', true );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'vk+o?j;E;lnp;9Zk:o6p1+sP;4<)yN.81n+HuJ||q>H^BcsG-6W<CrX=||_5)gT:' );
define( 'SECURE_AUTH_KEY',  'dnVgp)E_O1g#eJ{1u/<hv-+xYEBJKUq|M]aHWT4s6|JILd+vks>.DVx<ab0$8o-U' );
define( 'LOGGED_IN_KEY',    '];X+|p,+=u0bF^y+7LXh}Ri/)Xb,f?b6MgBF&)=quV1*QM9h%WRm%7)UWV,+^]X7' );
define( 'NONCE_KEY',        'HM=v:Fkul;+l-Bi9Y|rrkF5>R+{M2VssC4*qtB|_+svsWR$Y&o$z%CZ#bi]_aimg' );
define( 'AUTH_SALT',        '|`s0$[>|~1d2;:0g%L^|s!1G}ra4Xp/PQlD~o0]PsIj+#@0z.^1R<}Lr&ED5@A+v' );
define( 'SECURE_AUTH_SALT', '0r/qUnKNfTT]a0c[Jm5LsC9rO4pr M{<wW]+M?EY<kX4#uCqMg)I.7eGVg:g,(Ds' );
define( 'LOGGED_IN_SALT',   'Fr~Nem.$_u4tNMnIo|P[>-madt?;/@f]Ye|%5Wa!{dp2-V,[V<+s]~@zpNY~0kyz' );
define( 'NONCE_SALT',       '2DVe{3ZO7w~XDpm)8q27n9-%Qk-vy/)uodDn]uGDcq-dM7PZ!J+UV$:bs] xk?gi' );

define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );     
define('WP_HOME', 'http://tgoudman.42.fr');
define('WP_SITEURL', 'http://tgoudman.42.fr');

define('WP_CACHE', true);

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
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
?>