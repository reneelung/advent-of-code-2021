#!/usr/bin/env node
const fs = require('fs');

try {
    const data = fs.readFileSync('input.txt', 'utf8')
    let depths = data.split('\n');
    depths = depths.map((val) => {
        return parseInt(val);
    });
    console.log('depth readings:', depths);
    let increased = 0;

    depths.forEach((val, i) => {
        console.log(`Round ${i}:`);                    
        let currentWindow = val + depths[i+1] + depths[i+2];
        let nextWindow = depths[i+1] + depths[i+2] + depths[i+3];
        console.log('current window value:', currentWindow);
        console.log('next window value:', nextWindow);            
        let difference = nextWindow - currentWindow;
        console.log('difference:', difference);
        if (difference > 0) {
            increased++;
            console.log('increased++');
        }        
        console.log('current value of increased', increased);
        console.log('****************************************')
    });

    console.log('Total number of measurements larger than previous:', increased);
} catch (err) {
    console.error(err)
}