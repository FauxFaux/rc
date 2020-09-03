#!/usr/bin/env node

const toKill = process.argv.slice(2).map(x => new RegExp(`^${x}\$`));
const fs = require('fs');
const lock = JSON.parse(fs.readFileSync(process.argv[2]));

function kill(pkg) {
  for (const [name, obj] of Object.entries(pkg.dependencies || {})) {
    if (toKill.some(rx => name.match(rx))) {
      delete pkg.dependencies[name];
    }
    kill(obj);
  }
}
kill(lock);
fs.writeFileSync(process.argv[2], JSON.stringify(lock, '', 2));

