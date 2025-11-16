## Installation 📩
```sh
npm install
```

<br>


## Development 🚀

**To start development be sure to run this command**
```sh
npm run build --watch
```

<br>

## Adding a package 📦
```sh
npm install {name}
```
**Scripts and styles are both imported in '/src/js/main.js'**
this is because Vite will pick this up and replace the import statement with the corresponding files.

```javascript
// import Swiper JS
import Swiper from 'swiper';

// import Swiper styles
import 'swiper/css';
```

**all done!**
