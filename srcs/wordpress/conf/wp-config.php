<?php
// ** Réglages MySQL - Votre hébergeur doit vous fournir ces informations. ** //
/** Nom de la base de données de WordPress. */
define( 'DB_NAME', 'BDDtgoudman' );

/** Utilisateur de la base de données MySQL. */
define( 'DB_USER', 'tgoudman' );

/** Mot de passe de la base de données MySQL. */
define( 'DB_PASSWORD', 'millefeuille' );

/** Adresse de l’hébergement MySQL. */
define( 'DB_HOST', 'localhost' );

/** Jeu de caractères à utiliser pour la base de données lors de la création des tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** Type de collation de la base de données. Ne modifiez pas si vous ne savez pas. */
define( 'DB_COLLATE', '' );

/** Clés d’authentification et salage - changez-les pour sécuriser votre site */
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
