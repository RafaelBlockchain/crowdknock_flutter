// web/flutter.js

(function() {
  let script = document.createElement('script');
  script.src = 'main.dart.js';
  script.defer = true;
  document.body.appendChild(script);
})();

