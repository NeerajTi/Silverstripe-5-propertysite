import { defineConfig } from 'vite'
import { resolve } from 'path'
import fs from 'node:fs';
import inject from "@rollup/plugin-inject";
const path = require('path')

// https://vitejs.dev/config/
export default defineConfig({
    css: {
        preprocessorOptions: {
            scss: {
                quietDeps: true
            }
        }
    },
    plugins: [
        inject({   // => that should be first under plugins array
            $: 'jquery',
            jQuery: 'jquery',
        }),
    ],
    root: path.resolve(__dirname, 'src'),
    resolve: {
        alias: {
            '~bootstrap': path.resolve(__dirname, 'node_modules/bootstrap'),
        }
    },
    build: {
        emptyOutDir: false,
        manifest: true,
        rollupOptions: {
            input: 'src/js/main.js',
            output: {
                dir: '../../public',
                assetFileNames: 'main[extname]',
                chunkFileNames: '[chunks]/[name].[hash].js',
                entryFileNames: 'main.js'
            },
        },
        watch: {
            input: {
                style: "src/scss/style.scss",
                js: "src/js/main.js",
            },
            output: {
                dir: '../../public',
                assetFileNames: 'main[extname]',
                chunkFileNames: '[chunks]/[name].[hash].js',
                entryFileNames: 'main.js'
            },
        }
    },
    server: {
        // host: 'silverstripebootstrap.test',
        // port: 3000,
        // strictPort: true,
        // https: {
        //     key: fs.readFileSync(`/home/vagrant/code/certs/silverstripebootstrap.test.key`),
        //     cert: fs.readFileSync(`/home/vagrant/code/certs/silverstripebootstrap.test.crt`),
        // },
        // hmr: {
        //     host: 'silverstripebootstrap.test',
        // },
        // watch: {
        //     usePolling: true,
        // },
    },
});
