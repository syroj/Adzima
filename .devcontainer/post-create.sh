#!/usr/bin/env bash

echo "=== INSTALLING LARAVEL PROJECT ==="

# Create Laravel project if not exists
if [ ! -d "app" ]; then
    composer create-project laravel/laravel app
fi

cd app

echo "=== INSTALLING INERTIA + VUE ==="

composer require inertiajs/inertia-laravel
php artisan inertia:middleware

npm install vue @inertiajs/vue3 @vitejs/plugin-vue
npm install

echo "=== CONFIGURING VITE FOR INERTIA + VUE ==="

cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite'
import laravel from 'laravel-vite-plugin'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
        vue(),
    ],
})
EOF

echo "=== INSTALLING TAILWIND CSS ==="

npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

cat > tailwind.config.js << 'EOF'
module.exports = {
  content: [
    './resources/**/*.blade.php',
    './resources/**/*.js',
    './resources/**/*.vue',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

echo "=== SETTING UP APP.JS ==="

cat > resources/js/app.js << 'EOF'
import './bootstrap';
import { createApp, h } from 'vue'
import { createInertiaApp } from '@inertiajs/vue3'

createInertiaApp({
    resolve: name => require(`./Pages/${name}.vue`),
    setup({ el, App, props, plugin }) {
        createApp({ render: () => h(App, props) })
            .use(plugin)
            .mount(el)
    },
})
EOF

echo "=== DONE ==="
