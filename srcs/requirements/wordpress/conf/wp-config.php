<?php

define( 'DB_NAME', getenv('SQL_DATABASE') );
define( 'DB_USER', getenv('SQL_USER') );
define( 'DB_PASSWORD', getenv('SQL_PASSWORD') );
define( 'DB_HOST', 'mariadb:3306' );


/** Clés uniques d’authentification et salage */
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
/** Mode debug de WordPress */
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

/** Réglage des variables de WordPress et inclusion des fichiers nécessaires */
require_once ABSPATH . 'wp-settings.php';
