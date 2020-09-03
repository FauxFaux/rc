#!/usr/bin/env node

const fs = require('fs');
const lock = JSON.parse(fs.readFileSync(process.argv[2]));
for (const [name, obj] of Object.entries(lock.dependencies)) {
    if (obj.dev) {
        delete lock.dependencies[name];
    }
}
fs.writeFileSync(process.argv[2], JSON.stringify(lock, '', 2));

