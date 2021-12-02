#!/usr/bin/env node
const fs = require('fs');

try {
    const data = fs.readFileSync('input.txt', 'utf8')
    let depths = data.split('\n');
    depths = depths.map((val) => {
        let [direction, magnitude] = val.split(' ');        
        return [direction, direction == 'up' ? -magnitude : parseInt(magnitude)];
    });

    let xPos = 0, zPos = 0, aim = 0;

    depths.forEach((value) => {
        console.log("current horizontal: ", xPos);
        console.log("current depth: ", zPos);
        console.log("current aim: ", aim);
        let [direction, magnitude] = value;
        switch (direction) {
            case "forward":                
                xPos = xPos + magnitude;
                zPos = zPos + (aim * magnitude)                
                break;
            default:
                aim = aim + magnitude;
                break;
        }
        console.log("direction: ", direction);
        console.log("magnitude: ", magnitude);
        console.log("new horizontal: ", xPos);
        console.log("new depth: ", zPos);
        console.log("new aim: ", aim);
        console.log("********************");
    });
    console.log("final horizontal: ", xPos);
    console.log("final depth: ", zPos);
    console.log("horizontal*depth", (xPos*zPos));
} catch (err) {
    console.error(err)
}