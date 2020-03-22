var Main = require('./output/Main');

function main () {
  Main.main();
}

if (module.hot) {
  module.hot.accept(function () {
    main();
  });
}

main();
