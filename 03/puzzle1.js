#!/usr/bin/env node
const fs = require('fs');

try {
    const data = fs.readFileSync('input.txt', 'utf8')
    report = data.split('\n');
    console.log("Report data: ", report);

    // If there are more 1s than 0s, then sum > length/2
    // If there are more 0s than 1s, then sum < length/2

    // Get sum of each position
    let sums = []
    report.forEach(value => {
        value.split('').forEach((digit, index) => {
            if (!sums[index]) {
                sums[index] = {
                    length: 0,
                    sum: 0
                };
            }
            sums[index]['sum'] = sums[index]['sum'] + parseInt(digit);
            sums[index]['length']++;
        });
    });
    
    console.log("sums", sums);

    // Get most common digit in each position
    let gammaRateBinary =
        sums.map(positionSummary => {
            return moreCommonDigit(positionSummary);
        }).join('');

    // The least most common digit is just the inverse of the most common, so invert the gamma rate
    let epsilonRate = invertGammaRate(gammaRateBinary);

    console.log("gamma rate (binary): ", gammaRateBinary);
    console.log("epsilon rate (binary): ", epsilonRate);

    // Convert binary to decimal
    console.log("gamma rate (decimal): ", parseInt(gammaRateBinary, 2));
    console.log("epsilon rate (decimal): ", parseInt(epsilonRate, 2));
    console.log("gamma*epsilon: ", parseInt(gammaRateBinary, 2)*parseInt(epsilonRate, 2));
} catch (err) {
    console.error(err)
}

function moreCommonDigit(positionSummary) {
   let {length, sum} = positionSummary
   return sum > length/2 ? '1' : '0';
}

function invertGammaRate(gammaRateBinary) {
    return gammaRateBinary
        .toString()
        .split('')
        .map((digit) => {
            return digit == '1' ? '0' : '1'
        })
        .join('')
}