<?php
define('AUTH_KEY',         'mets une phrase unique ici');
define('SECURE_AUTH_KEY',  'mets une phrase unique ici');
define('LOGGED_IN_KEY',    'mets une phrase unique ici');
define('NONCE_KEY',        'mets une phrase unique ici');
define('AUTH_SALT',        'mets une phrase unique ici');
define('SECURE_AUTH_SALT', 'mets une phrase unique ici');
define('LOGGED_IN_SALT',   'mets une phrase unique ici');
define('NONCE_SALT',       'mets une phrase unique ici');
/** Préfixe de table dans la base de données */
$table_prefix = 'wp_';
/** Mode debug */
define( 'WP_DEBUG', false );
/* C’est tout, ne touchez pas à ce qui suit ! */
/** Chemin absolu vers le dossier WordPress. */
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

/** Réglage des variables de WordPress et de ses fichiers inclus. */
require_once ABSPATH . 'wp-settings.php';
